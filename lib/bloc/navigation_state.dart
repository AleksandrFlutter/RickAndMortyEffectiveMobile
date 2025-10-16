import 'package:equatable/equatable.dart';

/// Класс состояния навигации
/// Хранит информацию о текущей активной вкладке
class NavigationState extends Equatable {
  /// Индекс текущей активной вкладки
  final int currentIndex;

  const NavigationState({required this.currentIndex});

  /// Создает копию состояния с возможностью обновления текущего индекса
  NavigationState copyWith({int? currentIndex}) {
    return NavigationState(currentIndex: currentIndex ?? this.currentIndex);
  }

  /// Фабричный метод для создания начального состояния
  /// По умолчанию активна первая вкладка (индекс 0)
  factory NavigationState.initial() => const NavigationState(currentIndex: 0);

  @override
  List<Object> get props => [currentIndex];
}
