import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

/// BLoC для управления навигацией в приложении
/// Отвечает за переключение между основными экранами
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  /// Создает NavigationBloc с начальным состоянием
  NavigationBloc() : super(NavigationState.initial()) {
    /// Обрабатывает событие перехода к списку персонажей
    on<NavigateToCharacters>((event, emit) {
      emit(state.copyWith(currentIndex: 0));
    });

    /// Обрабатывает событие перехода к избранным персонажам
    on<NavigateToFavorites>((event, emit) {
      emit(state.copyWith(currentIndex: 1));
    });

    /// Обрабатывает событие перехода к настройкам приложения
    on<NavigateToSettings>((event, emit) {
      emit(state.copyWith(currentIndex: 2));
    });
  }
}
