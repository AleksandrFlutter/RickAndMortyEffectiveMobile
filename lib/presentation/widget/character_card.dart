import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty/domain/entities/character_entities.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntities character;
  final void Function() onFavoriteToggle; // опционально

  const CharacterCard({
    super.key,
    required this.character,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6), // ← margin 6 со всех сторон
      clipBehavior: Clip.hardEdge, // чтобы изображение не вылезало за границы Card
      child: SizedBox(
        height: 120, // фиксированная высота карточки (настройте по вкусу)
        child: Row(
          children: [
            // Изображение — занимает всю высоту карточки
            SizedBox(
              width: 120,
              child: CachedNetworkImage(
                imageUrl: character.imageUrl,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                httpHeaders: const {'User-Agent': 'Mozilla/5.0'},
                memCacheWidth: 100,
                memCacheHeight: 120, // ≈ высота карточки
              ),
            ),
            // Контент справа
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      character.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text('Статус: ${character.status}'),
                    Text('Вид: ${character.species}'),
                    Text('Локация: ${character.locationName}'),
                  ],
                ),
              ),
            ),
            // Звёздочка
            if (onFavoriteToggle != null)
              IconButton(
                icon: Icon(
                  character.isFavorite ? Icons.star : Icons.star_border,
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
