// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CharactersDaoTable extends CharactersDao
    with TableInfo<$CharactersDaoTable, CharactersDaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharactersDaoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationNameMeta = const VerificationMeta(
    'locationName',
  );
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
    'location_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    status,
    species,
    locationName,
    imageUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'characters_dao';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharactersDaoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('location_name')) {
      context.handle(
        _locationNameMeta,
        locationName.isAcceptableOrUnknown(
          data['location_name']!,
          _locationNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_locationNameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CharactersDaoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharactersDaoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      species: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species'],
      )!,
      locationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
    );
  }

  @override
  $CharactersDaoTable createAlias(String alias) {
    return $CharactersDaoTable(attachedDatabase, alias);
  }
}

class CharactersDaoData extends DataClass
    implements Insertable<CharactersDaoData> {
  final int id;
  final String name;
  final String status;
  final String species;
  final String locationName;
  final String imageUrl;
  const CharactersDaoData({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.locationName,
    required this.imageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['status'] = Variable<String>(status);
    map['species'] = Variable<String>(species);
    map['location_name'] = Variable<String>(locationName);
    map['image_url'] = Variable<String>(imageUrl);
    return map;
  }

  CharactersDaoCompanion toCompanion(bool nullToAbsent) {
    return CharactersDaoCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      species: Value(species),
      locationName: Value(locationName),
      imageUrl: Value(imageUrl),
    );
  }

  factory CharactersDaoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharactersDaoData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<String>(json['status']),
      species: serializer.fromJson<String>(json['species']),
      locationName: serializer.fromJson<String>(json['locationName']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String>(status),
      'species': serializer.toJson<String>(species),
      'locationName': serializer.toJson<String>(locationName),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  CharactersDaoData copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? locationName,
    String? imageUrl,
  }) => CharactersDaoData(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    species: species ?? this.species,
    locationName: locationName ?? this.locationName,
    imageUrl: imageUrl ?? this.imageUrl,
  );
  CharactersDaoData copyWithCompanion(CharactersDaoCompanion data) {
    return CharactersDaoData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      species: data.species.present ? data.species.value : this.species,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharactersDaoData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('locationName: $locationName, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, status, species, locationName, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharactersDaoData &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.species == this.species &&
          other.locationName == this.locationName &&
          other.imageUrl == this.imageUrl);
}

class CharactersDaoCompanion extends UpdateCompanion<CharactersDaoData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> status;
  final Value<String> species;
  final Value<String> locationName;
  final Value<String> imageUrl;
  const CharactersDaoCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.species = const Value.absent(),
    this.locationName = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  CharactersDaoCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String status,
    required String species,
    required String locationName,
    required String imageUrl,
  }) : name = Value(name),
       status = Value(status),
       species = Value(species),
       locationName = Value(locationName),
       imageUrl = Value(imageUrl);
  static Insertable<CharactersDaoData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? status,
    Expression<String>? species,
    Expression<String>? locationName,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (species != null) 'species': species,
      if (locationName != null) 'location_name': locationName,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  CharactersDaoCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? status,
    Value<String>? species,
    Value<String>? locationName,
    Value<String>? imageUrl,
  }) {
    return CharactersDaoCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      locationName: locationName ?? this.locationName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharactersDaoCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('locationName: $locationName, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

class $FavoritesDaoTable extends FavoritesDao
    with TableInfo<$FavoritesDaoTable, FavoritesDaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesDaoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<int> characterId = GeneratedColumn<int>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [characterId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites_dao';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoritesDaoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId};
  @override
  FavoritesDaoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoritesDaoData(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}character_id'],
      )!,
    );
  }

  @override
  $FavoritesDaoTable createAlias(String alias) {
    return $FavoritesDaoTable(attachedDatabase, alias);
  }
}

