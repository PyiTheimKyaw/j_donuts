import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class ReachabilityProbe {
  Future<bool> canReachInternet();
}

/// A DNS lookup proves more than an interface being up: hotel Wi-Fi behind a
/// captive portal or a router with no uplink both report "wifi" yet resolve
/// nothing.
class DnsReachabilityProbe implements ReachabilityProbe {
  const DnsReachabilityProbe({
    this.host = defaultHost,
    this.timeout = defaultTimeout,
  });

  static const String defaultHost = 'one.one.one.one';
  static const Duration defaultTimeout = Duration(seconds: 3);

  final String host;
  final Duration timeout;

  @override
  Future<bool> canReachInternet() async {
    try {
      final addresses = await InternetAddress.lookup(host).timeout(timeout);
      return addresses.any((address) => address.rawAddress.isNotEmpty);
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }
}

abstract interface class ConnectivityService {
  Future<bool> isOnline();

  /// Emits the current state first, then only on change.
  Stream<bool> watchOnline();
}

class DeviceConnectivityService implements ConnectivityService {
  DeviceConnectivityService({
    required this._connectivity,
    required this._probe,
  });

  final Connectivity _connectivity;
  final ReachabilityProbe _probe;

  @override
  Future<bool> isOnline() async =>
      await _resolve(await _connectivity.checkConnectivity());

  /// A plain controller rather than `async*`: cancelling an `async*` stream
  /// parked in `await for` never completes, which would leak the platform
  /// subscription every time the provider is disposed. Checks are chained so
  /// a slow initial probe cannot overwrite a newer change.
  @override
  Stream<bool> watchOnline() {
    StreamSubscription<List<ConnectivityResult>>? platformChanges;
    var queue = Future<void>.value();
    bool? last;
    late final StreamController<bool> controller;

    void enqueue(Future<List<ConnectivityResult>> Function() read) {
      queue = queue.then((_) async {
        final online = await _resolve(await read());
        if (controller.isClosed || online == last) return;
        last = online;
        controller.add(online);
      });
    }

    controller = StreamController<bool>(
      onListen: () {
        enqueue(_connectivity.checkConnectivity);
        platformChanges = _connectivity.onConnectivityChanged.listen(
          (interfaces) => enqueue(() async => interfaces),
        );
      },
      onCancel: () => platformChanges?.cancel(),
    );
    return controller.stream;
  }

  /// Skips the probe when no interface is up; airplane mode answers instantly.
  Future<bool> _resolve(List<ConnectivityResult> interfaces) async {
    final hasInterface = interfaces.any(
      (result) => result != ConnectivityResult.none,
    );
    return hasInterface && await _probe.canReachInternet();
  }
}

/// Fixed answer for tests and previews.
class StaticConnectivityService implements ConnectivityService {
  StaticConnectivityService({required this._online});

  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  bool _online;

  void setOnline({required bool online}) {
    _online = online;
    _controller.add(online);
  }

  @override
  Future<bool> isOnline() async => _online;

  @override
  Stream<bool> watchOnline() async* {
    yield _online;
    yield* _controller.stream;
  }

  Future<void> dispose() => _controller.close();
}
