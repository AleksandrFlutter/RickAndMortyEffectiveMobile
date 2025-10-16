import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/navigation_bloc.dart';
import 'package:rick_and_morty/bloc/navigation_event.dart';
import 'package:rick_and_morty/bloc/navigation_state.dart';
import 'presentation/screens/characters/characters_screen.dart';
import 'presentation/screens/favorites/favorites_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: _getPage(state.currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
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

  Widget _getPage(int currentIndex) {
    return IndexedStack(
      index: currentIndex,
      children: const [CharactersScreen(), FavoritesScreen(), SettingsScreen()],
    );
  }
}
