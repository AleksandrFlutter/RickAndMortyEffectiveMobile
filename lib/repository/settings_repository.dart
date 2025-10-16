import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/data/local/database/app_database.dart';

class SettingsRepository {
  final AppDatabase _db;

  SettingsRepository(this._db);

  Future<bool> isDarkModeEnabled() async {
    return await _db.getIsDarkMode();
  }

  Future<void> setDarkMode(bool isDark) async {
    debugPrint('setDarkMode  isDark = $isDark');
    await _db.setDarkMode(isDark);
  }
}
