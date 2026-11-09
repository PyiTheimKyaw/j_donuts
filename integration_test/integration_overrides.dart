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

/// Runs on a real device, so unlike the widget-test overrides it keeps the
/// real asset bundle (the bundled seed and images) and only isolates state:
/// a fresh in-memory database, an in-memory session store, no network and no
/// fake latency. Every run starts from a clean first launch.
List<Override> integrationOverrides() {
  final database = AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
  final store = InMemoryKeyValueStore();

  return [
    appDatabaseProvider.overrideWith((ref) {
      ref.onDispose(database.close);
      return database;
    }),
    keyValueStoreProvider.overrideWithValue(store),
    connectivityServiceProvider.overrideWithValue(
      StaticConnectivityService(online: false),
    ),
    authRepositoryProvider.overrideWith(
      (ref) => FakeAuthRepository(
        users: ref.watch(userLocalDataSourceProvider),
        sessions: SecureSessionRepository(store),
        latency: Duration.zero,
      ),
    ),
  ];
}
