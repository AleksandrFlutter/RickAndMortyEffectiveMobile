import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/themes/theme_mode.dart';
import 'package:rick_and_morty/repository/settings_repository.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsRepository _settingsRepository;

  ThemeBloc(this._settingsRepository) : super(ThemeState.initial()) {
    on<ThemeChanged>(_onThemeChanged);
    _loadThemeFromDb();
  }

  Future<void> _loadThemeFromDb() async {
    final isDark = await _settingsRepository.isDarkModeEnabled();
    debugPrint('$isDark');
    final mode = isDark ? AppThemeMode.dark : AppThemeMode.light;
    debugPrint('$mode');
    emit(ThemeState(mode: mode));
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    debugPrint('_onThemeChanged ${event.isDark}');

    final newMode = event.isDark ? AppThemeMode.dark : AppThemeMode.light;

    debugPrint('_onThemeChanged newMode = $newMode');

    await _settingsRepository.setDarkMode(event.isDark);
    emit(ThemeState(mode: newMode));
  }
}
