/// Базовый абстрактный класс для всех событий, связанных со списком персонажей
/// Обеспечивает типобезопасность и структуру событийной модели BLoC
abstract class CharactersEvent {
  const CharactersEvent();
}

/// Событие запроса загрузки персонажей с указанной страницы API
/// Используется для пагинации: при скролле к концу списка запрашивается следующая страница
class CharactersFetchRequested extends CharactersEvent {
  /// Номер страницы для загрузки (начинается с 1)
  final int page;

  const CharactersFetchRequested(this.page);
}

/// Событие переключения статуса "избранное" для персонажа
/// Вызывается при нажатии на звёздочку в карточке персонажа
class CharactersToggleFavorite extends CharactersEvent {
  /// Уникальный идентификатор персонажа
  final int characterId;

  const CharactersToggleFavorite(this.characterId);
}

/// Событие внешнего обновления статуса "избранное"
/// Используется для синхронизации между экранами (например, при удалении из избранного на другом экране)
class CharactersUpdateFavoriteStatus extends CharactersEvent {
  /// Уникальный идентификатор персонажа
  final int characterId;

  /// Новое значение флага "избранное"
  final bool isFavorite;

  CharactersUpdateFavoriteStatus(this.characterId, this.isFavorite);
}

/// Событие подписки на реактивные обновления из локальной базы данных
/// Запускает Stream, который автоматически обновляет список при изменении данных (например, избранного)
class CharactersWatch extends CharactersEvent {}