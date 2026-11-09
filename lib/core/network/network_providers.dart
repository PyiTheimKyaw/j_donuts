import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:j_donuts/core/network/connectivity_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_providers.g.dart';

@Riverpod(keepAlive: true)
ConnectivityService connectivityService(Ref ref) => DeviceConnectivityService(
  connectivity: Connectivity(),
  probe: const DnsReachabilityProbe(),
);

@Riverpod(keepAlive: true)
Stream<bool> isOnline(Ref ref) =>
    ref.watch(connectivityServiceProvider).watchOnline();
