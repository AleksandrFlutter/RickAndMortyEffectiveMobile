import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/themes/bloc/theme_bloc.dart';
import 'package:rick_and_morty/core/themes/theme_mode.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final isDark = state.mode == AppThemeMode.dark;
            return SwitchListTile(
              title: const Text('Тёмная тема'),
              value: isDark,
              onChanged: (value) {
                context.read<ThemeBloc>().add(ThemeChanged(value));
              },
              secondary: const Icon(Icons.dark_mode),
            );
          },
        ),
      ),
    );
  }
}