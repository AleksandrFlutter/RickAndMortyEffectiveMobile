import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/themes/theme_mode.dart';
import 'package:rick_and_morty/repository/settings_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// BLoC для управления темой приложения (светлая/тёмная)
/// Обеспечивает загрузку текущей темы при старте и сохранение выбора пользователя
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  /// Репозиторий для работы с настройками темы в локальной базе данных
  final SettingsRepository _settingsRepository;

  ThemeBloc(this._settingsRepository) : super(ThemeState.initial()) {
    // Регистрация обработчиков событий
    on<ThemeChanged>(_onThemeChanged); // Обработка изменения темы пользователем
    on<ThemeInit>(_onInit);           // Инициализация темы при запуске приложения
  }

  /// Обработчик события инициализации темы
  /// Загружает сохранённый режим темы из локальной базы данных
  Future<void> _onInit(ThemeInit event, Emitter<ThemeState> emit) async {
    // Получаем текущее состояние темы из репозитория
    final isDark = await _settingsRepository.isDarkModeEnabled();
    // Эмитим состояние с соответствующим режимом темы
    emit(ThemeState(mode: isDark ? AppThemeMode.dark : AppThemeMode.light));
  }

  /// Обработчик события изменения темы пользователем
  Future<void> _onThemeChanged(
      ThemeChanged event,
      Emitter<ThemeState> emit,
      ) async {
    // Определяем новый режим темы на основе входного параметра
    final newMode = event.isDark ? AppThemeMode.dark : AppThemeMode.light;
    // Сохраняем выбор пользователя в локальной базе данных
    await _settingsRepository.setDarkMode(event.isDark);
    // Эмитим новое состояние темы
    emit(ThemeState(mode: newMode));
  }
}