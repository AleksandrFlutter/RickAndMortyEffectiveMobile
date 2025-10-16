// Таблица
import 'package:drift/drift.dart';

class ThemeSettingsDao extends Table {
  IntColumn get id => integer()();

  BoolColumn get isDarkMode => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}