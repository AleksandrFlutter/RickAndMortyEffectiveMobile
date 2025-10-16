import 'package:drift/drift.dart';

class FavoritesDao extends Table {
  IntColumn get characterId => integer()();

  @override
  Set<Column> get primaryKey => {characterId};
}
