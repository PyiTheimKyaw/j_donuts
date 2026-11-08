import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:j_donuts/core/network/network_providers.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/home/home_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'catalog_sync_controller.g.dart';

final class CatalogSyncState extends Equatable {
  const CatalogSyncState({
    this.isRefreshing = false,
    this.lastSyncedAt,
    this.lastFailure,
  });

  final bool isRefreshing;
  final DateTime? lastSyncedAt;
  final Failure? lastFailure;

  @override
  List<Object?> get props => [isRefreshing, lastSyncedAt, lastFailure];
}

/// Refreshes the catalogue in the background whenever the device goes from
/// offline (or unknown) to online, including at launch. Something must listen
/// to it for the app's lifetime: Riverpod 3 pauses the `ref.listen` of a
/// provider nobody listens to, and keep-alive alone does not prevent that.
@Riverpod(keepAlive: true)
class CatalogSyncController extends _$CatalogSyncController {
  Future<Result<DateTime>>? _inFlight;

  @override
  CatalogSyncState build() {
    ref.listen(isOnlineProvider, (previous, next) {
      final wasOnline = previous?.value ?? false;
      if (next.value == true && !wasOnline) unawaited(refresh());
    }, fireImmediately: true);
    return const CatalogSyncState();
  }

  /// Pull-to-refresh and the reconnect listener share one request.
  Future<Result<DateTime>> refresh() =>
      _inFlight ??= _refresh().whenComplete(() => _inFlight = null);

  Future<Result<DateTime>> _refresh() async {
    state = CatalogSyncState(
      isRefreshing: true,
      lastSyncedAt: state.lastSyncedAt,
    );
    final result = await ref.read(refreshCatalogProvider).call();
    state = CatalogSyncState(
      lastSyncedAt: result.valueOrNull ?? state.lastSyncedAt,
      lastFailure: result.failureOrNull,
    );
    return result;
  }
}
