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

@DriftDatabase(tables: [CharactersDao, FavoritesDao, ThemeSettingsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // !---------------------------------------------------------
  // Все персонажи (для главного экрана)
  Stream<List<CharacterEntities>> watchAllCharactersSortedById() {
    return (select(charactersDao)..orderBy([(c) => OrderingTerm.asc(c.id)]))
        .join([
          leftOuterJoin(
            favoritesDao,
            favoritesDao.characterId.equalsExp(charactersDao.id),
          ),
        ])
        .watch()
        .map(
          (rows) => rows.map((row) {
            final char = row.readTable(charactersDao);
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

  // Только избранные (для экрана "Избранное")
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
              isFavorite: true,
            );
          }).toList(),
        );
  }

  //---------------------------------------------------------------

  // Сохранение персонажей (без избранного)
  Future<void> upsertCharacters(List<CharacterEntities> chars) async {
    debugPrint('chars = ${chars.length}');

    try {
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

  // Получить всех с флагом isFavorite
  Future<List<CharacterEntities>> getAllCharactersSortedById() async {
    final rows =
        await (select(
          charactersDao,
        )..orderBy([(c) => OrderingTerm(expression: c.id)])).join([
          leftOuterJoin(
            favoritesDao,
            favoritesDao.characterId.equalsExp(charactersDao.id),
          ),
        ]).get();

    //debugPrint(' ${rows.length}');
    //debugPrint(' ${rows.toString()}');

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
    List<CharacterEntities> r = [];
    return r;
  }

  // Переключить избранное
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

  Future<bool> getIsDarkMode() async {
    final rows = await (select(themeSettingsDao)..limit(1)).get();
    debugPrint(rows.toString());
    return rows.isNotEmpty ? rows.first.isDarkMode : false;
  }

  Future<void> setDarkMode(bool isDark) async {
    await into(themeSettingsDao).insertOnConflictUpdate(
      ThemeSettingsDaoCompanion(id: Value(1), isDarkMode: Value(isDark)),
    );
  }

  Future<void> insertCharacters(List<CharacterEntities> chars) async {
    await into(charactersDao).insertOnConflictUpdate(
      chars.map(
            (c) => CharactersDaoCompanion(
              id: Value(c.id),
              name: Value(c.name),
              status: Value(c.status),
              species: Value(c.species),
              locationName: Value(c.locationName),
              imageUrl: Value(c.imageUrl),
            ),
          )
          as Insertable<CharactersDaoData>,
    );
  }

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

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = p.join(dir.path, 'rm.db');
    return NativeDatabase.createInBackground(File(file));
  });
}
