import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';

/// Базовый абстрактный класс для всех состояний списка персонажей
/// Использует Equatable для автоматического сравнения объектов (оптимизация перестроек UI)
abstract class CharactersState extends Equatable {
  const CharactersState();
}

/// Начальное состояние: данные ещё не загружались
class CharactersInitial extends CharactersState {
  @override
  List<Object> get props => [];
}

/// Состояние загрузки: отображается индикатор загрузки
class CharactersLoading extends CharactersState {
  @override
  List<Object> get props => [];
}

/// Состояние успешной загрузки данных
class CharactersLoaded extends CharactersState {
  /// Список загруженных персонажей
  final List<CharacterEntities> characters;

  /// Флаг, указывающий, достигнут ли конец всех доступных данных (всего 826 персонажей в API)
  final bool hasReachedMax;

  const CharactersLoaded(this.characters, this.hasReachedMax);

  /// Метод для иммутабельного обновления отдельных полей состояния
  /// Используется, например, при реактивном обновлении избранного без перезагрузки всего списка
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

/// Состояние ошибки: произошла ошибка при загрузке данных (например, нет интернета)
class CharactersError extends CharactersState {
  /// Сообщение об ошибке для отображения пользователю
  final String message;

  const CharactersError(this.message);

  @override
  List<Object> get props => [message];
}