import 'dart:io';

import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/core/db/database_provider.dart';
import 'package:j_donuts/core/network/connectivity_service.dart';
import 'package:j_donuts/core/network/network_providers.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/features/auth/auth_providers.dart';
import 'package:j_donuts/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:j_donuts/features/auth/data/repositories/secure_session_repository.dart';
import 'package:j_donuts/features/home/data/datasources/remote_catalog_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/seed_loader.dart';
import 'package:j_donuts/features/home/home_providers.dart';

/// Keeps widget tests off device plugins, the shared asset cache and
/// simulated network latency. Connectivity defaults to offline so
/// no test depends on, or waits for, a network refresh.
List<Override> testOverrides({
  AppDatabase? database,
  KeyValueStore? store,
  ConnectivityService? connectivity,
  Duration latency = Duration.zero,

  /// False when the same database must survive a simulated relaunch; the
  /// caller then closes it.
  bool closeDatabaseOnDispose = true,
}) {
  final db = database ?? testDatabase();
  final kv = store ?? InMemoryKeyValueStore();

  return [
    appDatabaseProvider.overrideWith((ref) {
      if (closeDatabaseOnDispose) ref.onDispose(db.close);
      return db;
    }),
    keyValueStoreProvider.overrideWithValue(kv),
    assetLoaderProvider.overrideWithValue(readAssetFromDisk),
    remoteCatalogDataSourceProvider.overrideWith(
      (ref) => AssetRemoteCatalogDataSource(
        loadAsset: readAssetFromDisk,
        isOnline: ref.watch(connectivityServiceProvider).isOnline,
        latency: Duration.zero,
      ),
    ),
    connectivityServiceProvider.overrideWithValue(
      connectivity ?? StaticConnectivityService(online: false),
    ),
    authRepositoryProvider.overrideWith(
      (ref) => FakeAuthRepository(
        users: ref.watch(userLocalDataSourceProvider),
        sessions: SecureSessionRepository(kv),
        latency: latency,
      ),
    ),
  ];
}

/// Closes query streams synchronously: drift otherwise keeps a closed stream
/// cached for one event-loop turn via `Timer.run`, which outlives the widget
/// tree and fails `testWidgets`' pending-timer check.
AppDatabase testDatabase() => AppDatabase(
  DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true),
);

/// Fixed seed for tests, so editing the app's seed content never breaks a
/// behaviour test.
const String seedFixturePath = 'test/fixtures/seed_v1.json';

/// `rootBundle` caches each asset as a Future created in the first test's
/// fake-async zone; a later test awaiting that cached Future never resolves.
/// A synchronous read sidesteps both the cache and the zone.
Future<String> readAssetFromDisk(String key) async =>
    File(key == SeedLoader.seedAsset ? seedFixturePath : key)
        .readAsStringSync();
