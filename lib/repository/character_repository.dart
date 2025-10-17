import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/data/local/database/app_database.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';

/// Репозиторий для работы с персонажами: загрузка из API, сохранение в БД и управление избранным
class CharacterRepository {
  /// Экземпляр локальной базы данных (Drift)
  final AppDatabase _db;

  CharacterRepository(this._db);

  /// Загружает персонажей с указанной страницы API, сохраняет их в БД и возвращает актуальный список из БД
  /// Поддерживает оффлайн-режим: при ошибке сети возвращает кэшированные данные
  Future<List<CharacterEntities>> getCharacters(int page) async {
    try {
      // 1. Выполняем сетевой запрос к Rick and Morty API
      final response = await http
          .get(
            Uri.parse('https://rickandmortyapi.com/api/character?page=$page'),
          )
          .timeout(Duration(seconds: 10));

      // Проверяем успешность ответа
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      // 2. Парсим JSON-ответ в список сущностей в изоляте (фоновом потоке)
      // Это предотвращает блокировку основного UI-потока при большом объёме данных
      final List<CharacterEntities> remoteCharacters = await compute(
        _parseCharactersFromJson,
        response.body,
      );

      // 3. Сохраняем полученные персонажи в локальную базу данных
      // Важно: при обновлении НЕ перезаписываем флаг isFavorite, чтобы не сбросить выбор пользователя
      await _db.upsertCharacters(remoteCharacters);

      // 4. Возвращаем данные ИЗ БАЗЫ (а не из API!), чтобы гарантировать актуальность флага isFavorite
      return await _db.getAllCharactersSortedById();
    } catch (e) {
      // 5. При любой ошибке (нет интернета, таймаут и т.д.) возвращаем кэш из локальной БД
      return await _db.getAllCharactersSortedById();
    }
  }

  /// Статический метод для парсинга JSON в изоляте (фоновом потоке)
  /// Обеспечивает плавную работу UI даже при обработке большого JSON
  static List<CharacterEntities> _parseCharactersFromJson(String jsonString) {
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final results = data['results'] as List;
    return results.map((j) => CharacterEntities.fromJson(j)).toList();
  }

  /// Переключает статус "избранное" для персонажа по его ID
  /// Работает полностью в оффлайн-режиме, так как оперирует только локальной БД
  Future<void> toggleFavorite(int characterId) async {
    await _db.toggleFavorite(characterId);
  }

  /// Возвращает список только избранных персонажей из локальной БД
  Future<List<CharacterEntities>> getFavorites() async {
    return await _db.getFavoriteCharacters();
  }

  // Реактивные методы: возвращают Stream для автоматического обновления UI при изменении данных

  /// Возвращает поток (Stream) всех персонажей, отсортированных по ID
  /// Используется в BLoC для автоматической перерисовки списка при изменении избранного
  Stream<List<CharacterEntities>> watchAllCharacters() =>
      _db.watchAllCharactersSortedById();

  /// Возвращает поток (Stream) только избранных персонажей
  /// Используется на экране "Избранное" для реактивного обновления списка
  Stream<List<CharacterEntities>> watchFavorites() =>
      _db.watchFavoriteCharacters();
}
