import 'package:drift/drift.dart';

/// Таблица настроек темы приложения
class ThemeSettingsDao extends Table {
  /// Уникальный идентификатор настроек
  IntColumn get id => integer()();

  /// Флаг темной темы
  BoolColumn get isDarkMode => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}