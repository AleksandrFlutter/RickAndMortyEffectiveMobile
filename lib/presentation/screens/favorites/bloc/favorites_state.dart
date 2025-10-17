import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/constant/app_strings.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';

/// Перечисление доступных критериев сортировки для экрана "Избранное"
enum FavoritesSortBy {
  name,
  location,
  status,
  species;

  /// Возвращает название критерия сортировки на русском языке
  String get label {
    switch (this) {
      case FavoritesSortBy.name:
        return AppStrings.sortByName;
      case FavoritesSortBy.location:
        return AppStrings.location;
      case FavoritesSortBy.status:
        return AppStrings.status;
      case FavoritesSortBy.species:
        return AppStrings.species;
    }
  }
}

/// Базовый абстрактный класс для всех состояний экрана "Избранное"
/// Использует Equatable для автоматического сравнения объектов (оптимизация перестроек UI)
abstract class FavoritesState extends Equatable {
  const FavoritesState();
}

/// Начальное состояние: данные ещё не загружались
class FavoritesInitial extends FavoritesState {
  @override
  List<Object> get props => [];
}

/// Состояние загрузки: отображается индикатор загрузки
class FavoritesLoading extends FavoritesState {
  @override
  List<Object> get props => [];
}

/// Состояние успешной загрузки избранных персонажей
class FavoritesLoaded extends FavoritesState {
  /// Список избранных персонажей
  final List<CharacterEntities> characters;

  /// Текущий критерий сортировки списка
  final FavoritesSortBy sortBy;

  const FavoritesLoaded({
    required this.characters,
    this.sortBy = FavoritesSortBy.name, // По умолчанию сортировка по имени
  });

  /// Метод для иммутабельного обновления отдельных полей состояния
  /// Используется при изменении сортировки или обновлении списка
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

/// Состояние "пусто": в избранном нет персонажей
class FavoritesEmpty extends FavoritesState {
  @override
  List<Object> get props => [];
}
