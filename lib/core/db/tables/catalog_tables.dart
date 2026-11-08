import 'package:drift/drift.dart';

/// Schema v2. `assetFallback` survives remote upserts (they never write it),
/// so a row refreshed with an https URL still has its bundled copy offline.

@DataClassName('ProductRow')
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get priceMmk => integer()();
  BoolColumn get isNew => boolean().withDefault(const Constant(false))();
  IntColumn get discountPercent => integer().nullable()();
  TextColumn get imageUrl => text()();
  TextColumn get assetFallback => text().nullable()();
  TextColumn get description => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('BannerRow')
class Banners extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get badge => text().nullable()();
  TextColumn get style => text()();
  TextColumn get imageUrl => text()();
  TextColumn get assetFallback => text().nullable()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SectionRow')
class Sections extends Table {
  TextColumn get id => text()();
  TextColumn get kind => text()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SectionProductRow')
class SectionProducts extends Table {
  TextColumn get sectionId =>
      text().references(Sections, #id, onDelete: KeyAction.cascade)();
  TextColumn get productId =>
      text().references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();

  @override
  Set<Column<Object>> get primaryKey => {sectionId, productId};
}

@DataClassName('ShopRow')
class Shops extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get imageUrl => text()();
  TextColumn get assetFallback => text().nullable()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MemberRow')
class Members extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get photoUrl => text()();
  TextColumn get tier => text()();
  IntColumn get totalPoints => integer()();
  IntColumn get pointsToNextTier => integer()();
  IntColumn get notificationCount => integer()();
  IntColumn get rewardCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ChallengeRow')
class Challenges extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get artwork => text()();
  TextColumn get imageUrl => text()();
  IntColumn get progress => integer()();
  IntColumn get goal => integer()();
  IntColumn get rewardPoints => integer()();
  TextColumn get tab => text()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SyncMetaRow')
class SyncMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
