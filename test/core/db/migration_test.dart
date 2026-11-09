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

  group('AppDatabase migration from v1', () {
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

    test('records the current schema version', () async {
      final version = await database
          .customSelect('PRAGMA user_version')
          .map((row) => row.read<int>('user_version'))
          .getSingle();

      expect(version, database.schemaVersion);
    });

    test('new tables are writable after the upgrade', () async {
      await database
          .into(database.syncMeta)
          .insert(SyncMetaCompanion.insert(key: 'k', value: 'v'));

      expect(await database.select(database.syncMeta).get(), hasLength(1));
    });
  });

  test('a fresh install creates the latest schema directly', () async {
    final fresh = AppDatabase(NativeDatabase.memory());
    addTearDown(fresh.close);

    expect(await fresh.select(fresh.products).get(), isEmpty);
    expect(fresh.schemaVersion, 3);
  });

  group('AppDatabase migration from v2', () {
    late AppDatabase v2;

    setUp(() {
      v2 = AppDatabase(
        NativeDatabase.memory(
          setup: (raw) {
            raw
              ..execute(_v1UsersTable)
              ..execute(_v2MembersTable)
              ..execute(
                "INSERT INTO members VALUES ('m_current', 'Hania', "
                "'asset://images/member/avatar.jpg', 'silver', 680000, 500, "
                '2, 3)',
              )
              ..userVersion = 2;
          },
        ),
      );
    });

    tearDown(() => v2.close());

    test('adds tier_start_points and keeps the member', () async {
      final member = await v2.select(v2.members).getSingle();

      expect(member.totalPoints, 680000);
      expect(member.tierStartPoints, 0);
    });
  });
}

/// The members table as shipped in v2, before tier_start_points.
const String _v2MembersTable = '''
CREATE TABLE members (
  id TEXT NOT NULL,
  name TEXT NOT NULL,
  photo_url TEXT NOT NULL,
  tier TEXT NOT NULL,
  total_points INTEGER NOT NULL,
  points_to_next_tier INTEGER NOT NULL,
  notification_count INTEGER NOT NULL,
  reward_count INTEGER NOT NULL,
  PRIMARY KEY (id)
)''';
