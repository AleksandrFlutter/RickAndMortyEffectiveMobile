class CharacterEntities {
  final int id;
  final String name;
  final String status;
  final String species;
  final String locationName;
  final String imageUrl;
  final bool isFavorite;

  CharacterEntities({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.locationName,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory CharacterEntities.fromJson(Map<String, dynamic> json) {
    return CharacterEntities(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      locationName: (json['location'] as Map<String, dynamic>)['name'],
      imageUrl: json['image'],
    );
  }

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
