import 'package:drift/drift.dart';

/// Таблица для хранения избранных персонажей
class FavoritesDao extends Table {
  /// ID персонажа, добавленного в избранное
  IntColumn get characterId => integer()();

  @override
  Set<Column> get primaryKey => {characterId};
}