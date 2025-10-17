import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty/core/constant/app_strings.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';

/// Виджет карточки персонажа для отображения в списке
/// Отображает основную информацию о персонаже и кнопку добавления в избранное
class CharacterCard extends StatelessWidget {
  /// Данные персонажа для отображения
  final CharacterEntities character;

  /// Колб эк для переключения статуса "избранное"
  final void Function() onFavoriteToggle;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Отступы вокруг карточки
      margin: const EdgeInsets.all(6),
      // Обрезка содержимого по границам карточки
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        // Фиксированная высота карточки
        height: 120,
        child: Row(
          children: [
            // Контейнер для изображения персонажа
            SizedBox(
              width: 120,
              child: CachedNetworkImage(
                // Ссылка на изображение персонажа
                imageUrl: character.imageUrl,
                // Растягиваем изображение по ширине контейнера
                fit: BoxFit.fitWidth,
                // Отображаем индикатор загрузки пока изображение грузится
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                // Отображаем иконку ошибки при проблемах с загрузкой
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
                // Заголовки для HTTP-запроса (обход ограничений некоторых серверов)
                httpHeaders: const {'User-Agent': 'Mozilla/5.0'},
                // Кэшируем изображение с уменьшенным разрешением для оптимизации
                memCacheWidth: 100,
                memCacheHeight: 120,
              ),
            ),
            // Текстовая информация о персонаже
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Имя персонажа жирным шрифтом
                    Text(
                      character.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Статус персонажа
                    Text('${AppStrings.status}: ${character.status}'),
                    // Вид персонажа
                    Text('${AppStrings.species}: ${character.species}'),
                    // Локация персонажа
                    Text('${AppStrings.location}: ${character.locationName}'),
                  ],
                ),
              ),
            ),

            // Кнопка добавления/удаления из избранного
            IconButton(
              icon: Icon(
                // Меняем иконку в зависимости от статуса избранного
                character.isFavorite ? Icons.star : Icons.star_border,
                // Золотой цвет для активного состояния избранного
                color: character.isFavorite ? Colors.amber : null,
              ),
              onPressed: onFavoriteToggle,
            ),
          ],
        ),
      ),
    );
  }
}
