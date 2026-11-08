// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, UserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<String> birthDate = GeneratedColumn<String>(
    'birth_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    phone,
    firstName,
    lastName,
    birthDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phone};
  @override
  UserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRow(
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birth_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserRow extends DataClass implements Insertable<UserRow> {
  /// National digits, no leading zero.
  final String phone;
  final String firstName;
  final String? lastName;

  /// `yyyy-MM-dd`; a timestamp would shift across time zones.
  final String birthDate;
  final DateTime createdAt;
  const UserRow({
    required this.phone,
    required this.firstName,
    this.lastName,
    required this.birthDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phone'] = Variable<String>(phone);
    map['first_name'] = Variable<String>(firstName);
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    map['birth_date'] = Variable<String>(birthDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      phone: Value(phone),
      firstName: Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      birthDate: Value(birthDate),
      createdAt: Value(createdAt),
    );
  }

  factory UserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRow(
      phone: serializer.fromJson<String>(json['phone']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      birthDate: serializer.fromJson<String>(json['birthDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phone': serializer.toJson<String>(phone),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'birthDate': serializer.toJson<String>(birthDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserRow copyWith({
    String? phone,
    String? firstName,
    Value<String?> lastName = const Value.absent(),
    String? birthDate,
    DateTime? createdAt,
  }) => UserRow(
    phone: phone ?? this.phone,
    firstName: firstName ?? this.firstName,
    lastName: lastName.present ? lastName.value : this.lastName,
    birthDate: birthDate ?? this.birthDate,
    createdAt: createdAt ?? this.createdAt,
  );
  UserRow copyWithCompanion(UsersCompanion data) {
    return UserRow(
      phone: data.phone.present ? data.phone.value : this.phone,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRow(')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('birthDate: $birthDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(phone, firstName, lastName, birthDate, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRow &&
          other.phone == this.phone &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.birthDate == this.birthDate &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<UserRow> {
  final Value<String> phone;
  final Value<String> firstName;
  final Value<String?> lastName;
  final Value<String> birthDate;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.phone = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String phone,
    required String firstName,
    this.lastName = const Value.absent(),
    required String birthDate,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : phone = Value(phone),
       firstName = Value(firstName),
       birthDate = Value(birthDate),
       createdAt = Value(createdAt);
  static Insertable<UserRow> custom({
    Expression<String>? phone,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? birthDate,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (phone != null) 'phone': phone,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (birthDate != null) 'birth_date': birthDate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? phone,
    Value<String>? firstName,
    Value<String?>? lastName,
    Value<String>? birthDate,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<String>(birthDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('birthDate: $birthDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _priceMmkMeta = const VerificationMeta(
    'priceMmk',
  );
  @override
  late final GeneratedColumn<int> priceMmk = GeneratedColumn<int>(
    'price_mmk',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<int> discountPercent = GeneratedColumn<int>(
    'discount_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _assetFallbackMeta = const VerificationMeta(
    'assetFallback',
  );
  @override
  late final GeneratedColumn<String> assetFallback = GeneratedColumn<String>(
    'asset_fallback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageUrl,
    assetFallback,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_mmk')) {
      context.handle(
        _priceMmkMeta,
        priceMmk.isAcceptableOrUnknown(data['price_mmk']!, _priceMmkMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMmkMeta);
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('asset_fallback')) {
      context.handle(
        _assetFallbackMeta,
        assetFallback.isAcceptableOrUnknown(
          data['asset_fallback']!,
          _assetFallbackMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceMmk: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_mmk'],
      )!,
      isNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_new'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_percent'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      assetFallback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_fallback'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductRow extends DataClass implements Insertable<ProductRow> {
  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;
  final String imageUrl;
  final String? assetFallback;
  final String description;
  const ProductRow({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    this.discountPercent,
    required this.imageUrl,
    this.assetFallback,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['price_mmk'] = Variable<int>(priceMmk);
    map['is_new'] = Variable<bool>(isNew);
    if (!nullToAbsent || discountPercent != null) {
      map['discount_percent'] = Variable<int>(discountPercent);
    }
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || assetFallback != null) {
      map['asset_fallback'] = Variable<String>(assetFallback);
    }
    map['description'] = Variable<String>(description);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      priceMmk: Value(priceMmk),
      isNew: Value(isNew),
      discountPercent: discountPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(discountPercent),
      imageUrl: Value(imageUrl),
      assetFallback: assetFallback == null && nullToAbsent
          ? const Value.absent()
          : Value(assetFallback),
      description: Value(description),
    );
  }

  factory ProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      priceMmk: serializer.fromJson<int>(json['priceMmk']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      discountPercent: serializer.fromJson<int?>(json['discountPercent']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      assetFallback: serializer.fromJson<String?>(json['assetFallback']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'priceMmk': serializer.toJson<int>(priceMmk),
      'isNew': serializer.toJson<bool>(isNew),
      'discountPercent': serializer.toJson<int?>(discountPercent),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'assetFallback': serializer.toJson<String?>(assetFallback),
      'description': serializer.toJson<String>(description),
    };
  }

  ProductRow copyWith({
    String? id,
    String? code,
    String? name,
    int? priceMmk,
    bool? isNew,
    Value<int?> discountPercent = const Value.absent(),
    String? imageUrl,
    Value<String?> assetFallback = const Value.absent(),
    String? description,
  }) => ProductRow(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    priceMmk: priceMmk ?? this.priceMmk,
    isNew: isNew ?? this.isNew,
    discountPercent: discountPercent.present
        ? discountPercent.value
        : this.discountPercent,
    imageUrl: imageUrl ?? this.imageUrl,
    assetFallback: assetFallback.present
        ? assetFallback.value
        : this.assetFallback,
    description: description ?? this.description,
  );
  ProductRow copyWithCompanion(ProductsCompanion data) {
    return ProductRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      priceMmk: data.priceMmk.present ? data.priceMmk.value : this.priceMmk,
      isNew: data.isNew.present ? data.isNew.value : this.isNew,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      assetFallback: data.assetFallback.present
          ? data.assetFallback.value
          : this.assetFallback,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('assetFallback: $assetFallback, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageUrl,
    assetFallback,
    description,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.priceMmk == this.priceMmk &&
          other.isNew == this.isNew &&
          other.discountPercent == this.discountPercent &&
          other.imageUrl == this.imageUrl &&
          other.assetFallback == this.assetFallback &&
          other.description == this.description);
}

class ProductsCompanion extends UpdateCompanion<ProductRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> priceMmk;
  final Value<bool> isNew;
  final Value<int?> discountPercent;
  final Value<String> imageUrl;
  final Value<String?> assetFallback;
  final Value<String> description;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.priceMmk = const Value.absent(),
    this.isNew = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.assetFallback = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    this.isNew = const Value.absent(),
    this.discountPercent = const Value.absent(),
    required String imageUrl,
    this.assetFallback = const Value.absent(),
    required String description,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       name = Value(name),
       priceMmk = Value(priceMmk),
       imageUrl = Value(imageUrl),
       description = Value(description);
  static Insertable<ProductRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? priceMmk,
    Expression<bool>? isNew,
    Expression<int>? discountPercent,
    Expression<String>? imageUrl,
    Expression<String>? assetFallback,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (priceMmk != null) 'price_mmk': priceMmk,
      if (isNew != null) 'is_new': isNew,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (imageUrl != null) 'image_url': imageUrl,
      if (assetFallback != null) 'asset_fallback': assetFallback,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? name,
    Value<int>? priceMmk,
    Value<bool>? isNew,
    Value<int?>? discountPercent,
    Value<String>? imageUrl,
    Value<String?>? assetFallback,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      priceMmk: priceMmk ?? this.priceMmk,
      isNew: isNew ?? this.isNew,
      discountPercent: discountPercent ?? this.discountPercent,
      imageUrl: imageUrl ?? this.imageUrl,
      assetFallback: assetFallback ?? this.assetFallback,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceMmk.present) {
      map['price_mmk'] = Variable<int>(priceMmk.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<int>(discountPercent.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (assetFallback.present) {
      map['asset_fallback'] = Variable<String>(assetFallback.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('assetFallback: $assetFallback, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BannersTable extends Banners with TableInfo<$BannersTable, BannerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BannersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _badgeMeta = const VerificationMeta('badge');
  @override
  late final GeneratedColumn<String> badge = GeneratedColumn<String>(
    'badge',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _styleMeta = const VerificationMeta('style');
  @override
  late final GeneratedColumn<String> style = GeneratedColumn<String>(
    'style',
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
  static const VerificationMeta _assetFallbackMeta = const VerificationMeta(
    'assetFallback',
  );
  @override
  late final GeneratedColumn<String> assetFallback = GeneratedColumn<String>(
    'asset_fallback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    badge,
    style,
    imageUrl,
    assetFallback,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banners';
  @override
  VerificationContext validateIntegrity(
    Insertable<BannerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('badge')) {
      context.handle(
        _badgeMeta,
        badge.isAcceptableOrUnknown(data['badge']!, _badgeMeta),
      );
    }
    if (data.containsKey('style')) {
      context.handle(
        _styleMeta,
        style.isAcceptableOrUnknown(data['style']!, _styleMeta),
      );
    } else if (isInserting) {
      context.missing(_styleMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('asset_fallback')) {
      context.handle(
        _assetFallbackMeta,
        assetFallback.isAcceptableOrUnknown(
          data['asset_fallback']!,
          _assetFallbackMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BannerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BannerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      badge: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}badge'],
      ),
      style: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}style'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      assetFallback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_fallback'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $BannersTable createAlias(String alias) {
    return $BannersTable(attachedDatabase, alias);
  }
}

class BannerRow extends DataClass implements Insertable<BannerRow> {
  final String id;
  final String title;
  final String? badge;
  final String style;
  final String imageUrl;
  final String? assetFallback;
  final int sortOrder;
  const BannerRow({
    required this.id,
    required this.title,
    this.badge,
    required this.style,
    required this.imageUrl,
    this.assetFallback,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || badge != null) {
      map['badge'] = Variable<String>(badge);
    }
    map['style'] = Variable<String>(style);
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || assetFallback != null) {
      map['asset_fallback'] = Variable<String>(assetFallback);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  BannersCompanion toCompanion(bool nullToAbsent) {
    return BannersCompanion(
      id: Value(id),
      title: Value(title),
      badge: badge == null && nullToAbsent
          ? const Value.absent()
          : Value(badge),
      style: Value(style),
      imageUrl: Value(imageUrl),
      assetFallback: assetFallback == null && nullToAbsent
          ? const Value.absent()
          : Value(assetFallback),
      sortOrder: Value(sortOrder),
    );
  }

  factory BannerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BannerRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      badge: serializer.fromJson<String?>(json['badge']),
      style: serializer.fromJson<String>(json['style']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      assetFallback: serializer.fromJson<String?>(json['assetFallback']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'badge': serializer.toJson<String?>(badge),
      'style': serializer.toJson<String>(style),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'assetFallback': serializer.toJson<String?>(assetFallback),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  BannerRow copyWith({
    String? id,
    String? title,
    Value<String?> badge = const Value.absent(),
    String? style,
    String? imageUrl,
    Value<String?> assetFallback = const Value.absent(),
    int? sortOrder,
  }) => BannerRow(
    id: id ?? this.id,
    title: title ?? this.title,
    badge: badge.present ? badge.value : this.badge,
    style: style ?? this.style,
    imageUrl: imageUrl ?? this.imageUrl,
    assetFallback: assetFallback.present
        ? assetFallback.value
        : this.assetFallback,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  BannerRow copyWithCompanion(BannersCompanion data) {
    return BannerRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      badge: data.badge.present ? data.badge.value : this.badge,
      style: data.style.present ? data.style.value : this.style,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      assetFallback: data.assetFallback.present
          ? data.assetFallback.value
          : this.assetFallback,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BannerRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('badge: $badge, ')
          ..write('style: $style, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('assetFallback: $assetFallback, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, badge, style, imageUrl, assetFallback, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BannerRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.badge == this.badge &&
          other.style == this.style &&
          other.imageUrl == this.imageUrl &&
          other.assetFallback == this.assetFallback &&
          other.sortOrder == this.sortOrder);
}

class BannersCompanion extends UpdateCompanion<BannerRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> badge;
  final Value<String> style;
  final Value<String> imageUrl;
  final Value<String?> assetFallback;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const BannersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.badge = const Value.absent(),
    this.style = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.assetFallback = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BannersCompanion.insert({
    required String id,
    required String title,
    this.badge = const Value.absent(),
    required String style,
    required String imageUrl,
    this.assetFallback = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       style = Value(style),
       imageUrl = Value(imageUrl),
       sortOrder = Value(sortOrder);
  static Insertable<BannerRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? badge,
    Expression<String>? style,
    Expression<String>? imageUrl,
    Expression<String>? assetFallback,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (badge != null) 'badge': badge,
      if (style != null) 'style': style,
      if (imageUrl != null) 'image_url': imageUrl,
      if (assetFallback != null) 'asset_fallback': assetFallback,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BannersCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? badge,
    Value<String>? style,
    Value<String>? imageUrl,
    Value<String?>? assetFallback,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return BannersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      badge: badge ?? this.badge,
      style: style ?? this.style,
      imageUrl: imageUrl ?? this.imageUrl,
      assetFallback: assetFallback ?? this.assetFallback,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (badge.present) {
      map['badge'] = Variable<String>(badge.value);
    }
    if (style.present) {
      map['style'] = Variable<String>(style.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (assetFallback.present) {
      map['asset_fallback'] = Variable<String>(assetFallback.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BannersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('badge: $badge, ')
          ..write('style: $style, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('assetFallback: $assetFallback, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SectionsTable extends Sections
    with TableInfo<$SectionsTable, SectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, kind, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<SectionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SectionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $SectionsTable createAlias(String alias) {
    return $SectionsTable(attachedDatabase, alias);
  }
}

class SectionRow extends DataClass implements Insertable<SectionRow> {
  final String id;
  final String kind;
  final int sortOrder;
  const SectionRow({
    required this.id,
    required this.kind,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['kind'] = Variable<String>(kind);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SectionsCompanion toCompanion(bool nullToAbsent) {
    return SectionsCompanion(
      id: Value(id),
      kind: Value(kind),
      sortOrder: Value(sortOrder),
    );
  }

  factory SectionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SectionRow(
      id: serializer.fromJson<String>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kind': serializer.toJson<String>(kind),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SectionRow copyWith({String? id, String? kind, int? sortOrder}) => SectionRow(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  SectionRow copyWithCompanion(SectionsCompanion data) {
    return SectionRow(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SectionRow(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kind, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SectionRow &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.sortOrder == this.sortOrder);
}

class SectionsCompanion extends UpdateCompanion<SectionRow> {
  final Value<String> id;
  final Value<String> kind;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const SectionsCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SectionsCompanion.insert({
    required String id,
    required String kind,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kind = Value(kind),
       sortOrder = Value(sortOrder);
  static Insertable<SectionRow> custom({
    Expression<String>? id,
    Expression<String>? kind,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? kind,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return SectionsCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionsCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SectionProductsTable extends SectionProducts
    with TableInfo<$SectionProductsTable, SectionProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  @override
  late final GeneratedColumn<String> sectionId = GeneratedColumn<String>(
    'section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sections (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [sectionId, productId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'section_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<SectionProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sectionId, productId};
  @override
  SectionProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SectionProductRow(
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $SectionProductsTable createAlias(String alias) {
    return $SectionProductsTable(attachedDatabase, alias);
  }
}

class SectionProductRow extends DataClass
    implements Insertable<SectionProductRow> {
  final String sectionId;
  final String productId;
  final int position;
  const SectionProductRow({
    required this.sectionId,
    required this.productId,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['section_id'] = Variable<String>(sectionId);
    map['product_id'] = Variable<String>(productId);
    map['position'] = Variable<int>(position);
    return map;
  }

  SectionProductsCompanion toCompanion(bool nullToAbsent) {
    return SectionProductsCompanion(
      sectionId: Value(sectionId),
      productId: Value(productId),
      position: Value(position),
    );
  }

  factory SectionProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SectionProductRow(
      sectionId: serializer.fromJson<String>(json['sectionId']),
      productId: serializer.fromJson<String>(json['productId']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sectionId': serializer.toJson<String>(sectionId),
      'productId': serializer.toJson<String>(productId),
      'position': serializer.toJson<int>(position),
    };
  }

  SectionProductRow copyWith({
    String? sectionId,
    String? productId,
    int? position,
  }) => SectionProductRow(
    sectionId: sectionId ?? this.sectionId,
    productId: productId ?? this.productId,
    position: position ?? this.position,
  );
  SectionProductRow copyWithCompanion(SectionProductsCompanion data) {
    return SectionProductRow(
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      productId: data.productId.present ? data.productId.value : this.productId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SectionProductRow(')
          ..write('sectionId: $sectionId, ')
          ..write('productId: $productId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sectionId, productId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SectionProductRow &&
          other.sectionId == this.sectionId &&
          other.productId == this.productId &&
          other.position == this.position);
}

class SectionProductsCompanion extends UpdateCompanion<SectionProductRow> {
  final Value<String> sectionId;
  final Value<String> productId;
  final Value<int> position;
  final Value<int> rowid;
  const SectionProductsCompanion({
    this.sectionId = const Value.absent(),
    this.productId = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SectionProductsCompanion.insert({
    required String sectionId,
    required String productId,
    required int position,
    this.rowid = const Value.absent(),
  }) : sectionId = Value(sectionId),
       productId = Value(productId),
       position = Value(position);
  static Insertable<SectionProductRow> custom({
    Expression<String>? sectionId,
    Expression<String>? productId,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sectionId != null) 'section_id': sectionId,
      if (productId != null) 'product_id': productId,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SectionProductsCompanion copyWith({
    Value<String>? sectionId,
    Value<String>? productId,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return SectionProductsCompanion(
      sectionId: sectionId ?? this.sectionId,
      productId: productId ?? this.productId,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionProductsCompanion(')
          ..write('sectionId: $sectionId, ')
          ..write('productId: $productId, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShopsTable extends Shops with TableInfo<$ShopsTable, ShopRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
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
  static const VerificationMeta _assetFallbackMeta = const VerificationMeta(
    'assetFallback',
  );
  @override
  late final GeneratedColumn<String> assetFallback = GeneratedColumn<String>(
    'asset_fallback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    imageUrl,
    assetFallback,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('asset_fallback')) {
      context.handle(
        _assetFallbackMeta,
        assetFallback.isAcceptableOrUnknown(
          data['asset_fallback']!,
          _assetFallbackMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      assetFallback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_fallback'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ShopsTable createAlias(String alias) {
    return $ShopsTable(attachedDatabase, alias);
  }
}

class ShopRow extends DataClass implements Insertable<ShopRow> {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final String? assetFallback;
  final int sortOrder;
  const ShopRow({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    this.assetFallback,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || assetFallback != null) {
      map['asset_fallback'] = Variable<String>(assetFallback);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ShopsCompanion toCompanion(bool nullToAbsent) {
    return ShopsCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      imageUrl: Value(imageUrl),
      assetFallback: assetFallback == null && nullToAbsent
          ? const Value.absent()
          : Value(assetFallback),
      sortOrder: Value(sortOrder),
    );
  }

  factory ShopRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      assetFallback: serializer.fromJson<String?>(json['assetFallback']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'assetFallback': serializer.toJson<String?>(assetFallback),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ShopRow copyWith({
    String? id,
    String? name,
    String? address,
    String? imageUrl,
    Value<String?> assetFallback = const Value.absent(),
    int? sortOrder,
  }) => ShopRow(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    imageUrl: imageUrl ?? this.imageUrl,
    assetFallback: assetFallback.present
        ? assetFallback.value
        : this.assetFallback,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ShopRow copyWithCompanion(ShopsCompanion data) {
    return ShopRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      assetFallback: data.assetFallback.present
          ? data.assetFallback.value
          : this.assetFallback,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('assetFallback: $assetFallback, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, address, imageUrl, assetFallback, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.imageUrl == this.imageUrl &&
          other.assetFallback == this.assetFallback &&
          other.sortOrder == this.sortOrder);
}

class ShopsCompanion extends UpdateCompanion<ShopRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> address;
  final Value<String> imageUrl;
  final Value<String?> assetFallback;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ShopsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.assetFallback = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopsCompanion.insert({
    required String id,
    required String name,
    required String address,
    required String imageUrl,
    this.assetFallback = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       address = Value(address),
       imageUrl = Value(imageUrl),
       sortOrder = Value(sortOrder);
  static Insertable<ShopRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? imageUrl,
    Expression<String>? assetFallback,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (imageUrl != null) 'image_url': imageUrl,
      if (assetFallback != null) 'asset_fallback': assetFallback,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? address,
    Value<String>? imageUrl,
    Value<String?>? assetFallback,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ShopsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      assetFallback: assetFallback ?? this.assetFallback,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (assetFallback.present) {
      map['asset_fallback'] = Variable<String>(assetFallback.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('assetFallback: $assetFallback, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, MemberRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPointsMeta = const VerificationMeta(
    'totalPoints',
  );
  @override
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointsToNextTierMeta = const VerificationMeta(
    'pointsToNextTier',
  );
  @override
  late final GeneratedColumn<int> pointsToNextTier = GeneratedColumn<int>(
    'points_to_next_tier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notificationCountMeta = const VerificationMeta(
    'notificationCount',
  );
  @override
  late final GeneratedColumn<int> notificationCount = GeneratedColumn<int>(
    'notification_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardCountMeta = const VerificationMeta(
    'rewardCount',
  );
  @override
  late final GeneratedColumn<int> rewardCount = GeneratedColumn<int>(
    'reward_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    photoUrl,
    tier,
    totalPoints,
    pointsToNextTier,
    notificationCount,
    rewardCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_photoUrlMeta);
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    } else if (isInserting) {
      context.missing(_tierMeta);
    }
    if (data.containsKey('total_points')) {
      context.handle(
        _totalPointsMeta,
        totalPoints.isAcceptableOrUnknown(
          data['total_points']!,
          _totalPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPointsMeta);
    }
    if (data.containsKey('points_to_next_tier')) {
      context.handle(
        _pointsToNextTierMeta,
        pointsToNextTier.isAcceptableOrUnknown(
          data['points_to_next_tier']!,
          _pointsToNextTierMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pointsToNextTierMeta);
    }
    if (data.containsKey('notification_count')) {
      context.handle(
        _notificationCountMeta,
        notificationCount.isAcceptableOrUnknown(
          data['notification_count']!,
          _notificationCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationCountMeta);
    }
    if (data.containsKey('reward_count')) {
      context.handle(
        _rewardCountMeta,
        rewardCount.isAcceptableOrUnknown(
          data['reward_count']!,
          _rewardCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemberRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      )!,
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
      pointsToNextTier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_to_next_tier'],
      )!,
      notificationCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_count'],
      )!,
      rewardCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_count'],
      )!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class MemberRow extends DataClass implements Insertable<MemberRow> {
  final String id;
  final String name;
  final String photoUrl;
  final String tier;
  final int totalPoints;
  final int pointsToNextTier;
  final int notificationCount;
  final int rewardCount;
  const MemberRow({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.tier,
    required this.totalPoints,
    required this.pointsToNextTier,
    required this.notificationCount,
    required this.rewardCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['photo_url'] = Variable<String>(photoUrl);
    map['tier'] = Variable<String>(tier);
    map['total_points'] = Variable<int>(totalPoints);
    map['points_to_next_tier'] = Variable<int>(pointsToNextTier);
    map['notification_count'] = Variable<int>(notificationCount);
    map['reward_count'] = Variable<int>(rewardCount);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      name: Value(name),
      photoUrl: Value(photoUrl),
      tier: Value(tier),
      totalPoints: Value(totalPoints),
      pointsToNextTier: Value(pointsToNextTier),
      notificationCount: Value(notificationCount),
      rewardCount: Value(rewardCount),
    );
  }

  factory MemberRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      photoUrl: serializer.fromJson<String>(json['photoUrl']),
      tier: serializer.fromJson<String>(json['tier']),
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
      pointsToNextTier: serializer.fromJson<int>(json['pointsToNextTier']),
      notificationCount: serializer.fromJson<int>(json['notificationCount']),
      rewardCount: serializer.fromJson<int>(json['rewardCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'photoUrl': serializer.toJson<String>(photoUrl),
      'tier': serializer.toJson<String>(tier),
      'totalPoints': serializer.toJson<int>(totalPoints),
      'pointsToNextTier': serializer.toJson<int>(pointsToNextTier),
      'notificationCount': serializer.toJson<int>(notificationCount),
      'rewardCount': serializer.toJson<int>(rewardCount),
    };
  }

  MemberRow copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? tier,
    int? totalPoints,
    int? pointsToNextTier,
    int? notificationCount,
    int? rewardCount,
  }) => MemberRow(
    id: id ?? this.id,
    name: name ?? this.name,
    photoUrl: photoUrl ?? this.photoUrl,
    tier: tier ?? this.tier,
    totalPoints: totalPoints ?? this.totalPoints,
    pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
    notificationCount: notificationCount ?? this.notificationCount,
    rewardCount: rewardCount ?? this.rewardCount,
  );
  MemberRow copyWithCompanion(MembersCompanion data) {
    return MemberRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      tier: data.tier.present ? data.tier.value : this.tier,
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
      pointsToNextTier: data.pointsToNextTier.present
          ? data.pointsToNextTier.value
          : this.pointsToNextTier,
      notificationCount: data.notificationCount.present
          ? data.notificationCount.value
          : this.notificationCount,
      rewardCount: data.rewardCount.present
          ? data.rewardCount.value
          : this.rewardCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('tier: $tier, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('rewardCount: $rewardCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    photoUrl,
    tier,
    totalPoints,
    pointsToNextTier,
    notificationCount,
    rewardCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.photoUrl == this.photoUrl &&
          other.tier == this.tier &&
          other.totalPoints == this.totalPoints &&
          other.pointsToNextTier == this.pointsToNextTier &&
          other.notificationCount == this.notificationCount &&
          other.rewardCount == this.rewardCount);
}

class MembersCompanion extends UpdateCompanion<MemberRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> photoUrl;
  final Value<String> tier;
  final Value<int> totalPoints;
  final Value<int> pointsToNextTier;
  final Value<int> notificationCount;
  final Value<int> rewardCount;
  final Value<int> rowid;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.tier = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.pointsToNextTier = const Value.absent(),
    this.notificationCount = const Value.absent(),
    this.rewardCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    required String id,
    required String name,
    required String photoUrl,
    required String tier,
    required int totalPoints,
    required int pointsToNextTier,
    required int notificationCount,
    required int rewardCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       photoUrl = Value(photoUrl),
       tier = Value(tier),
       totalPoints = Value(totalPoints),
       pointsToNextTier = Value(pointsToNextTier),
       notificationCount = Value(notificationCount),
       rewardCount = Value(rewardCount);
  static Insertable<MemberRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? photoUrl,
    Expression<String>? tier,
    Expression<int>? totalPoints,
    Expression<int>? pointsToNextTier,
    Expression<int>? notificationCount,
    Expression<int>? rewardCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (tier != null) 'tier': tier,
      if (totalPoints != null) 'total_points': totalPoints,
      if (pointsToNextTier != null) 'points_to_next_tier': pointsToNextTier,
      if (notificationCount != null) 'notification_count': notificationCount,
      if (rewardCount != null) 'reward_count': rewardCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? photoUrl,
    Value<String>? tier,
    Value<int>? totalPoints,
    Value<int>? pointsToNextTier,
    Value<int>? notificationCount,
    Value<int>? rewardCount,
    Value<int>? rowid,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      tier: tier ?? this.tier,
      totalPoints: totalPoints ?? this.totalPoints,
      pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
      notificationCount: notificationCount ?? this.notificationCount,
      rewardCount: rewardCount ?? this.rewardCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (pointsToNextTier.present) {
      map['points_to_next_tier'] = Variable<int>(pointsToNextTier.value);
    }
    if (notificationCount.present) {
      map['notification_count'] = Variable<int>(notificationCount.value);
    }
    if (rewardCount.present) {
      map['reward_count'] = Variable<int>(rewardCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('tier: $tier, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('rewardCount: $rewardCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChallengesTable extends Challenges
    with TableInfo<$ChallengesTable, ChallengeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _artworkMeta = const VerificationMeta(
    'artwork',
  );
  @override
  late final GeneratedColumn<String> artwork = GeneratedColumn<String>(
    'artwork',
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
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<int> goal = GeneratedColumn<int>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardPointsMeta = const VerificationMeta(
    'rewardPoints',
  );
  @override
  late final GeneratedColumn<int> rewardPoints = GeneratedColumn<int>(
    'reward_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tabMeta = const VerificationMeta('tab');
  @override
  late final GeneratedColumn<String> tab = GeneratedColumn<String>(
    'tab',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    artwork,
    imageUrl,
    progress,
    goal,
    rewardPoints,
    tab,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenges';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChallengeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artwork')) {
      context.handle(
        _artworkMeta,
        artwork.isAcceptableOrUnknown(data['artwork']!, _artworkMeta),
      );
    } else if (isInserting) {
      context.missing(_artworkMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('reward_points')) {
      context.handle(
        _rewardPointsMeta,
        rewardPoints.isAcceptableOrUnknown(
          data['reward_points']!,
          _rewardPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardPointsMeta);
    }
    if (data.containsKey('tab')) {
      context.handle(
        _tabMeta,
        tab.isAcceptableOrUnknown(data['tab']!, _tabMeta),
      );
    } else if (isInserting) {
      context.missing(_tabMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChallengeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChallengeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      artwork: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal'],
      )!,
      rewardPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_points'],
      )!,
      tab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tab'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ChallengesTable createAlias(String alias) {
    return $ChallengesTable(attachedDatabase, alias);
  }
}

class ChallengeRow extends DataClass implements Insertable<ChallengeRow> {
  final String id;
  final String title;
  final String artwork;
  final String imageUrl;
  final int progress;
  final int goal;
  final int rewardPoints;
  final String tab;
  final int sortOrder;
  const ChallengeRow({
    required this.id,
    required this.title,
    required this.artwork,
    required this.imageUrl,
    required this.progress,
    required this.goal,
    required this.rewardPoints,
    required this.tab,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['artwork'] = Variable<String>(artwork);
    map['image_url'] = Variable<String>(imageUrl);
    map['progress'] = Variable<int>(progress);
    map['goal'] = Variable<int>(goal);
    map['reward_points'] = Variable<int>(rewardPoints);
    map['tab'] = Variable<String>(tab);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ChallengesCompanion toCompanion(bool nullToAbsent) {
    return ChallengesCompanion(
      id: Value(id),
      title: Value(title),
      artwork: Value(artwork),
      imageUrl: Value(imageUrl),
      progress: Value(progress),
      goal: Value(goal),
      rewardPoints: Value(rewardPoints),
      tab: Value(tab),
      sortOrder: Value(sortOrder),
    );
  }

  factory ChallengeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengeRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artwork: serializer.fromJson<String>(json['artwork']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      progress: serializer.fromJson<int>(json['progress']),
      goal: serializer.fromJson<int>(json['goal']),
      rewardPoints: serializer.fromJson<int>(json['rewardPoints']),
      tab: serializer.fromJson<String>(json['tab']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'artwork': serializer.toJson<String>(artwork),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'progress': serializer.toJson<int>(progress),
      'goal': serializer.toJson<int>(goal),
      'rewardPoints': serializer.toJson<int>(rewardPoints),
      'tab': serializer.toJson<String>(tab),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ChallengeRow copyWith({
    String? id,
    String? title,
    String? artwork,
    String? imageUrl,
    int? progress,
    int? goal,
    int? rewardPoints,
    String? tab,
    int? sortOrder,
  }) => ChallengeRow(
    id: id ?? this.id,
    title: title ?? this.title,
    artwork: artwork ?? this.artwork,
    imageUrl: imageUrl ?? this.imageUrl,
    progress: progress ?? this.progress,
    goal: goal ?? this.goal,
    rewardPoints: rewardPoints ?? this.rewardPoints,
    tab: tab ?? this.tab,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ChallengeRow copyWithCompanion(ChallengesCompanion data) {
    return ChallengeRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      artwork: data.artwork.present ? data.artwork.value : this.artwork,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      progress: data.progress.present ? data.progress.value : this.progress,
      goal: data.goal.present ? data.goal.value : this.goal,
      rewardPoints: data.rewardPoints.present
          ? data.rewardPoints.value
          : this.rewardPoints,
      tab: data.tab.present ? data.tab.value : this.tab,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artwork: $artwork, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('progress: $progress, ')
          ..write('goal: $goal, ')
          ..write('rewardPoints: $rewardPoints, ')
          ..write('tab: $tab, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    artwork,
    imageUrl,
    progress,
    goal,
    rewardPoints,
    tab,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChallengeRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.artwork == this.artwork &&
          other.imageUrl == this.imageUrl &&
          other.progress == this.progress &&
          other.goal == this.goal &&
          other.rewardPoints == this.rewardPoints &&
          other.tab == this.tab &&
          other.sortOrder == this.sortOrder);
}

class ChallengesCompanion extends UpdateCompanion<ChallengeRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> artwork;
  final Value<String> imageUrl;
  final Value<int> progress;
  final Value<int> goal;
  final Value<int> rewardPoints;
  final Value<String> tab;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ChallengesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artwork = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.progress = const Value.absent(),
    this.goal = const Value.absent(),
    this.rewardPoints = const Value.absent(),
    this.tab = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengesCompanion.insert({
    required String id,
    required String title,
    required String artwork,
    required String imageUrl,
    required int progress,
    required int goal,
    required int rewardPoints,
    required String tab,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       artwork = Value(artwork),
       imageUrl = Value(imageUrl),
       progress = Value(progress),
       goal = Value(goal),
       rewardPoints = Value(rewardPoints),
       tab = Value(tab),
       sortOrder = Value(sortOrder);
  static Insertable<ChallengeRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? artwork,
    Expression<String>? imageUrl,
    Expression<int>? progress,
    Expression<int>? goal,
    Expression<int>? rewardPoints,
    Expression<String>? tab,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artwork != null) 'artwork': artwork,
      if (imageUrl != null) 'image_url': imageUrl,
      if (progress != null) 'progress': progress,
      if (goal != null) 'goal': goal,
      if (rewardPoints != null) 'reward_points': rewardPoints,
      if (tab != null) 'tab': tab,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? artwork,
    Value<String>? imageUrl,
    Value<int>? progress,
    Value<int>? goal,
    Value<int>? rewardPoints,
    Value<String>? tab,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ChallengesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artwork: artwork ?? this.artwork,
      imageUrl: imageUrl ?? this.imageUrl,
      progress: progress ?? this.progress,
      goal: goal ?? this.goal,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      tab: tab ?? this.tab,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artwork.present) {
      map['artwork'] = Variable<String>(artwork.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (goal.present) {
      map['goal'] = Variable<int>(goal.value);
    }
    if (rewardPoints.present) {
      map['reward_points'] = Variable<int>(rewardPoints.value);
    }
    if (tab.present) {
      map['tab'] = Variable<String>(tab.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artwork: $artwork, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('progress: $progress, ')
          ..write('goal: $goal, ')
          ..write('rewardPoints: $rewardPoints, ')
          ..write('tab: $tab, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTable extends SyncMeta
    with TableInfo<$SyncMetaTable, SyncMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SyncMetaTable createAlias(String alias) {
    return $SyncMetaTable(attachedDatabase, alias);
  }
}

class SyncMetaRow extends DataClass implements Insertable<SyncMetaRow> {
  final String key;
  final String value;
  const SyncMetaRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(key: Value(key), value: Value(value));
  }

  factory SyncMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SyncMetaRow copyWith({String? key, String? value}) =>
      SyncMetaRow(key: key ?? this.key, value: value ?? this.value);
  SyncMetaRow copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaRow &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SyncMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SyncMetaRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SyncMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $BannersTable banners = $BannersTable(this);
  late final $SectionsTable sections = $SectionsTable(this);
  late final $SectionProductsTable sectionProducts = $SectionProductsTable(
    this,
  );
  late final $ShopsTable shops = $ShopsTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $ChallengesTable challenges = $ChallengesTable(this);
  late final $SyncMetaTable syncMeta = $SyncMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    products,
    banners,
    sections,
    sectionProducts,
    shops,
    members,
    challenges,
    syncMeta,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('section_products', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('section_products', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String phone,
  required String firstName,
  Value<String?> lastName,
  required String birthDate,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> phone,
  Value<String> firstName,
  Value<String?> lastName,
  Value<String> birthDate,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UserRow,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
          UserRow,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> phone = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<String> birthDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                birthDate: birthDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String phone,
                required String firstName,
                Value<String?> lastName = const Value.absent(),
                required String birthDate,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                birthDate: birthDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, UserRow>(table),
                  BaseReferences<_$AppDatabase, $UsersTable, UserRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UserRow,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
      UserRow,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  required String id,
  required String code,
  required String name,
  required int priceMmk,
  Value<bool> isNew,
  Value<int?> discountPercent,
  required String imageUrl,
  Value<String?> assetFallback,
  required String description,
  Value<int> rowid,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<String> id,
  Value<String> code,
  Value<String> name,
  Value<int> priceMmk,
  Value<bool> isNew,
  Value<int?> discountPercent,
  Value<String> imageUrl,
  Value<String?> assetFallback,
  Value<String> description,
  Value<int> rowid,
});

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, ProductRow> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SectionProductsTable, List<SectionProductRow>>
  _sectionProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sectionProducts,
    aliasName: 'products__id__section_products__product_id',
  );

  $$SectionProductsTableProcessedTableManager get sectionProductsRefs {
    final manager = $$SectionProductsTableTableManager(
      $_db,
      $_db.sectionProducts,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sectionProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetFallback => $composableBuilder(
    column: $table.assetFallback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sectionProductsRefs(
    Expression<bool> Function($$SectionProductsTableFilterComposer f) f,
  ) {
    final $$SectionProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableFilterComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetFallback => $composableBuilder(
    column: $table.assetFallback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceMmk =>
      $composableBuilder(column: $table.priceMmk, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get assetFallback => $composableBuilder(
    column: $table.assetFallback,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> sectionProductsRefs<T extends Object>(
    Expression<T> Function($$SectionProductsTableAnnotationComposer a) f,
  ) {
    final $$SectionProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductRow,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (ProductRow, $$ProductsTableReferences),
          ProductRow,
          PrefetchHooks Function({bool sectionProductsRefs})
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priceMmk = const Value.absent(),
                Value<bool> isNew = const Value.absent(),
                Value<int?> discountPercent = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String?> assetFallback = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageUrl: imageUrl,
                assetFallback: assetFallback,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String name,
                required int priceMmk,
                Value<bool> isNew = const Value.absent(),
                Value<int?> discountPercent = const Value.absent(),
                required String imageUrl,
                Value<String?> assetFallback = const Value.absent(),
                required String description,
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageUrl: imageUrl,
                assetFallback: assetFallback,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTable, ProductRow>(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionProductsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sectionProductsRefs) db.sectionProducts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionProductsRefs)
                    await $_getPrefetchedDataByColumns<
                      ProductRow,
                      $ProductsTable,
                      SectionProductRow,
                      $SectionProductsTable
                    >(
                      currentTable: table,
                      referencedTable: $$ProductsTableReferences
                          ._sectionProductsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProductsTableReferences(
                        db,
                        table,
                        p0,
                      ).sectionProductsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'product_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductRow,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductRow, $$ProductsTableReferences),
      ProductRow,
      PrefetchHooks Function({bool sectionProductsRefs})
    >;
typedef $$BannersTableCreateCompanionBuilder = BannersCompanion Function({
  required String id,
  required String title,
  Value<String?> badge,
  required String style,
  required String imageUrl,
  Value<String?> assetFallback,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$BannersTableUpdateCompanionBuilder = BannersCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> badge,
  Value<String> style,
  Value<String> imageUrl,
  Value<String?> assetFallback,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$BannersTableFilterComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get badge => $composableBuilder(
    column: $table.badge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetFallback => $composableBuilder(
    column: $table.assetFallback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BannersTableOrderingComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get badge => $composableBuilder(
    column: $table.badge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetFallback => $composableBuilder(
    column: $table.assetFallback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BannersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get badge =>
      $composableBuilder(column: $table.badge, builder: (column) => column);

  GeneratedColumn<String> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get assetFallback => $composableBuilder(
    column: $table.assetFallback,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$BannersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BannersTable,
          BannerRow,
          $$BannersTableFilterComposer,
          $$BannersTableOrderingComposer,
          $$BannersTableAnnotationComposer,
          $$BannersTableCreateCompanionBuilder,
          $$BannersTableUpdateCompanionBuilder,
          (BannerRow, BaseReferences<_$AppDatabase, $BannersTable, BannerRow>),
          BannerRow,
          PrefetchHooks Function()
        > {
  $$BannersTableTableManager(_$AppDatabase db, $BannersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BannersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BannersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BannersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> badge = const Value.absent(),
                Value<String> style = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String?> assetFallback = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BannersCompanion(
                id: id,
                title: title,
                badge: badge,
                style: style,
                imageUrl: imageUrl,
                assetFallback: assetFallback,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> badge = const Value.absent(),
                required String style,
                required String imageUrl,
                Value<String?> assetFallback = const Value.absent(),
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => BannersCompanion.insert(
                id: id,
                title: title,
                badge: badge,
                style: style,
                imageUrl: imageUrl,
                assetFallback: assetFallback,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BannersTable, BannerRow>(table),
                  BaseReferences<_$AppDatabase, $BannersTable, BannerRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BannersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BannersTable,
      BannerRow,
      $$BannersTableFilterComposer,
      $$BannersTableOrderingComposer,
      $$BannersTableAnnotationComposer,
      $$BannersTableCreateCompanionBuilder,
      $$BannersTableUpdateCompanionBuilder,
      (BannerRow, BaseReferences<_$AppDatabase, $BannersTable, BannerRow>),
      BannerRow,
      PrefetchHooks Function()
    >;
typedef $$SectionsTableCreateCompanionBuilder = SectionsCompanion Function({
  required String id,
  required String kind,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$SectionsTableUpdateCompanionBuilder = SectionsCompanion Function({
  Value<String> id,
  Value<String> kind,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$SectionsTableReferences
    extends BaseReferences<_$AppDatabase, $SectionsTable, SectionRow> {
  $$SectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SectionProductsTable, List<SectionProductRow>>
  _sectionProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sectionProducts,
    aliasName: 'sections__id__section_products__section_id',
  );

  $$SectionProductsTableProcessedTableManager get sectionProductsRefs {
    final manager = $$SectionProductsTableTableManager(
      $_db,
      $_db.sectionProducts,
    ).filter((f) => f.sectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sectionProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SectionsTableFilterComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sectionProductsRefs(
    Expression<bool> Function($$SectionProductsTableFilterComposer f) f,
  ) {
    final $$SectionProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableFilterComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> sectionProductsRefs<T extends Object>(
    Expression<T> Function($$SectionProductsTableAnnotationComposer a) f,
  ) {
    final $$SectionProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SectionsTable,
          SectionRow,
          $$SectionsTableFilterComposer,
          $$SectionsTableOrderingComposer,
          $$SectionsTableAnnotationComposer,
          $$SectionsTableCreateCompanionBuilder,
          $$SectionsTableUpdateCompanionBuilder,
          (SectionRow, $$SectionsTableReferences),
          SectionRow,
          PrefetchHooks Function({bool sectionProductsRefs})
        > {
  $$SectionsTableTableManager(_$AppDatabase db, $SectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionsCompanion(
                id: id,
                kind: kind,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String kind,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => SectionsCompanion.insert(
                id: id,
                kind: kind,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SectionsTable, SectionRow>(table),
                  $$SectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionProductsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sectionProductsRefs) db.sectionProducts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionProductsRefs)
                    await $_getPrefetchedDataByColumns<
                      SectionRow,
                      $SectionsTable,
                      SectionProductRow,
                      $SectionProductsTable
                    >(
                      currentTable: table,
                      referencedTable: $$SectionsTableReferences
                          ._sectionProductsRefsTable(db),
                      managerFromTypedResult: (p0) => $$SectionsTableReferences(
                        db,
                        table,
                        p0,
                      ).sectionProductsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'section_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SectionsTable,
      SectionRow,
      $$SectionsTableFilterComposer,
      $$SectionsTableOrderingComposer,
      $$SectionsTableAnnotationComposer,
      $$SectionsTableCreateCompanionBuilder,
      $$SectionsTableUpdateCompanionBuilder,
      (SectionRow, $$SectionsTableReferences),
      SectionRow,
      PrefetchHooks Function({bool sectionProductsRefs})
    >;
typedef $$SectionProductsTableCreateCompanionBuilder =
    SectionProductsCompanion Function({
      required String sectionId,
      required String productId,
      required int position,
      Value<int> rowid,
    });
typedef $$SectionProductsTableUpdateCompanionBuilder =
    SectionProductsCompanion Function({
      Value<String> sectionId,
      Value<String> productId,
      Value<int> position,
      Value<int> rowid,
    });

final class $$SectionProductsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SectionProductsTable,
          SectionProductRow
        > {
  $$SectionProductsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SectionsTable _sectionIdTable(_$AppDatabase db) =>
      db.sections.createAlias('section_products__section_id__sections__id');

  $$SectionsTableProcessedTableManager get sectionId {
    final $_column = $_itemColumn<String>('section_id')!;

    final manager = $$SectionsTableTableManager(
      $_db,
      $_db.sections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('section_products__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SectionProductsTableFilterComposer
    extends Composer<_$AppDatabase, $SectionProductsTable> {
  $$SectionProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$SectionsTableFilterComposer get sectionId {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableFilterComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionProductsTable> {
  $$SectionProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$SectionsTableOrderingComposer get sectionId {
    final $$SectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableOrderingComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionProductsTable> {
  $$SectionProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$SectionsTableAnnotationComposer get sectionId {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SectionProductsTable,
          SectionProductRow,
          $$SectionProductsTableFilterComposer,
          $$SectionProductsTableOrderingComposer,
          $$SectionProductsTableAnnotationComposer,
          $$SectionProductsTableCreateCompanionBuilder,
          $$SectionProductsTableUpdateCompanionBuilder,
          (SectionProductRow, $$SectionProductsTableReferences),
          SectionProductRow,
          PrefetchHooks Function({bool sectionId, bool productId})
        > {
  $$SectionProductsTableTableManager(
    _$AppDatabase db,
    $SectionProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SectionProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sectionId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionProductsCompanion(
                sectionId: sectionId,
                productId: productId,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sectionId,
                required String productId,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => SectionProductsCompanion.insert(
                sectionId: sectionId,
                productId: productId,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SectionProductsTable, SectionProductRow>(table),
                  $$SectionProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sectionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sectionId,
                        referencedTable: $$SectionProductsTableReferences
                            ._sectionIdTable(db),
                        referencedColumn: $$SectionProductsTableReferences
                            ._sectionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$SectionProductsTableReferences
                            ._productIdTable(db),
                        referencedColumn: $$SectionProductsTableReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SectionProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SectionProductsTable,
      SectionProductRow,
      $$SectionProductsTableFilterComposer,
      $$SectionProductsTableOrderingComposer,
      $$SectionProductsTableAnnotationComposer,
      $$SectionProductsTableCreateCompanionBuilder,
      $$SectionProductsTableUpdateCompanionBuilder,
      (SectionProductRow, $$SectionProductsTableReferences),
      SectionProductRow,
      PrefetchHooks Function({bool sectionId, bool productId})
    >;
typedef $$ShopsTableCreateCompanionBuilder = ShopsCompanion Function({
  required String id,
  required String name,
  required String address,
  required String imageUrl,
  Value<String?> assetFallback,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$ShopsTableUpdateCompanionBuilder = ShopsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> address,
  Value<String> imageUrl,
  Value<String?> assetFallback,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$ShopsTableFilterComposer extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetFallback => $composableBuilder(
    column: $table.assetFallback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetFallback => $composableBuilder(
    column: $table.assetFallback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get assetFallback => $composableBuilder(
    column: $table.assetFallback,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ShopsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopsTable,
          ShopRow,
          $$ShopsTableFilterComposer,
          $$ShopsTableOrderingComposer,
          $$ShopsTableAnnotationComposer,
          $$ShopsTableCreateCompanionBuilder,
          $$ShopsTableUpdateCompanionBuilder,
          (ShopRow, BaseReferences<_$AppDatabase, $ShopsTable, ShopRow>),
          ShopRow,
          PrefetchHooks Function()
        > {
  $$ShopsTableTableManager(_$AppDatabase db, $ShopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String?> assetFallback = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion(
                id: id,
                name: name,
                address: address,
                imageUrl: imageUrl,
                assetFallback: assetFallback,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String address,
                required String imageUrl,
                Value<String?> assetFallback = const Value.absent(),
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion.insert(
                id: id,
                name: name,
                address: address,
                imageUrl: imageUrl,
                assetFallback: assetFallback,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShopsTable, ShopRow>(table),
                  BaseReferences<_$AppDatabase, $ShopsTable, ShopRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopsTable,
      ShopRow,
      $$ShopsTableFilterComposer,
      $$ShopsTableOrderingComposer,
      $$ShopsTableAnnotationComposer,
      $$ShopsTableCreateCompanionBuilder,
      $$ShopsTableUpdateCompanionBuilder,
      (ShopRow, BaseReferences<_$AppDatabase, $ShopsTable, ShopRow>),
      ShopRow,
      PrefetchHooks Function()
    >;
typedef $$MembersTableCreateCompanionBuilder = MembersCompanion Function({
  required String id,
  required String name,
  required String photoUrl,
  required String tier,
  required int totalPoints,
  required int pointsToNextTier,
  required int notificationCount,
  required int rewardCount,
  Value<int> rowid,
});
typedef $$MembersTableUpdateCompanionBuilder = MembersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> photoUrl,
  Value<String> tier,
  Value<int> totalPoints,
  Value<int> pointsToNextTier,
  Value<int> notificationCount,
  Value<int> rewardCount,
  Value<int> rowid,
});

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardCount => $composableBuilder(
    column: $table.rewardCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardCount => $composableBuilder(
    column: $table.rewardCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rewardCount => $composableBuilder(
    column: $table.rewardCount,
    builder: (column) => column,
  );
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          MemberRow,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (MemberRow, BaseReferences<_$AppDatabase, $MembersTable, MemberRow>),
          MemberRow,
          PrefetchHooks Function()
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> photoUrl = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<int> pointsToNextTier = const Value.absent(),
                Value<int> notificationCount = const Value.absent(),
                Value<int> rewardCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                name: name,
                photoUrl: photoUrl,
                tier: tier,
                totalPoints: totalPoints,
                pointsToNextTier: pointsToNextTier,
                notificationCount: notificationCount,
                rewardCount: rewardCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String photoUrl,
                required String tier,
                required int totalPoints,
                required int pointsToNextTier,
                required int notificationCount,
                required int rewardCount,
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                name: name,
                photoUrl: photoUrl,
                tier: tier,
                totalPoints: totalPoints,
                pointsToNextTier: pointsToNextTier,
                notificationCount: notificationCount,
                rewardCount: rewardCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MembersTable, MemberRow>(table),
                  BaseReferences<_$AppDatabase, $MembersTable, MemberRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      MemberRow,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (MemberRow, BaseReferences<_$AppDatabase, $MembersTable, MemberRow>),
      MemberRow,
      PrefetchHooks Function()
    >;
typedef $$ChallengesTableCreateCompanionBuilder = ChallengesCompanion Function({
  required String id,
  required String title,
  required String artwork,
  required String imageUrl,
  required int progress,
  required int goal,
  required int rewardPoints,
  required String tab,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$ChallengesTableUpdateCompanionBuilder = ChallengesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> artwork,
  Value<String> imageUrl,
  Value<int> progress,
  Value<int> goal,
  Value<int> rewardPoints,
  Value<String> tab,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$ChallengesTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artwork => $composableBuilder(
    column: $table.artwork,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tab => $composableBuilder(
    column: $table.tab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChallengesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artwork => $composableBuilder(
    column: $table.artwork,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tab => $composableBuilder(
    column: $table.tab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChallengesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artwork =>
      $composableBuilder(column: $table.artwork, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tab =>
      $composableBuilder(column: $table.tab, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ChallengesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChallengesTable,
          ChallengeRow,
          $$ChallengesTableFilterComposer,
          $$ChallengesTableOrderingComposer,
          $$ChallengesTableAnnotationComposer,
          $$ChallengesTableCreateCompanionBuilder,
          $$ChallengesTableUpdateCompanionBuilder,
          (
            ChallengeRow,
            BaseReferences<_$AppDatabase, $ChallengesTable, ChallengeRow>,
          ),
          ChallengeRow,
          PrefetchHooks Function()
        > {
  $$ChallengesTableTableManager(_$AppDatabase db, $ChallengesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> artwork = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int> goal = const Value.absent(),
                Value<int> rewardPoints = const Value.absent(),
                Value<String> tab = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion(
                id: id,
                title: title,
                artwork: artwork,
                imageUrl: imageUrl,
                progress: progress,
                goal: goal,
                rewardPoints: rewardPoints,
                tab: tab,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String artwork,
                required String imageUrl,
                required int progress,
                required int goal,
                required int rewardPoints,
                required String tab,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion.insert(
                id: id,
                title: title,
                artwork: artwork,
                imageUrl: imageUrl,
                progress: progress,
                goal: goal,
                rewardPoints: rewardPoints,
                tab: tab,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ChallengesTable, ChallengeRow>(table),
                  BaseReferences<_$AppDatabase, $ChallengesTable, ChallengeRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChallengesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChallengesTable,
      ChallengeRow,
      $$ChallengesTableFilterComposer,
      $$ChallengesTableOrderingComposer,
      $$ChallengesTableAnnotationComposer,
      $$ChallengesTableCreateCompanionBuilder,
      $$ChallengesTableUpdateCompanionBuilder,
      (
        ChallengeRow,
        BaseReferences<_$AppDatabase, $ChallengesTable, ChallengeRow>,
      ),
      ChallengeRow,
      PrefetchHooks Function()
    >;
typedef $$SyncMetaTableCreateCompanionBuilder = SyncMetaCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SyncMetaTableUpdateCompanionBuilder = SyncMetaCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SyncMetaTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SyncMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetaTable,
          SyncMetaRow,
          $$SyncMetaTableFilterComposer,
          $$SyncMetaTableOrderingComposer,
          $$SyncMetaTableAnnotationComposer,
          $$SyncMetaTableCreateCompanionBuilder,
          $$SyncMetaTableUpdateCompanionBuilder,
          (
            SyncMetaRow,
            BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaRow>,
          ),
          SyncMetaRow,
          PrefetchHooks Function()
        > {
  $$SyncMetaTableTableManager(_$AppDatabase db, $SyncMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SyncMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => SyncMetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncMetaTable, SyncMetaRow>(table),
                  BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetaTable,
      SyncMetaRow,
      $$SyncMetaTableFilterComposer,
      $$SyncMetaTableOrderingComposer,
      $$SyncMetaTableAnnotationComposer,
      $$SyncMetaTableCreateCompanionBuilder,
      $$SyncMetaTableUpdateCompanionBuilder,
      (SyncMetaRow, BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaRow>),
      SyncMetaRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$BannersTableTableManager get banners =>
      $$BannersTableTableManager(_db, _db.banners);
  $$SectionsTableTableManager get sections =>
      $$SectionsTableTableManager(_db, _db.sections);
  $$SectionProductsTableTableManager get sectionProducts =>
      $$SectionProductsTableTableManager(_db, _db.sectionProducts);
  $$ShopsTableTableManager get shops =>
      $$ShopsTableTableManager(_db, _db.shops);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$ChallengesTableTableManager get challenges =>
      $$ChallengesTableTableManager(_db, _db.challenges);
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db, _db.syncMeta);
}
