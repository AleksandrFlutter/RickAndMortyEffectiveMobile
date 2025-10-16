import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<NavigateToCharacters>((event, emit) {
      emit(state.copyWith(currentIndex: 0));
    });
    on<NavigateToFavorites>((event, emit) {
      emit(state.copyWith(currentIndex: 1));
    });
    on<NavigateToSettings>((event, emit) {
      emit(state.copyWith(currentIndex: 2));
    });
  }
}

extension NavigationStateX on NavigationState {
  NavigationState copyWith({int? currentIndex}) {
    return NavigationState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
