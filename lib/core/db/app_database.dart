import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:j_donuts/core/db/tables/users_table.dart';

part 'app_database.g.dart';

/// Schema history:
/// - v1: `users`
@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.open() : super(_openConnection());

  static const String fileName = 'j_donuts';

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() => driftDatabase(name: fileName);
}
