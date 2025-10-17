import 'package:rick_and_morty/presentation/screens/favorites/bloc/favorites_state.dart';

/// Базовый абстрактный класс для всех событий, связанных с экраном "Избранное"
/// Обеспечивает типобезопасность и структуру событийной модели BLoC
abstract class FavoritesEvent {}

/// Событие запроса первоначальной загрузки избранных персонажей
/// Используется при открытии экрана "Избранное" для отображения сохранённых данных
class FavoritesLoadRequested extends FavoritesEvent {}

/// Событие изменения критерия сортировки списка избранных персонажей
class FavoritesSortChanged extends FavoritesEvent {
  /// Новый критерий сортировки (по имени, локации, статусу или виду)
  final FavoritesSortBy sortBy;

  FavoritesSortChanged(this.sortBy);
}

/// Событие удаления персонажа из избранного
class FavoritesRemoveFromFavorite extends FavoritesEvent {
  /// Уникальный идентификатор персонажа, которого нужно удалить из избранного
  final int characterId;

  FavoritesRemoveFromFavorite(this.characterId);
}

/// Событие подписки на реактивные обновления из локальной базы данных
/// Запускает Stream, который автоматически обновляет список при изменении данных
/// (например, при удалении избранного на другом экране)
class FavoritesWatch extends FavoritesEvent {}