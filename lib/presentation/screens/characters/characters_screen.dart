import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/constant/app_strings.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_bloc.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_event.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_state.dart';
import 'package:rick_and_morty/presentation/widget/character_card.dart';

/// Экран со списком всех персонажей из вселенной Rick and Morty
/// Поддерживает пагинацию, оффлайн-режим и реактивное обновление при изменении избранного
class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  /// Контроллер для отслеживания скролла и подгрузки новых страниц
  final ScrollController _scrollController = ScrollController();

  /// Текущая загруженная страница (начинается с 1)
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    // Загружаем первую страницу данных при инициализации экрана
    debugPrint('initState()');
    final charactersBloc = context.read<CharactersBloc>();
    // Подписываемся на реактивные обновления из БД (через Stream)
    charactersBloc.add(CharactersWatch());
    // Запрашиваем первую страницу персонажей с API
    charactersBloc.add(CharactersFetchRequested(1));
    // Добавляем слушатель скролла для подгрузки следующих страниц
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // Освобождаем ресурсы контроллера скролла
    _scrollController.dispose();
    super.dispose();
  }

  /// Обработчик скролла: подгружает следующую страницу при достижении конца списка
  void _onScroll() {
    // Проверяем, что пользователь прокрутил близко к концу списка (с запасом 200px)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<CharactersBloc>().state;
      // Если данные загружены и ещё не достигнут конец всех страниц API
      if (state is CharactersLoaded && !state.hasReachedMax) {
        _currentPage++;
        // Запрашиваем следующую страницу
        context.read<CharactersBloc>().add(
          CharactersFetchRequested(_currentPage),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.characters)),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          // Показываем индикатор загрузки только при первоначальной загрузке (страница 1)
          if (state is CharactersLoading && _currentPage == 1) {
            return const Center(child: CircularProgressIndicator());
          }
          // Отображаем список персонажей
          else if (state is CharactersLoaded) {
            return ListView.builder(
              controller: _scrollController,
              // Добавляем один элемент-заглушку для индикатора подгрузки,
              // если ещё не достигнут конец данных
              itemCount: state.characters.length + (_hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                // Если индекс соответствует "заглушке" — показываем индикатор
                if (index >= state.characters.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                // Иначе отображаем карточку персонажа
                final character = state.characters[index];
                return CharacterCard(
                  character: character,
                  // При нажатии на звёздочку отправляем событие в BLoC
                  onFavoriteToggle: () {
                    context.read<CharactersBloc>().add(
                      CharactersToggleFavorite(character.id),
                    );
                  },
                );
              },
            );
          }
          // Обработка ошибок загрузки
          else if (state is CharactersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.errorLoadingCharacters),
                  Text('${AppStrings.error}: ${state.message}'),
                ],
              ),
            );
          }
          // Для остальных состояний (например, CharactersInitial) — пустой контейнер
          else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  /// Вспомогательное свойство: проверяет, достигнут ли конец всех доступных данных
  bool get _hasReachedMax {
    final state = context.read<CharactersBloc>().state;
    return state is CharactersLoaded && state.hasReachedMax;
  }
}
