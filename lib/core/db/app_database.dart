import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:j_donuts/core/db/tables/catalog_tables.dart';
import 'package:j_donuts/core/db/tables/users_table.dart';

part 'app_database.g.dart';

/// Schema history:
/// - v1: `users`
/// - v2: catalogue (`products`, `banners`, `sections`, `section_products`,
///   `shops`), loyalty (`members`, `challenges`) and `sync_meta`
/// - v3: `members.tier_start_points`
@DriftDatabase(
  tables: [
    Users,
    Products,
    Banners,
    Sections,
    SectionProducts,
    Shops,
    Members,
    Challenges,
    SyncMeta,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.open() : super(_openConnection());

  static const String fileName = 'j_donuts';

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) await _addCatalogTables(migrator);
      // createTable above already uses the latest columns, so a v1 database
      // gets tier_start_points there; only an existing v2 table needs it added.
      if (from == 2) {
        await migrator.addColumn(members, members.tierStartPoints);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Additive only: v1 users and their sessions must survive the upgrade.
  Future<void> _addCatalogTables(Migrator migrator) async {
    for (final table in <TableInfo<Table, dynamic>>[
      products,
      banners,
      sections,
      sectionProducts,
      shops,
      members,
      challenges,
      syncMeta,
    ]) {
      await migrator.createTable(table);
    }
  }

  static QueryExecutor _openConnection() => driftDatabase(name: fileName);
}
