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
  // Создаём единственный экземпляр базы данных
  final db = AppDatabase();

  // Инициализируем репозитории, передавая им общий экземпляр БД
  final characterRepository = CharacterRepository(db);
  final settingsRepository = SettingsRepository(db);

  // Запускаем основное приложение, передавая репозитории через конструктор
  runApp(
    MyApp(
      settingsRepository: settingsRepository,
      characterRepository: characterRepository,
    ),
  );
}

/// Корневой виджет приложения
class MyApp extends StatelessWidget {
  // Репозитории передаются из main для обеспечения единой точки доступа к данным
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
      // Регистрируем все BLoC-ы приложения в дереве виджетов
      providers: [
        // BLoC для управления списком персонажей
        BlocProvider(create: (context) => CharactersBloc(characterRepository)),
        // BLoC для управления избранными персонажами
        BlocProvider(create: (context) => FavoritesBloc(characterRepository)),
        // BLoC для управления темой приложения (светлая/тёмная)
        BlocProvider(
          create: (context) => ThemeBloc(settingsRepository)..add(ThemeInit()),
        ),
        // BLoC для навигации между экранами (BottomNavigationBar)
        BlocProvider(create: (context) => NavigationBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        // Слушаем изменения темы и обновляем MaterialApp при их изменении
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Rick and Morty',
            // Светлая тема по умолчанию
            theme: AppTheme.light,
            // Тёмная тема
            darkTheme: AppTheme.dark,
            // Выбираем текущую тему на основе состояния ThemeBloc
            themeMode: themeState.mode == AppThemeMode.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            // Главный экран приложения с BottomNavigationBar
            home: const MainLayout(),
          );
        },
      ),
    );
  }
}
