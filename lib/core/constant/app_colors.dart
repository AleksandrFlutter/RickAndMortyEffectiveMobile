// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Основные цвета
  static const Color primary = Color(0xFF405DE6);
  static const Color secondary = Color(0xFF5851DB);
  static const Color accent = Color(0xFFFD1D1D);
  static const Color gradientStart = Color(0xFF405DE6);
  static const Color gradientMiddle = Color(0xFF5851DB);
  static const Color gradientEnd = Color(0xFFFD1D1D);

  // Светлая тема
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF000000);
  static const Color lightOnSurface = Color(0xFF000000);
  static const Color lightDivider = Color(0xFFDBDBDB);
  static const Color lightBorder = Color(0xFFDBDBDB);
  static const Color lightHint = Color(0xFF8E8E8E);
  static const Color lightDisabled = Color(0xFFC7C7CC);

  // Темная тема
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkDivider = Color(0xFF262626);
  static const Color darkBorder = Color(0xFF262626);
  static const Color darkHint = Color(0xFF8E8E8E);
  static const Color darkDisabled = Color(0xFF6D6D6D);

  // Общие цвета
  static const Color error = Color(0xFFED4956);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Градиенты (как в Instagram)
  static const List<Color> storyGradient = [
    Color(0xFF405DE6),
    Color(0xFF5851DB),
    Color(0xFF833AB4),
    Color(0xFFC13584),
    Color(0xFFE1306C),
    Color(0xFFFD1D1D),
    Color(0xFFF56040),
    Color(0xFFF77737),
    Color(0xFFFCAF45),
    Color(0xFFFFDC80),
  ];

  static const List<Color> buttonGradient = [
    Color(0xFF405DE6),
    Color(0xFF5851DB),
    Color(0xFF833AB4),
    Color(0xFFC13584),
    Color(0xFFE1306C),
    Color(0xFFFD1D1D),
  ];
}
