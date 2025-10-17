part of 'theme_bloc.dart';

/// Состояние темы приложения (светлая/тёмная)
/// Использует Equatable для корректного сравнения состояний и оптимизации перестроек UI
@immutable
class ThemeState extends Equatable {
  /// Текущий режим темы (светлая или тёмная)
  final AppThemeMode mode;

  const ThemeState({required this.mode});

  /// Фабричный конструктор для создания начального состояния
  /// По умолчанию используется светлая тема
  factory ThemeState.initial() => const ThemeState(mode: AppThemeMode.light);

  @override
  List<Object> get props => [mode];
}