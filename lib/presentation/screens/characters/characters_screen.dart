import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_bloc.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_event.dart';
import 'package:rick_and_morty/presentation/screens/characters/bloc/characters_state.dart';
import 'package:rick_and_morty/presentation/widget/character_card.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageStorageBucket _bucket = PageStorageBucket();

  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    // Загружаем первую страницу

    debugPrint('initState()');
    final charactersBloc = context.read<CharactersBloc>();
    charactersBloc.add(CharactersWatch());
    charactersBloc.add(CharactersFetchRequested(1));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<CharactersBloc>().state;
      if (state is CharactersLoaded && !state.hasReachedMax) {
        _currentPage++;
        context.read<CharactersBloc>().add(
          CharactersFetchRequested(_currentPage),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Персонажи')),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state is CharactersLoading && _currentPage == 1) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharactersLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.characters.length + (_hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.characters.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final character = state.characters[index];
                return CharacterCard(
                  character: character,
                  onFavoriteToggle: () {
                    context.read<CharactersBloc>().add(
                      CharactersToggleFavorite(character.id),
                    );
                  },
                );
              },
            );
          } else if (state is CharactersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Не удалось загрузить персонажей'),
                  Text('Ошибка: ${state.message}'),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  bool get _hasReachedMax {
    final state = context.read<CharactersBloc>().state;
    return state is CharactersLoaded && state.hasReachedMax;
  }
}
