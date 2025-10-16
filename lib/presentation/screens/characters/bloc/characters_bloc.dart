import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_event.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_state.dart';
import 'package:rick_and_morty/repository/character_repository.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository _repo;
  final Set<int> _loadedPages = {};

  CharactersBloc(this._repo) : super(CharactersInitial()) {
    on<CharactersFetchRequested>(_onFetch);
    on<CharactersToggleFavorite>(_onToggleFavorite);
    on<CharactersUpdateFavoriteStatus>(_onUpdateFavoriteStatus);
    on<CharactersWatch>(_onWatch);
  }

  Future<void> _onWatch(
    CharactersWatch event,
    Emitter<CharactersState> emit,
  ) async {
    await emit.forEach(
      _repo.watchAllCharacters(),
      onData: (characters) {
        return CharactersLoaded(characters, false);
      },
    );
  }

  Future<void> _onFetch(
    CharactersFetchRequested event,
    Emitter<CharactersState> emit,
  ) async {
    if (_loadedPages.contains(event.page)) return;
    _loadedPages.add(event.page);

    final isFirst = event.page == 1;
    if (isFirst) emit(CharactersLoading());

    try {
      final chars = await _repo.getCharacters(event.page);
      emit(CharactersLoaded(chars, chars.length >= 826));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    CharactersToggleFavorite event,
    Emitter<CharactersState> emit,
  ) async {
    await _repo.toggleFavorite(event.characterId);
    // Обновляем весь список (можно оптимизировать)
    if (state is CharactersLoaded) {
      final updated = await _repo.getCharacters(
        1,
      ); // или лучше — частичное обновление
      emit((state as CharactersLoaded).copyWith(characters: updated));
    }
  }

  Future<void> _onUpdateFavoriteStatus(
    CharactersUpdateFavoriteStatus event,
    Emitter<CharactersState> emit,
  ) async {
    if (state is CharactersLoaded) {
      final updatedChars = List<CharacterEntities>.from(
        (state as CharactersLoaded).characters,
      );
      final index = updatedChars.indexWhere((c) => c.id == event.characterId);
      if (index != -1) {
        updatedChars[index] = updatedChars[index].copyWith(
          isFavorite: event.isFavorite,
        );
        emit((state as CharactersLoaded).copyWith(characters: updatedChars));
      }
    }
  }
}
