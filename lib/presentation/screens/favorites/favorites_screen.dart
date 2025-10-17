import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_event.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_state.dart';
import 'package:rick_and_morty/presentation/screens/favorites/widget/show_sort_dialog.dart';
import 'package:rick_and_morty/presentation/widget/character_card.dart';

/// Экран "Избранное" — отображает список персонажей, добавленных в избранное
/// Поддерживает сортировку, удаление и реактивные обновления
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Подписываемся на реактивные обновления из БД и запрашиваем начальные данные
    final favoritesBloc = context.read<FavoritesBloc>();
    favoritesBloc.add(FavoritesWatch());
    favoritesBloc.add(FavoritesLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          // Показываем индикатор загрузки
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // Показываем сообщение, если избранных нет
          else if (state is FavoritesEmpty ||
              (state is FavoritesLoaded && state.characters.isEmpty)) {
            return const Center(child: Text('Нет избранных персонажей'));
          }
          // Отображаем список избранных персонажей
          else if (state is FavoritesLoaded) {
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return Dismissible(
                  key: Key(character.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    // Удаляем персонажа из избранного при свайпе
                    context.read<FavoritesBloc>().add(
                      FavoritesRemoveFromFavorite(character.id),
                    );
                  },
                  child: CharacterCard(
                    character: character,
                    // При нажатии на звёздочку — удаляем из избранного
                    onFavoriteToggle: () {
                      context.read<FavoritesBloc>().add(
                        FavoritesRemoveFromFavorite(character.id),
                      );
                    },
                  ),
                );
              },
            );
          }
          // Для остальных состояний (например, FavoritesInitial) — пустой контейнер
          else {
            return const SizedBox();
          }
        },
      ),
      // Плавающая кнопка для вызова диалога сортировки
      floatingActionButton: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is! FavoritesLoaded) return const SizedBox();
          return FloatingActionButton(
            onPressed: () => showSortDialog(context, state.sortBy),
            child: const Icon(Icons.sort),
          );
        },
      ),
    );
  }
}
