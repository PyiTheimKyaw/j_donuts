// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_pending.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Set just before a new account's session starts so the redirect sends the
/// user to Welcome instead of Home. Not persisted: a relaunch skips Welcome.

@ProviderFor(WelcomePending)
final welcomePendingProvider = WelcomePendingProvider._();

/// Set just before a new account's session starts so the redirect sends the
/// user to Welcome instead of Home. Not persisted: a relaunch skips Welcome.
final class WelcomePendingProvider
    extends $NotifierProvider<WelcomePending, bool> {
  /// Set just before a new account's session starts so the redirect sends the
  /// user to Welcome instead of Home. Not persisted: a relaunch skips Welcome.
  WelcomePendingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'welcomePendingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$welcomePendingHash();

  @$internal
  @override
  WelcomePending create() => WelcomePending();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$welcomePendingHash() => r'567aecb93ca8b5bb238d73e130c1e68aeeb26b93';

/// Set just before a new account's session starts so the redirect sends the
/// user to Welcome instead of Home. Not persisted: a relaunch skips Welcome.

abstract class _$WelcomePending extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
