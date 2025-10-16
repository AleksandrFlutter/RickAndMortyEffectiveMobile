import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/data/local/database/character_dao.dart';
import 'package:rick_and_morty/data/local/database/favorite_dao.dart';
import 'package:rick_and_morty/data/local/database/theme_settings_dao.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';

part 'app_database.g.dart';

/// Основная база данных приложения, объединяющая все таблицы
/// Использует Drift (ранее Moor) для типобезопасной работы с SQLite
@DriftDatabase(tables: [CharactersDao, FavoritesDao, ThemeSettingsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Версия схемы базы данных (для миграций)
  @override
  int get schemaVersion => 1;

  // !---------------------------------------------------------
  // РЕАКТИВНЫЕ МЕТОДЫ (Stream) — для автоматического обновления UI при изменении данных

  /// Возвращает Stream со всеми персонажами, отсортированными по ID
  /// Используется на главном экране для реактивного обновления списка
  /// (например, при переключении избранного на другом экране)
  Stream<List<CharacterEntities>> watchAllCharactersSortedById() {
    return (select(charactersDao)..orderBy([(c) => OrderingTerm.asc(c.id)]))
        .join([
          leftOuterJoin(
            favoritesDao,
            favoritesDao.characterId.equalsExp(charactersDao.id),
          ),
        ])
        .watch() // ← ключевой метод для реактивности
        .map(
          (rows) => rows.map((row) {
            final char = row.readTable(charactersDao);
            // Проверяем наличие записи в таблице избранного
            final isFav = row.readTableOrNull(favoritesDao) != null;
            return CharacterEntities(
              id: char.id,
              name: char.name,
              status: char.status,
              species: char.species,
              locationName: char.locationName,
              imageUrl: char.imageUrl,
              isFavorite: isFav,
            );
          }).toList(),
        );
  }

  /// Возвращает Stream только с избранными персонажами, отсортированными по имени
  /// Используется на экране "Избранное"
  Stream<List<CharacterEntities>> watchFavoriteCharacters() {
    return (select(charactersDao)..orderBy([(c) => OrderingTerm.asc(c.name)]))
        .join([
          innerJoin(
            favoritesDao,
            favoritesDao.characterId.equalsExp(charactersDao.id),
          ),
        ])
        .watch()
        .map(
          (rows) => rows.map((row) {
            final char = row.readTable(charactersDao);
            return CharacterEntities(
              id: char.id,
              name: char.name,
              status: char.status,
              species: char.species,
              locationName: char.locationName,
              imageUrl: char.imageUrl,
              isFavorite: true, // всегда true для избранных
            );
          }).toList(),
        );
  }

  //---------------------------------------------------------------

  // НЕРЕАКТИВНЫЕ МЕТОДЫ (Future) — для первоначальной загрузки и фоновых операций

  /// Сохраняет список персонажей в базу данных (upsert — обновление или вставка)
  /// Используется при первоначальной загрузке данных с API
  Future<void> upsertCharacters(List<CharacterEntities> chars) async {
    debugPrint('chars = ${chars.length}');

    try {
      // Вставка по одному (можно оптимизировать через batch)
      for (final c in chars) {
        await into(charactersDao).insertOnConflictUpdate(
          CharactersDaoCompanion(
            id: Value(c.id),
            name: Value(c.name),
            status: Value(c.status),
            species: Value(c.species),
            locationName: Value(c.locationName),
            imageUrl: Value(c.imageUrl),
          ),
        );
      }
    } catch (e, st) {
      debugPrint('Ошибка: $e\n$st');
    }
  }

  /// Получает всех персонажей из БД (без реактивности)
  /// Используется в репозитории как fallback при ошибке сети
  Future<List<CharacterEntities>> getAllCharactersSortedById() async {
    final rows =
        await (select(
          charactersDao,
        )..orderBy([(c) => OrderingTerm.asc(c.id)])).join([
          leftOuterJoin(
            favoritesDao,
            favoritesDao.characterId.equalsExp(charactersDao.id),
          ),
        ]).get();

    try {
      return rows.map((row) {
        final char = row.readTable(charactersDao);
        final fav = row.readTableOrNull(favoritesDao);
        final isFav = fav != null;
        return CharacterEntities(
          id: char.id,
          name: char.name,
          status: char.status,
          species: char.species,
          locationName: char.locationName,
          imageUrl: char.imageUrl,
          isFavorite: isFav,
        );
      }).toList();
    } catch (e) {
      debugPrint('Ошибка ${e.toString()}');
    }
    return [];
  }

  /// Переключает статус избранного для персонажа
  /// Удаляет из таблицы favorites, если запись существует, иначе добавляет
  Future<void> toggleFavorite(int characterId) async {
    final exists = await (select(
      favoritesDao,
    )..where((f) => f.characterId.equals(characterId))).get();
    if (exists.isNotEmpty) {
      await (delete(
        favoritesDao,
      )..where((f) => f.characterId.equals(characterId))).go();
    } else {
      await into(
        favoritesDao,
      ).insert(FavoritesDaoCompanion(characterId: Value(characterId)));
    }
  }

  // !---------------------------------------------------------
  // МЕТОДЫ ДЛЯ РАБОТЫ С НАСТРОЙКАМИ (ТЕМА)

  /// Получает текущий режим темы из БД
  Future<bool> getIsDarkMode() async {
    final rows = await (select(themeSettingsDao)..limit(1)).get();
    return rows.isNotEmpty ? rows.first.isDarkMode : false;
  }

  /// Сохраняет режим темы в БД (использует фиксированный ID = 1)
  Future<void> setDarkMode(bool isDark) async {
    await into(themeSettingsDao).insertOnConflictUpdate(
      ThemeSettingsDaoCompanion(id: Value(1), isDarkMode: Value(isDark)),
    );
  }

  /// Получает только избранных персонажей (без реактивности)
  /// Может быть заменён вызовом watchFavoriteCharacters().first
  Future<List<CharacterEntities>> getFavoriteCharacters() async {
    final rows =
        await (select(
          charactersDao,
        )..orderBy([(c) => OrderingTerm.asc(c.name)])).join([
          innerJoin(
            favoritesDao,
            favoritesDao.characterId.equalsExp(charactersDao.id),
          ),
        ]).get();

    return rows.map((row) {
      final char = row.readTable(charactersDao);
      return CharacterEntities(
        id: char.id,
        name: char.name,
        status: char.status,
        species: char.species,
        locationName: char.locationName,
        imageUrl: char.imageUrl,
        isFavorite: true,
      );
    }).toList();
  }
}

/// Создаёт подключение к SQLite-базе в фоновом потоке
/// Файл базы хранится в директории приложения
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = p.join(dir.path, 'rm.db');
    return NativeDatabase.createInBackground(File(file));
  });
}
