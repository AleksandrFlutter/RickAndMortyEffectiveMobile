import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';
import 'package:rick_and_morty/repository/character_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

/// BLoC для управления состоянием экрана "Избранное"
/// Обеспечивает загрузку, сортировку, удаление и реактивные обновления избранных персонажей
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  /// Репозиторий для взаимодействия с локальной базой данных
  final CharacterRepository _repository;

  FavoritesBloc(this._repository) : super(FavoritesInitial()) {
    // Регистрация обработчиков всех поддерживаемых событий
    on<FavoritesLoadRequested>(_onLoad);
    on<FavoritesSortChanged>(_onSortChanged);
    on<FavoritesRemoveFromFavorite>(_onRemove);
    on<FavoritesWatch>(_onWatch);
  }

  /// Обработчик события подписки на реактивные обновления из локальной БД
  /// Используется для автоматического обновления списка при изменении избранного
  Future<void> _onWatch(
      FavoritesWatch event,
      Emitter<FavoritesState> emit,
      ) async {
    // Подписываемся на Stream из репозитория и эмитим новое состояние при каждом изменении данных
    await emit.forEach(
      _repository.watchFavorites(),
      onData: (favorites) {
        // Если список пуст — возвращаем состояние "пусто"
        if (favorites.isEmpty) return FavoritesEmpty();
        // Иначе — возвращаем загруженное состояние
        return FavoritesLoaded(characters: favorites);
      },
    );
  }

  /// Обработчик запроса на первоначальную загрузку избранных персонажей
  Future<void> _onLoad(
      FavoritesLoadRequested event,
      Emitter<FavoritesState> emit,
      ) async {
    // Показываем индикатор загрузки
    emit(FavoritesLoading());
    // Загружаем избранных персонажей из БД
    final favorites = await _repository.getFavorites();
    if (favorites.isEmpty) {
      emit(FavoritesEmpty());
    } else {
      emit(FavoritesLoaded(characters: favorites));
    }
  }

  /// Обработчик изменения порядка сортировки
  Future<void> _onSortChanged(
      FavoritesSortChanged event,
      Emitter<FavoritesState> emit,
      ) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      // Создаём копию списка для сортировки
      List<CharacterEntities> sorted = List.from(currentState.characters);

      // Сортируем в зависимости от выбранного критерия
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

      // Эмитим новое состояние с отсортированным списком и обновлённым критерием сортировки
      emit(currentState.copyWith(characters: sorted, sortBy: event.sortBy));
    }
  }

  /// Обработчик удаления персонажа из избранного
  Future<void> _onRemove(
      FavoritesRemoveFromFavorite event,
      Emitter<FavoritesState> emit,
      ) async {
    // Переключаем статус избранного в БД (удаляем запись)
    await _repository.toggleFavorite(event.characterId);

    // Загружаем обновлённый список избранных
    final updatedFavorites = await _repository.getFavorites();

    if (updatedFavorites.isEmpty) {
      // Если список стал пустым — показываем соответствующее состояние
      emit(FavoritesEmpty());
    } else {
      if (state is FavoritesLoaded) {
        // Сохраняем текущий критерий сортировки
        final currentSort = (state as FavoritesLoaded).sortBy;
        List<CharacterEntities> sorted = List.from(updatedFavorites);

        // Применяем ту же сортировку к обновлённому списку
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
        // Если предыдущее состояние не было FavoritesLoaded — просто загружаем без сортировки
        emit(FavoritesLoaded(characters: updatedFavorites));
      }
    }
  }
}