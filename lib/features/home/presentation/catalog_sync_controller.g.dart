// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_sync_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Refreshes the catalogue in the background whenever the device goes from
/// offline (or unknown) to online, including at launch. Kept alive so the
/// listener outlives any one screen.

@ProviderFor(CatalogSyncController)
final catalogSyncControllerProvider = CatalogSyncControllerProvider._();

/// Refreshes the catalogue in the background whenever the device goes from
/// offline (or unknown) to online, including at launch. Kept alive so the
/// listener outlives any one screen.
final class CatalogSyncControllerProvider
    extends $NotifierProvider<CatalogSyncController, CatalogSyncState> {
  /// Refreshes the catalogue in the background whenever the device goes from
  /// offline (or unknown) to online, including at launch. Kept alive so the
  /// listener outlives any one screen.
  CatalogSyncControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogSyncControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogSyncControllerHash();

  @$internal
  @override
  CatalogSyncController create() => CatalogSyncController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CatalogSyncState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CatalogSyncState>(value),
    );
  }
}

String _$catalogSyncControllerHash() =>
    r'3a44bee2debbc28394315ff21e8e6d03440c0001';

/// Refreshes the catalogue in the background whenever the device goes from
/// offline (or unknown) to online, including at launch. Kept alive so the
/// listener outlives any one screen.

abstract class _$CatalogSyncController extends $Notifier<CatalogSyncState> {
  CatalogSyncState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CatalogSyncState, CatalogSyncState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CatalogSyncState, CatalogSyncState>,
              CatalogSyncState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
