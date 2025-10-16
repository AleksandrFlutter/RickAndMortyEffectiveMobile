import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';

enum FavoritesSortBy {
  name,
  location,
  status,
  species;

  String get label {
    switch (this) {
      case FavoritesSortBy.name:
        return 'Имени';
      case FavoritesSortBy.location:
        return 'Локации';
      case FavoritesSortBy.status:
        return 'Статусу';
      case FavoritesSortBy.species:
        return 'Виду';
    }
  }
}

abstract class FavoritesState extends Equatable {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {
  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoritesState {
  @override
  List<Object> get props => [];
}

class FavoritesLoaded extends FavoritesState {
  final List<CharacterEntities> characters;
  final FavoritesSortBy sortBy;

  const FavoritesLoaded({
    required this.characters,
    this.sortBy = FavoritesSortBy.name,
  });

  FavoritesLoaded copyWith({
    List<CharacterEntities>? characters,
    FavoritesSortBy? sortBy,
  }) {
    return FavoritesLoaded(
      characters: characters ?? this.characters,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  List<Object> get props => [characters, sortBy];
}

class FavoritesEmpty extends FavoritesState {
  @override
  List<Object> get props => [];
}
