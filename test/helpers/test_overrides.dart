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

/// Keeps widget tests off device plugins. Connectivity defaults to offline so
/// no test depends on, or waits for, a network refresh.
List<Override> testOverrides({
  AppDatabase? database,
  KeyValueStore? store,
  ConnectivityService? connectivity,
  Duration latency = Duration.zero,
}) {
  final db = database ?? AppDatabase(NativeDatabase.memory());
  final kv = store ?? InMemoryKeyValueStore();

  return [
    appDatabaseProvider.overrideWith((ref) {
      ref.onDispose(db.close);
      return db;
    }),
    keyValueStoreProvider.overrideWithValue(kv),
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
