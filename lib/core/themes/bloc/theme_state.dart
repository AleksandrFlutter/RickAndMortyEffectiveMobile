part of 'theme_bloc.dart';

@immutable
class ThemeState extends Equatable {
  final AppThemeMode mode;

  const ThemeState({required this.mode});

  factory ThemeState.initial() => const ThemeState(mode: AppThemeMode.light);

  @override
  List<Object> get props => [mode];
}