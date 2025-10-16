import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/data/local/database/app_database.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';

class CharacterRepository {
  final AppDatabase _db;

  CharacterRepository(this._db);

  /// Загружает персонажей: сначала из API → сохраняет в БД → возвращает из БД (отсортировано по ID)
  Future<List<CharacterEntities>> getCharacters(int page) async {
    try {
      // 1. Загружаем данные из API
      final response = await http
          .get(
            Uri.parse('https://rickandmortyapi.com/api/character?page=$page'),
          )
          .timeout(Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      // 2. Парсим JSON в список сущностей
      final List<CharacterEntities> remoteCharacters = await compute(
        _parseCharactersFromJson,
        response.body,
      );

      // 3. Сохраняем в локальную БД (без перезаписи isFavorite!)
      await _db.upsertCharacters(remoteCharacters);

      // 4. Возвращаем данные ИЗ БАЗЫ, отсортированные по ID
      return await _db.getAllCharactersSortedById();
    } catch (e) {
      // 5. При ошибке (нет интернета и т.п.) — возвращаем кэш из БД
      return await _db.getAllCharactersSortedById();
    }
  }

  // Парсинг в изоляте (синхронно)
  static List<CharacterEntities> _parseCharactersFromJson(String jsonString) {
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final results = data['results'] as List;
    return results.map((j) => CharacterEntities.fromJson(j)).toList();
  }

  /// Переключает избранное (работает оффлайн)
  Future<void> toggleFavorite(int characterId) async {
    await _db.toggleFavorite(characterId);
  }

  Future<List<CharacterEntities>> getFavorites() async {
    return await _db.getFavoriteCharacters();
  }

  //---------------------------------------------------
  Stream<List<CharacterEntities>> watchAllCharacters() =>
      _db.watchAllCharactersSortedById();

  Stream<List<CharacterEntities>> watchFavorites() =>
      _db.watchFavoriteCharacters();
  //--------------------------------------------------
}
