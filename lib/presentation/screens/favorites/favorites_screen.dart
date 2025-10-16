import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_event.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_state.dart';
import 'package:rick_and_morty/presentation/widget/character_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Запрашиваем избранное при открытии экрана
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
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesEmpty) {
            return const Center(child: Text('Нет избранных персонажей'));
          } else if (state is FavoritesLoaded) {
            if (state.characters.isEmpty) {
              return const Center(child: Text('Нет избранных персонажей'));
            }
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(state.characters[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    context.read<FavoritesBloc>().add(
                      FavoritesRemoveFromFavorite(state.characters[index].id),
                    );
                  },
                  child: CharacterCard(
                    character: state.characters[index],
                    onFavoriteToggle: () {
                      context.read<FavoritesBloc>().add(
                        FavoritesRemoveFromFavorite(state.characters[index].id),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is! FavoritesLoaded) return const SizedBox();
          return FloatingActionButton(
            onPressed: () => _showSortDialog(context, state.sortBy),
            child: const Icon(Icons.sort),
          );
        },
      ),
    );
  }

  void _showSortDialog(BuildContext context, FavoritesSortBy currentSort) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Сортировать по:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              ...FavoritesSortBy.values.map((sortOption) {
                return RadioListTile<FavoritesSortBy>(
                  title: Text('По ${sortOption.label}'),
                  value: sortOption,
                  groupValue: currentSort,
                  onChanged: (value) {
                    if (value != null) {
                      Navigator.pop(context);
                      context.read<FavoritesBloc>().add(
                        FavoritesSortChanged(value),
                      );
                    }
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
