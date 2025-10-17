import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/constant/app_strings.dart';
import 'package:rick_and_morty/core/themes/bloc/theme_bloc.dart';
import 'package:rick_and_morty/core/themes/theme_mode.dart';

/// Экран настроек приложения
/// Позволяет пользователю переключать темную/светлую тему
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          // Слушает изменения состояния темы и обновляет UI при их изменении
          builder: (context, state) {
            // Определяем, включена ли тёмная тема
            final isDark = state.mode == AppThemeMode.dark;
            return SwitchListTile(
              title: const Text(AppStrings.darkTheme),
              value: isDark, // Текущее состояние переключателя
              onChanged: (value) {
                // При изменении состояния отправляем событие в ThemeBloc
                context.read<ThemeBloc>().add(ThemeChanged(value));
              },
              secondary: const Icon(
                Icons.dark_mode,
              ), // Иконка слева от переключателя
            );
          },
        ),
      ),
    );
  }
}
