import 'dart:convert';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/features/home/data/datasources/seed_loader.dart';

import '../../../helpers/catalog_fixtures.dart';

void main() {
  late AppDatabase database;

  setUp(() => database = AppDatabase(NativeDatabase.memory()));
  tearDown(() => database.close());

  SeedLoader loader([AssetLoader? loadAsset]) =>
      SeedLoader(database: database, loadAsset: loadAsset ?? seedAssetLoader());

  Future<int> count(TableInfo<Table, dynamic> table) async =>
      (await database.select(table).get()).length;

  group('SeedLoader', () {
    test('populates every table from the bundled JSON', () async {
      await loader().ensureSeeded();

      expect(await count(database.products), 9);
      expect(await count(database.banners), 2);
      expect(await count(database.sections), 3);
      expect(await count(database.shops), 4);
      expect(await count(database.members), 1);
      expect(await count(database.challenges), 4);
    });

    test('keeps bundled paths as the offline image fallback', () async {
      await loader().ensureSeeded();

      final coconut = await (database.select(
        database.products,
      )..where((row) => row.id.equals('p_coconut'))).getSingle();
      expect(coconut.assetFallback, 'images/products/coconut_donut.jpg');
    });

    test('does not overwrite local changes on a later launch', () async {
      await loader().ensureSeeded();
      await database
          .update(database.members)
          .write(const MembersCompanion(totalPoints: Value(1)));

      await loader().ensureSeeded();

      final member = await database.select(database.members).getSingle();
      expect(member.totalPoints, 1);
    });

    test('re-seeds when a newer seed version ships', () async {
      await loader().ensureSeeded();
      await database
          .update(database.members)
          .write(const MembersCompanion(totalPoints: Value(1)));
      final newer = decodeFixture(seedFixture)..['version'] = 2;

      await loader(seedAssetLoader(jsonEncode(newer))).ensureSeeded();

      final member = await database.select(database.members).getSingle();
      expect(member.totalPoints, 680000);
    });

    test('concurrent callers share a single seed pass', () async {
      var loads = 0;
      final seed = loader((key) async {
        loads++;
        return seedFixture;
      });

      await Future.wait([seed.ensureSeeded(), seed.ensureSeeded()]);

      expect(loads, 1);
    });

    test('a failed seed can be retried', () async {
      var attempt = 0;
      final seed = loader((key) async {
        attempt++;
        if (attempt == 1) throw const FormatException('corrupt asset');
        return seedFixture;
      });

      await expectLater(seed.ensureSeeded(), throwsFormatException);
      await seed.ensureSeeded();

      expect(await count(database.products), 9);
    });
  });
}
