import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/navigation_bloc.dart';
import 'package:rick_and_morty/bloc/navigation_event.dart';
import 'package:rick_and_morty/bloc/navigation_state.dart';
import 'presentation/screens/characters/characters_screen.dart';
import 'presentation/screens/favorites/favorites_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';

/// Основной макет приложения с BottomNavigationBar
/// Управляет навигацией между тремя основными экранами:
/// - Список персонажей
/// - Избранное
/// - Настройки
class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      // Слушает изменения состояния навигации и обновляет UI при их изменении
      builder: (context, state) {
        return Scaffold(
          // Используем IndexedStack вместо обычного переключения,
          // чтобы сохранять состояние каждого экрана
          body: _getPage(state.currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            // Устанавливаем текущий активный индекс
            currentIndex: state.currentIndex,
            // Обрабатываем нажатия на элементы навигации
            onTap: (index) {
              switch (index) {
                case 0:
                  context.read<NavigationBloc>().add(NavigateToCharacters());
                  break;
                case 1:
                  context.read<NavigationBloc>().add(NavigateToFavorites());
                  break;
                case 2:
                  context.read<NavigationBloc>().add(NavigateToSettings());
                  break;
              }
            },
            // Определяем элементы нижней панели навигации
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Список'),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Избранное',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настройки',
              ),
            ],
          ),
        );
      },
    );
  }

  /// Возвращает виджет текущего экрана на основе индекса
  /// Использует IndexedStack для сохранения состояния всех экранов
  /// (в отличие от обычного if/else, где экраны пересоздаются при переключении)
  Widget _getPage(int currentIndex) {
    return IndexedStack(
      index: currentIndex,
      // Все три экрана остаются в памяти, что предотвращает потерю состояния
      // (например, позиции скролла в списке персонажей или данных в избранном)
      children: const [
        CharactersScreen(),
        FavoritesScreen(),
        SettingsScreen(),
      ],
    );
  }
}