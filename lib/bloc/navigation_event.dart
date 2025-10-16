/// Базовый класс для всех событий навигации
abstract class NavigationEvent {}

/// Событие навигации к экрану персонажей
class NavigateToCharacters extends NavigationEvent {}

/// Событие навигации к экрану избранного
class NavigateToFavorites extends NavigationEvent {}

/// Событие навигации к экрану настроек
class NavigateToSettings extends NavigationEvent {}
