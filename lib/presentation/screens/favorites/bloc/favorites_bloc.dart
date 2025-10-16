import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';
import 'package:rick_and_morty/repository/character_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final CharacterRepository _repository;

  FavoritesBloc(this._repository) : super(FavoritesInitial()) {
    on<FavoritesLoadRequested>(_onLoad);
    on<FavoritesSortChanged>(_onSortChanged);
    on<FavoritesRemoveFromFavorite>(_onRemove);
    on<FavoritesWatch>(_onWatch);
  }


  Future<void> _onWatch(FavoritesWatch event, Emitter<FavoritesState> emit) async {
    await emit.forEach(
      _repository.watchFavorites(),
      onData: (favorites) {
        if (favorites.isEmpty) return FavoritesEmpty();
        return FavoritesLoaded(characters: favorites);
      },
    );
  }

  Future<void> _onLoad(
    FavoritesLoadRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    final favorites = await _repository.getFavorites();
    if (favorites.isEmpty) {
      emit(FavoritesEmpty());
    } else {
      emit(FavoritesLoaded(characters: favorites));
    }
  }

  Future<void> _onSortChanged(
    FavoritesSortChanged event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      List<CharacterEntities> sorted = List.from(currentState.characters);

      switch (event.sortBy) {
        case FavoritesSortBy.name:
          sorted.sort((a, b) => a.name.compareTo(b.name));
          break;
        case FavoritesSortBy.location:
          sorted.sort((a, b) => a.locationName.compareTo(b.locationName));
          break;
        case FavoritesSortBy.status:
          sorted.sort((a, b) => a.status.compareTo(b.status));
          break;
        case FavoritesSortBy.species:
          sorted.sort((a, b) => a.species.compareTo(b.species));
          break;
      }

      emit(currentState.copyWith(characters: sorted, sortBy: event.sortBy));
    }
  }

  Future<void> _onRemove(
    FavoritesRemoveFromFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    // Удаляем из избранного (в БД)
    await _repository.toggleFavorite(event.characterId);

    // Перезагружаем список избранного
    final updatedFavorites = await _repository.getFavorites();

    if (updatedFavorites.isEmpty) {
      emit(FavoritesEmpty());
    } else {

      // Сохраняем текущую сортировку
      if (state is FavoritesLoaded) {
        final currentSort = (state as FavoritesLoaded).sortBy;
        List<CharacterEntities> sorted = List.from(updatedFavorites);

        // Применяем ту же сортировку
        switch (currentSort) {
          case FavoritesSortBy.name:
            sorted.sort((a, b) => a.name.compareTo(b.name));
            break;
          case FavoritesSortBy.location:
            sorted.sort((a, b) => a.locationName.compareTo(b.locationName));
            break;
          case FavoritesSortBy.status:
            sorted.sort((a, b) => a.status.compareTo(b.status));
            break;
          case FavoritesSortBy.species:
            sorted.sort((a, b) => a.species.compareTo(b.species));
            break;
        }

        emit(FavoritesLoaded(characters: sorted, sortBy: currentSort));
      } else {
        emit(FavoritesLoaded(characters: updatedFavorites));
      }
    }
  }
}
