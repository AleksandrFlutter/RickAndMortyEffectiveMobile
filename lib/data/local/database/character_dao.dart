import 'package:drift/drift.dart';

class CharactersDao extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text()();

  TextColumn get status => text()();

  TextColumn get species => text()();

  TextColumn get locationName => text()();

  TextColumn get imageUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}
