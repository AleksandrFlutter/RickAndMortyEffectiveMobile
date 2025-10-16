abstract class CharactersEvent {
  const CharactersEvent();
}

class CharactersFetchRequested extends CharactersEvent {
  final int page;

  const CharactersFetchRequested(this.page);
}

class CharactersToggleFavorite extends CharactersEvent {
  final int characterId;

  const CharactersToggleFavorite(this.characterId);
}

class CharactersUpdateFavoriteStatus extends CharactersEvent {
  final int characterId;
  final bool isFavorite;

  CharactersUpdateFavoriteStatus(this.characterId, this.isFavorite);
}

class CharactersWatch extends CharactersEvent {}
