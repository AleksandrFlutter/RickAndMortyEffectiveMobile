/// Сущность персонажа из вселенной Rick and Morty
/// Используется как единая модель данных во всём приложении (UI, BLoC, репозиторий, БД)
class CharacterEntities {
  /// Уникальный идентификатор персонажа (соответствует полю `id` в API)
  final int id;

  /// Имя персонажа (поле `name` из API)
  final String name;

  /// Статус персонажа: "Alive", "Dead" или "unknown"
  final String status;

  /// Вид/раса персонажа (поле `species` из API), например: "Human", "Alien"
  final String species;

  /// Название локации последнего известного местоположения (из `location.name` в API)
  final String locationName;

  /// URL аватара персонажа (все изображения 300x300px)
  final String imageUrl;

  /// Флаг, указывающий, добавлен ли персонаж в избранное
  /// Это локальное поле, не приходит из API, управляется пользователем
  final bool isFavorite;

  /// Конструктор с обязательными параметрами для всех полей, кроме isFavorite (по умолчанию false)
  CharacterEntities({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.locationName,
    required this.imageUrl,
    this.isFavorite = false,
  });

  /// Фабричный конструктор для создания сущности из JSON-ответа API
  /// Извлекает данные из структуры Rick and Morty API и игнорирует поле isFavorite
  /// (оно будет установлено в false по умолчанию)
  factory CharacterEntities.fromJson(Map<String, dynamic> json) {
    return CharacterEntities(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      // Извлекаем имя локации из вложенного объекта location
      locationName: (json['location'] as Map<String, dynamic>)['name'],
      imageUrl: json['image'],
      // isFavorite не приходит из API — остаётся false
    );
  }

  /// Метод для иммутабельного обновления отдельных полей сущности
  /// Используется, например, при переключении избранного
  CharacterEntities copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? locationName,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return CharacterEntities(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      locationName: locationName ?? this.locationName,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}