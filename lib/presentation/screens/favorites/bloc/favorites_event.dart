import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_state.dart';

abstract class FavoritesEvent {}

class FavoritesLoadRequested extends FavoritesEvent {}

class FavoritesSortChanged extends FavoritesEvent {
  final FavoritesSortBy sortBy;

  FavoritesSortChanged(this.sortBy);
}

class FavoritesRemoveFromFavorite extends FavoritesEvent {
  final int characterId;

  FavoritesRemoveFromFavorite(this.characterId);
}

class FavoritesWatch extends FavoritesEvent {}
