import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/network/connectivity_service.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/features/auth/data/repositories/secure_session_repository.dart';

import 'pump_app.dart';
import 'test_overrides.dart';

/// A session for the seeded number, as if the member logged in earlier.
InMemoryKeyValueStore signedInStore() => InMemoryKeyValueStore({
  SecureSessionRepository.storageKey:
      '{"phone":"9254135592","startedAt":"2026-11-08T00:00:00.000Z"}',
});

extension SignedInApp on WidgetTester {
  /// Boots straight into the shell. Offline by default, so Home is rendered
  /// purely from the seeded local database.
  Future<StaticConnectivityService> pumpSignedInApp({
    bool online = false,
  }) async {
    final connectivity = StaticConnectivityService(online: online);
    addTearDown(connectivity.dispose);
    await pumpApp(
      overrides: testOverrides(
        store: signedInStore(),
        connectivity: connectivity,
      ),
    );
    return connectivity;
  }
}
