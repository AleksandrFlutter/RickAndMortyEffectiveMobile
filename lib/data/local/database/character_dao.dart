import 'package:drift/drift.dart';

/// Таблица для хранения информации о персонажах
class CharactersDao extends Table {
  /// Уникальный идентификатор персонажа
  IntColumn get id => integer()();

  /// Имя персонажа
  TextColumn get name => text()();

  /// Статус персонажа (жив/мертв/неизвестен)
  TextColumn get status => text()();

  /// Вид персонажа (человек, инопланетянин и т.д.)
  TextColumn get species => text()();

  /// Название последней известной локации персонажа
  TextColumn get locationName => text()();

  /// Ссылка на изображение персонажа
  TextColumn get imageUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}