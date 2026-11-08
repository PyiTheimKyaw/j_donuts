// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Application router.
///
/// Phase 0 wires every path to a placeholder so the navigation graph and the
/// auth redirect seam exist before the screens do. Real screens replace the
/// builders feature by feature.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// Application router.
///
/// Phase 0 wires every path to a placeholder so the navigation graph and the
/// auth redirect seam exist before the screens do. Real screens replace the
/// builders feature by feature.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Application router.
  ///
  /// Phase 0 wires every path to a placeholder so the navigation graph and the
  /// auth redirect seam exist before the screens do. Real screens replace the
  /// builders feature by feature.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'23a0aee0b60527659da897a58cbda5f03263fb42';
