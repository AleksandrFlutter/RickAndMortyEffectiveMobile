import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_event.dart';
import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_state.dart';

/// Отображает модальный диалог для выбора критерия сортировки избранных персонажей
void showSortDialog(BuildContext context, FavoritesSortBy currentSort) {
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
