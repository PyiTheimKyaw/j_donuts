import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/db/app_database.dart';

/// The exact v1 schema shipped before the catalogue existed.
const String _v1UsersTable = '''
CREATE TABLE users (
  phone TEXT NOT NULL,
  first_name TEXT NOT NULL,
  last_name TEXT NULL,
  birth_date TEXT NOT NULL,
  created_at TEXT NOT NULL,
  PRIMARY KEY (phone)
)''';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(
      NativeDatabase.memory(
        setup: (raw) {
          raw
            ..execute(_v1UsersTable)
            ..execute(
              "INSERT INTO users VALUES ('9254135592', 'Ye Min', NULL, "
              "'1980-05-01', '2026-11-01T00:00:00.000')",
            )
            ..userVersion = 1;
        },
      ),
    );
  });

  tearDown(() => database.close());

  group('AppDatabase migration v1 to v2', () {
    test('keeps users registered under v1', () async {
      final users = await database.select(database.users).get();

      expect(users.single.firstName, 'Ye Min');
    });

    test('creates every catalogue table', () async {
      final tables = await database
          .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
          .map((row) => row.read<String>('name'))
          .get();

      expect(
        tables,
        containsAll([
          'products',
          'banners',
          'sections',
          'section_products',
          'shops',
          'members',
          'challenges',
          'sync_meta',
        ]),
      );
    });

    test('records schema version 2', () async {
      final version = await database
          .customSelect('PRAGMA user_version')
          .map((row) => row.read<int>('user_version'))
          .getSingle();

      expect(version, 2);
    });

    test('new tables are writable after the upgrade', () async {
      await database
          .into(database.syncMeta)
          .insert(SyncMetaCompanion.insert(key: 'k', value: 'v'));

      expect(await database.select(database.syncMeta).get(), hasLength(1));
    });
  });

  test('a fresh install creates v2 directly', () async {
    final fresh = AppDatabase(NativeDatabase.memory());
    addTearDown(fresh.close);

    expect(await fresh.select(fresh.products).get(), isEmpty);
    expect(fresh.schemaVersion, 2);
  });
}
