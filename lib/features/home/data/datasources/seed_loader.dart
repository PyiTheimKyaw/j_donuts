import 'dart:async';
import 'dart:convert';

import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/features/home/data/datasources/catalog_local_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/member_local_data_source.dart';
import 'package:j_donuts/features/home/data/dto/catalog_dto.dart';
import 'package:j_donuts/features/home/data/mappers/catalog_mapper.dart';
import 'package:j_donuts/features/rewards/data/datasources/challenge_local_data_source.dart';

typedef AssetLoader = Future<String> Function(String key);

/// Populates the database from bundled JSON so the very first launch works
/// with no network. Runs once per seed version; bumping the version in a later
/// app build re-seeds.
class SeedLoader {
  SeedLoader({required this._database, required this._loadAsset});

  static const String seedAsset = 'assets/seed/seed.json';

  final AppDatabase _database;
  final AssetLoader _loadAsset;
  Future<void>? _seeding;

  /// Memoised so concurrent watchers share one seed pass; cleared on failure
  /// so a later call can retry.
  Future<void> ensureSeeded() async {
    final pending = _seeding ??= _seedIfNeeded();
    try {
      await pending;
    } on Object {
      if (identical(_seeding, pending)) _seeding = null;
      rethrow;
    }
  }

  Future<void> _seedIfNeeded() async {
    final catalog = CatalogLocalDataSource(_database);
    final seed = SeedDto.fromJson(
      jsonDecode(await _loadAsset(seedAsset)) as Map<String, dynamic>,
    );
    final storedVersion = int.tryParse(
      await catalog.readMeta(CatalogLocalDataSource.seedVersionKey) ?? '',
    );
    if ((storedVersion ?? 0) >= seed.version) return;

    await _database.transaction(() async {
      await catalog.replaceCatalog(seed.catalog, fromSeed: true);
      await MemberLocalDataSource(_database)
          .upsert(CatalogMapper.memberCompanion(seed.member));
      await ChallengeLocalDataSource(_database).upsertAll([
        for (final (index, challenge) in seed.challenges.indexed)
          CatalogMapper.challengeCompanion(challenge, index),
      ]);
      await catalog.writeMeta(
        CatalogLocalDataSource.seedVersionKey,
        '${seed.version}',
      );
    });
  }
}
