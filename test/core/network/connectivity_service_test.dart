import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/network/connectivity_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockConnectivity extends Mock implements Connectivity;

class _CountingProbe implements ReachabilityProbe {
  _CountingProbe({required this.reachable});

  bool reachable;
  int probes = 0;

  @override
  Future<bool> canReachInternet() async {
    probes++;
    return reachable;
  }
}

void main() {
  late _MockConnectivity connectivity;
  late StreamController<List<ConnectivityResult>> changes;

  setUp(() {
    connectivity = _MockConnectivity();
    changes = StreamController<List<ConnectivityResult>>.broadcast();
    when(() => connectivity.onConnectivityChanged)
        .thenAnswer((_) => changes.stream);
  });

  tearDown(() => changes.close());

  void currently(List<ConnectivityResult> interfaces) =>
      when(connectivity.checkConnectivity).thenAnswer((_) async => interfaces);

  DeviceConnectivityService service(_CountingProbe probe) =>
      DeviceConnectivityService(connectivity: connectivity, probe: probe);

  group('DeviceConnectivityService.isOnline', () {
    test('airplane mode is offline without probing', () async {
      currently([ConnectivityResult.none]);
      final probe = _CountingProbe(reachable: true);

      expect(await service(probe).isOnline(), isFalse);
      expect(probe.probes, 0);
    });

    test('Wi-Fi without internet is offline', () async {
      currently([ConnectivityResult.wifi]);

      expect(
        await service(_CountingProbe(reachable: false)).isOnline(),
        isFalse,
      );
    });

    test('Wi-Fi with internet is online', () async {
      currently([ConnectivityResult.wifi]);

      expect(await service(_CountingProbe(reachable: true)).isOnline(), isTrue);
    });
  });

  group('DeviceConnectivityService.watchOnline', () {
    test('emits the current state, then only real changes', () async {
      currently([ConnectivityResult.none]);
      final probe = _CountingProbe(reachable: true);
      final emitted = <bool>[];
      final subscription = service(probe).watchOnline().listen(emitted.add);
      await pumpEventQueue();

      changes
        ..add([ConnectivityResult.none])
        ..add([ConnectivityResult.wifi])
        ..add([ConnectivityResult.mobile]);
      await pumpEventQueue();
      await subscription.cancel();

      expect(emitted, [false, true]);
    });
  });
}
