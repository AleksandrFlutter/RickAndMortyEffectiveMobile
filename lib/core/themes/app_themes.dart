import 'package:flutter/material.dart';

/// Класс, содержащий предопределённые темы приложения: светлую и тёмную
class AppTheme {
  /// Светлая тема приложения, соответствующая Material Design 3
  static final light = ThemeData(
    useMaterial3: true, // Использовать Material Design 3
    brightness: Brightness.light, // Указывает, что тема — светлая
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue, // Базовый цвет темы — синий
    ),
  );

  /// Тёмная тема приложения, соответствующая Material Design 3
  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark, // Указывает, что тема — тёмная
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness:
          Brightness.dark, // Генерирует цветовую схему для тёмного режима
    ),
  );
}
