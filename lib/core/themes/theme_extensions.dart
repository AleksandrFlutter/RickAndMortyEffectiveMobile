// lib/core/themes/theme_extensions.dart
import 'package:flutter/material.dart';

// Расширение для доступа к теме через BuildContext
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  
  TextTheme get textTheme => Theme.of(this).textTheme;
  
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}

// Расширение для цветов
extension ColorExtension on Color {
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    
    return hslDark.toColor();
  }
  
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    
    return hslLight.toColor();
  }
}