class FavoritesDaoData extends DataClass
    implements Insertable<FavoritesDaoData> {
  final int characterId;
  const FavoritesDaoData({required this.characterId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<int>(characterId);
    return map;
  }

  FavoritesDaoCompanion toCompanion(bool nullToAbsent) {
    return FavoritesDaoCompanion(characterId: Value(characterId));
  }

  factory FavoritesDaoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritesDaoData(
      characterId: serializer.fromJson<int>(json['characterId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<int>(characterId),
    };
  }

  FavoritesDaoData copyWith({int? characterId}) =>
      FavoritesDaoData(characterId: characterId ?? this.characterId);
  FavoritesDaoData copyWithCompanion(FavoritesDaoCompanion data) {
    return FavoritesDaoData(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesDaoData(')
          ..write('characterId: $characterId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => characterId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritesDaoData && other.characterId == this.characterId);
}

class FavoritesDaoCompanion extends UpdateCompanion<FavoritesDaoData> {
  final Value<int> characterId;
  const FavoritesDaoCompanion({this.characterId = const Value.absent()});
  FavoritesDaoCompanion.insert({this.characterId = const Value.absent()});
  static Insertable<FavoritesDaoData> custom({Expression<int>? characterId}) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
    });
  }

  FavoritesDaoCompanion copyWith({Value<int>? characterId}) {
    return FavoritesDaoCompanion(characterId: characterId ?? this.characterId);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<int>(characterId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesDaoCompanion(')
          ..write('characterId: $characterId')
          ..write(')'))
        .toString();
  }
}

class $ThemeSettingsDaoTable extends ThemeSettingsDao
    with TableInfo<$ThemeSettingsDaoTable, ThemeSettingsDaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemeSettingsDaoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDarkModeMeta = const VerificationMeta(
    'isDarkMode',
  );
  @override
  late final GeneratedColumn<bool> isDarkMode = GeneratedColumn<bool>(
    'is_dark_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dark_mode" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, isDarkMode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'theme_settings_dao';
  @override
  VerificationContext validateIntegrity(
    Insertable<ThemeSettingsDaoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_dark_mode')) {
      context.handle(
        _isDarkModeMeta,
        isDarkMode.isAcceptableOrUnknown(
          data['is_dark_mode']!,
          _isDarkModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isDarkModeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ThemeSettingsDaoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThemeSettingsDaoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isDarkMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dark_mode'],
      )!,
    );
  }

  @override
  $ThemeSettingsDaoTable createAlias(String alias) {
    return $ThemeSettingsDaoTable(attachedDatabase, alias);
  }
}

class ThemeSettingsDaoData extends DataClass
    implements Insertable<ThemeSettingsDaoData> {
  final int id;
  final bool isDarkMode;
  const ThemeSettingsDaoData({required this.id, required this.isDarkMode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_dark_mode'] = Variable<bool>(isDarkMode);
    return map;
  }

  ThemeSettingsDaoCompanion toCompanion(bool nullToAbsent) {
    return ThemeSettingsDaoCompanion(
      id: Value(id),
      isDarkMode: Value(isDarkMode),
    );
  }

  factory ThemeSettingsDaoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThemeSettingsDaoData(
      id: serializer.fromJson<int>(json['id']),
      isDarkMode: serializer.fromJson<bool>(json['isDarkMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isDarkMode': serializer.toJson<bool>(isDarkMode),
    };
  }

  ThemeSettingsDaoData copyWith({int? id, bool? isDarkMode}) =>
      ThemeSettingsDaoData(
        id: id ?? this.id,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
  ThemeSettingsDaoData copyWithCompanion(ThemeSettingsDaoCompanion data) {
    return ThemeSettingsDaoData(
      id: data.id.present ? data.id.value : this.id,
      isDarkMode: data.isDarkMode.present
          ? data.isDarkMode.value
          : this.isDarkMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThemeSettingsDaoData(')
          ..write('id: $id, ')
          ..write('isDarkMode: $isDarkMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, isDarkMode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThemeSettingsDaoData &&
          other.id == this.id &&
          other.isDarkMode == this.isDarkMode);
}

class ThemeSettingsDaoCompanion extends UpdateCompanion<ThemeSettingsDaoData> {
  final Value<int> id;
  final Value<bool> isDarkMode;
  const ThemeSettingsDaoCompanion({
    this.id = const Value.absent(),
    this.isDarkMode = const Value.absent(),
  });
  ThemeSettingsDaoCompanion.insert({
    this.id = const Value.absent(),
    required bool isDarkMode,
  }) : isDarkMode = Value(isDarkMode);
  static Insertable<ThemeSettingsDaoData> custom({
    Expression<int>? id,
    Expression<bool>? isDarkMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isDarkMode != null) 'is_dark_mode': isDarkMode,
    });
  }

  ThemeSettingsDaoCompanion copyWith({
    Value<int>? id,
    Value<bool>? isDarkMode,
  }) {
    return ThemeSettingsDaoCompanion(
      id: id ?? this.id,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isDarkMode.present) {
      map['is_dark_mode'] = Variable<bool>(isDarkMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemeSettingsDaoCompanion(')
          ..write('id: $id, ')
          ..write('isDarkMode: $isDarkMode')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CharactersDaoTable charactersDao = $CharactersDaoTable(this);
  late final $FavoritesDaoTable favoritesDao = $FavoritesDaoTable(this);
  late final $ThemeSettingsDaoTable themeSettingsDao = $ThemeSettingsDaoTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    charactersDao,
    favoritesDao,
    themeSettingsDao,
  ];
}

typedef $$CharactersDaoTableCreateCompanionBuilder =
    CharactersDaoCompanion Function({
      Value<int> id,
      required String name,
      required String status,
      required String species,
      required String locationName,
      required String imageUrl,
    });
typedef $$CharactersDaoTableUpdateCompanionBuilder =
    CharactersDaoCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> status,
      Value<String> species,
      Value<String> locationName,
      Value<String> imageUrl,
    });

class $$CharactersDaoTableFilterComposer
    extends Composer<_$AppDatabase, $CharactersDaoTable> {
  $$CharactersDaoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CharactersDaoTableOrderingComposer
    extends Composer<_$AppDatabase, $CharactersDaoTable> {
  $$CharactersDaoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CharactersDaoTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharactersDaoTable> {
  $$CharactersDaoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$CharactersDaoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharactersDaoTable,
          CharactersDaoData,
          $$CharactersDaoTableFilterComposer,
          $$CharactersDaoTableOrderingComposer,
          $$CharactersDaoTableAnnotationComposer,
          $$CharactersDaoTableCreateCompanionBuilder,
          $$CharactersDaoTableUpdateCompanionBuilder,
          (
            CharactersDaoData,
            BaseReferences<
              _$AppDatabase,
              $CharactersDaoTable,
              CharactersDaoData
            >,
          ),
          CharactersDaoData,
          PrefetchHooks Function()
        > {
  $$CharactersDaoTableTableManager(_$AppDatabase db, $CharactersDaoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharactersDaoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharactersDaoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharactersDaoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> species = const Value.absent(),
                Value<String> locationName = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
              }) => CharactersDaoCompanion(
                id: id,
                name: name,
                status: status,
                species: species,
                locationName: locationName,
                imageUrl: imageUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String status,
                required String species,
                required String locationName,
                required String imageUrl,
              }) => CharactersDaoCompanion.insert(
                id: id,
                name: name,
                status: status,
                species: species,
                locationName: locationName,
                imageUrl: imageUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CharactersDaoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharactersDaoTable,
      CharactersDaoData,
      $$CharactersDaoTableFilterComposer,
      $$CharactersDaoTableOrderingComposer,
      $$CharactersDaoTableAnnotationComposer,
      $$CharactersDaoTableCreateCompanionBuilder,
      $$CharactersDaoTableUpdateCompanionBuilder,
      (
        CharactersDaoData,
        BaseReferences<_$AppDatabase, $CharactersDaoTable, CharactersDaoData>,
      ),
      CharactersDaoData,
      PrefetchHooks Function()
    >;
typedef $$FavoritesDaoTableCreateCompanionBuilder =
    FavoritesDaoCompanion Function({Value<int> characterId});
typedef $$FavoritesDaoTableUpdateCompanionBuilder =
    FavoritesDaoCompanion Function({Value<int> characterId});

class $$FavoritesDaoTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesDaoTable> {
  $$FavoritesDaoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get characterId => $composableBuilder(
    column: $table.characterId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesDaoTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesDaoTable> {
  $$FavoritesDaoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get characterId => $composableBuilder(
    column: $table.characterId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesDaoTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesDaoTable> {
  $$FavoritesDaoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get characterId => $composableBuilder(
    column: $table.characterId,
    builder: (column) => column,
  );
}

class $$FavoritesDaoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesDaoTable,
          FavoritesDaoData,
          $$FavoritesDaoTableFilterComposer,
          $$FavoritesDaoTableOrderingComposer,
          $$FavoritesDaoTableAnnotationComposer,
          $$FavoritesDaoTableCreateCompanionBuilder,
          $$FavoritesDaoTableUpdateCompanionBuilder,
          (
            FavoritesDaoData,
            BaseReferences<_$AppDatabase, $FavoritesDaoTable, FavoritesDaoData>,
          ),
          FavoritesDaoData,
          PrefetchHooks Function()
        > {
  $$FavoritesDaoTableTableManager(_$AppDatabase db, $FavoritesDaoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesDaoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesDaoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesDaoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({Value<int> characterId = const Value.absent()}) =>
                  FavoritesDaoCompanion(characterId: characterId),
          createCompanionCallback:
              ({Value<int> characterId = const Value.absent()}) =>
                  FavoritesDaoCompanion.insert(characterId: characterId),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesDaoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesDaoTable,
      FavoritesDaoData,
      $$FavoritesDaoTableFilterComposer,
      $$FavoritesDaoTableOrderingComposer,
      $$FavoritesDaoTableAnnotationComposer,
      $$FavoritesDaoTableCreateCompanionBuilder,
      $$FavoritesDaoTableUpdateCompanionBuilder,
      (
        FavoritesDaoData,
        BaseReferences<_$AppDatabase, $FavoritesDaoTable, FavoritesDaoData>,
      ),
      FavoritesDaoData,
      PrefetchHooks Function()
    >;
typedef $$ThemeSettingsDaoTableCreateCompanionBuilder =
    ThemeSettingsDaoCompanion Function({
      Value<int> id,
      required bool isDarkMode,
    });
typedef $$ThemeSettingsDaoTableUpdateCompanionBuilder =
    ThemeSettingsDaoCompanion Function({Value<int> id, Value<bool> isDarkMode});

class $$ThemeSettingsDaoTableFilterComposer
    extends Composer<_$AppDatabase, $ThemeSettingsDaoTable> {
  $$ThemeSettingsDaoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDarkMode => $composableBuilder(
    column: $table.isDarkMode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ThemeSettingsDaoTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemeSettingsDaoTable> {
  $$ThemeSettingsDaoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDarkMode => $composableBuilder(
    column: $table.isDarkMode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ThemeSettingsDaoTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemeSettingsDaoTable> {
  $$ThemeSettingsDaoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isDarkMode => $composableBuilder(
    column: $table.isDarkMode,
    builder: (column) => column,
  );
}

class $$ThemeSettingsDaoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThemeSettingsDaoTable,
          ThemeSettingsDaoData,
          $$ThemeSettingsDaoTableFilterComposer,
          $$ThemeSettingsDaoTableOrderingComposer,
          $$ThemeSettingsDaoTableAnnotationComposer,
          $$ThemeSettingsDaoTableCreateCompanionBuilder,
          $$ThemeSettingsDaoTableUpdateCompanionBuilder,
          (
            ThemeSettingsDaoData,
            BaseReferences<
              _$AppDatabase,
              $ThemeSettingsDaoTable,
              ThemeSettingsDaoData
            >,
          ),
          ThemeSettingsDaoData,
          PrefetchHooks Function()
        > {
  $$ThemeSettingsDaoTableTableManager(
    _$AppDatabase db,
    $ThemeSettingsDaoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThemeSettingsDaoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThemeSettingsDaoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemeSettingsDaoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isDarkMode = const Value.absent(),
              }) => ThemeSettingsDaoCompanion(id: id, isDarkMode: isDarkMode),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required bool isDarkMode,
              }) => ThemeSettingsDaoCompanion.insert(
                id: id,
                isDarkMode: isDarkMode,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ThemeSettingsDaoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThemeSettingsDaoTable,
      ThemeSettingsDaoData,
      $$ThemeSettingsDaoTableFilterComposer,
      $$ThemeSettingsDaoTableOrderingComposer,
      $$ThemeSettingsDaoTableAnnotationComposer,
      $$ThemeSettingsDaoTableCreateCompanionBuilder,
      $$ThemeSettingsDaoTableUpdateCompanionBuilder,
      (
        ThemeSettingsDaoData,
        BaseReferences<
          _$AppDatabase,
          $ThemeSettingsDaoTable,
          ThemeSettingsDaoData
        >,
      ),
      ThemeSettingsDaoData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CharactersDaoTableTableManager get charactersDao =>
      $$CharactersDaoTableTableManager(_db, _db.charactersDao);
  $$FavoritesDaoTableTableManager get favoritesDao =>
      $$FavoritesDaoTableTableManager(_db, _db.favoritesDao);
  $$ThemeSettingsDaoTableTableManager get themeSettingsDao =>
      $$ThemeSettingsDaoTableTableManager(_db, _db.themeSettingsDao);
}
