import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_event.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_state.dart';
import 'package:rick_and_morty/repository/character_repository.dart';

/// BLoC для управления состоянием списка персонажей
/// Обеспечивает загрузку данных, реактивные обновления и работу с избранным
class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  /// Репозиторий для взаимодействия с API и локальной базой данных
  final CharacterRepository _repo;

  /// Множество уже загруженных страниц для предотвращения дублирующих запросов
  final Set<int> _loadedPages = {};

  CharactersBloc(this._repo) : super(CharactersInitial()) {
    // Регистрация обработчиков всех поддерживаемых событий
    on<CharactersFetchRequested>(_onFetch);
    on<CharactersToggleFavorite>(_onToggleFavorite);
    on<CharactersUpdateFavoriteStatus>(_onUpdateFavoriteStatus);
    on<CharactersWatch>(_onWatch);
  }

  /// Обработчик события подписки на реактивные обновления из локальной БД
  /// Используется для автоматического обновления списка при изменении избранного
  Future<void> _onWatch(
    CharactersWatch event,
    Emitter<CharactersState> emit,
  ) async {
    // Подписываемся на Stream из репозитория и эмитим новое состояние при каждом изменении данных
    await emit.forEach(
      _repo.watchAllCharacters(),
      onData: (characters) {
        // hasReachedMax = false, так как Stream возвращает все сохранённые данные (без пагинации)
        return CharactersLoaded(characters, false);
      },
    );
  }

  /// Обработчик запроса на загрузку персонажей с указанной страницы API
  Future<void> _onFetch(
    CharactersFetchRequested event,
    Emitter<CharactersState> emit,
  ) async {
    // Предотвращаем повторную загрузку уже загруженной страницы
    if (_loadedPages.contains(event.page)) return;
    _loadedPages.add(event.page);

    // Показываем индикатор загрузки только при первоначальной загрузке (страница 1)
    final isFirst = event.page == 1;
    if (isFirst) emit(CharactersLoading());

    try {
      // Загружаем персонажей через репозиторий (с сохранением в БД и кэшированием)
      final chars = await _repo.getCharacters(event.page);
      // Определяем, достигнут ли конец всех данных (всего 826 персонажей в API)
      emit(CharactersLoaded(chars, chars.length >= 826));
    } catch (e) {
      // Обработка ошибок (например, отсутствие интернета)
      emit(CharactersError(e.toString()));
    }
  }

  /// Обработчик переключения статуса "избранное" для персонажа
  /// Обновляет данные в БД, но НЕ эмитит новое состояние — обновление UI происходит через Stream
  Future<void> _onToggleFavorite(
    CharactersToggleFavorite event,
    Emitter<CharactersState> emit,
  ) async {
    // Обновляем статус избранного в локальной БД
    await _repo.toggleFavorite(event.characterId);
    // Ничего не эмитим — реактивный Stream (_onWatch) автоматически обновит UI
  }

  /// Обработчик внешнего обновления статуса "избранное"
  /// Используется для синхронизации с другими экранами (например, "Избранное")
  /// без перезагрузки данных с API
  Future<void> _onUpdateFavoriteStatus(
    CharactersUpdateFavoriteStatus event,
    Emitter<CharactersState> emit,
  ) async {
    if (state is CharactersLoaded) {
      // Создаём копию списка для иммутабельного обновления
      final updatedChars = List<CharacterEntities>.from(
        (state as CharactersLoaded).characters,
      );
      // Находим индекс персонажа, который нужно обновить
      final index = updatedChars.indexWhere((c) => c.id == event.characterId);
      if (index != -1) {
        // Обновляем только флаг isFavorite у найденного персонажа
        updatedChars[index] = updatedChars[index].copyWith(
          isFavorite: event.isFavorite,
        );
        // Эмитим новое состояние с обновлённым списком
        emit((state as CharactersLoaded).copyWith(characters: updatedChars));
      }
    }
  }
}
