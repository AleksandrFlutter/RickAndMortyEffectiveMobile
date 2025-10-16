import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();
}

class CharactersInitial extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharactersLoading extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharactersLoaded extends CharactersState {
  final List<CharacterEntities> characters;
  final bool hasReachedMax;

  const CharactersLoaded(this.characters, this.hasReachedMax);

  CharactersLoaded copyWith({
    List<CharacterEntities>? characters,
    bool? hasReachedMax,
  }) {
    return CharactersLoaded(
      characters ?? this.characters,
      hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [characters, hasReachedMax];
}

class CharactersError extends CharactersState {
  final String message;

  const CharactersError(this.message);

  @override
  List<Object> get props => [message];
}
