import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/network/connectivity_service.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/home/home_providers.dart';
import 'package:j_donuts/features/home/presentation/catalog_sync_controller.dart';

import '../../../helpers/catalog_fixtures.dart';
import '../../../helpers/test_overrides.dart';

void main() {
  late CatalogHarness harness;
  late StaticConnectivityService connectivity;
  late ProviderContainer container;

  ProviderContainer build({required bool online}) {
    connectivity = StaticConnectivityService(online: online);
    final created = ProviderContainer(
      overrides: [
        ...testOverrides(connectivity: connectivity),
        catalogRepositoryProvider.overrideWithValue(harness.repository),
      ],
    );
    addTearDown(created.dispose);
    return created;
  }

  CatalogSyncController controller() =>
      container.read(catalogSyncControllerProvider.notifier);

  setUp(() => harness = CatalogHarness());
  tearDown(() async {
    await connectivity.dispose();
    await harness.dispose();
  });

  group('CatalogSyncController', () {
    test('refreshes in the background when launched online', () async {
      container = build(online: true)
        ..listen(catalogSyncControllerProvider, (_, _) {});

      await eventually(() => harness.remote.calls == 1);
      await eventually(
        () =>
            container.read(catalogSyncControllerProvider).lastSyncedAt != null,
      );
      expect(
        container.read(catalogSyncControllerProvider).lastSyncedAt,
        harness.now,
      );
    });

    test('stays quiet while offline', () async {
      container = build(online: false)
        ..listen(catalogSyncControllerProvider, (_, _) {});
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(harness.remote.calls, 0);
    });

    test('refreshes once the network returns', () async {
      container = build(online: false)
        ..listen(catalogSyncControllerProvider, (_, _) {});
      await Future<void>.delayed(const Duration(milliseconds: 50));

      connectivity.setOnline(online: true);

      await eventually(() => harness.remote.calls == 1);
    });

    test('pull-to-refresh offline reports the failure', () async {
      container = build(online: false);
      harness.remote.failure = const NetworkFailure(message: 'offline');

      final result = await controller().refresh();

      expect(result.failureOrNull, isA<NetworkFailure>());
      expect(
        container.read(catalogSyncControllerProvider).lastFailure,
        isA<NetworkFailure>(),
      );
    });

    test('overlapping refresh requests share one network call', () async {
      container = build(online: false);

      await Future.wait([controller().refresh(), controller().refresh()]);

      expect(harness.remote.calls, 1);
    });
  });
}

/// Waits for async work (seed, DB writes) that needs more microtask hops
/// than `pumpEventQueue` allows; fails with a clear reason instead of hanging.
Future<void> eventually(
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 2),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) fail('Condition not met in $timeout');
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
}
