import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/navigation_bloc.dart';
import 'package:rick_and_morty/core/themes/app_themes.dart';
import 'package:rick_and_morty/core/themes/bloc/theme_bloc.dart';
import 'package:rick_and_morty/core/themes/theme_mode.dart';
import 'package:rick_and_morty/data/local/database/app_database.dart';
import 'package:rick_and_morty/main_layout.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty/repository/character_repository.dart';
import 'package:rick_and_morty/repository/settings_repository.dart';

import 'presentation/screens/characters/bloc/characters_bloc.dart';

void main() {
  final db = AppDatabase();
  final characterRepository = CharacterRepository(db);
  final settingsRepository = SettingsRepository(db);

  runApp(
    MyApp(
      settingsRepository: settingsRepository,
      characterRepository: characterRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final SettingsRepository settingsRepository;
  final CharacterRepository characterRepository;

  const MyApp({
    super.key,
    required this.settingsRepository,
    required this.characterRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CharactersBloc(characterRepository)),
        BlocProvider(create: (context) => FavoritesBloc(characterRepository)),
        BlocProvider(create: (context) => ThemeBloc(settingsRepository)),
        BlocProvider(create: (context) => NavigationBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Rick and Morty',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeState.mode == AppThemeMode.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const MainLayout(),
          );
        },
      ),
    );
  }
}
