import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/data/local/database/app_database.dart';

/// Репозиторий для работы с настройками приложения
/// Обеспечивает доступ к данным темы
class SettingsRepository {
  /// Локальная база данных для хранения настроек
  final AppDatabase _db;

  /// Создает репозиторий с подключением к базе данных
  SettingsRepository(this._db);

  /// Получает текущее состояние темной темы
  /// Возвращает true если темная тема включена, false если светлая
  Future<bool> isDarkModeEnabled() async {
    return await _db.getIsDarkMode();
  }

  /// Устанавливает режим темной темы
  /// [isDark] - true для включения темной темы, false для светлой
  Future<void> setDarkMode(bool isDark) async {
    debugPrint('setDarkMode  isDark = $isDark');
    await _db.setDarkMode(isDark);
  }
}
