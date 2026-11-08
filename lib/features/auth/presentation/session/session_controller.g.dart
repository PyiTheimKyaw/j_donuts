// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Who is signed in on this device.
///
/// `AsyncLoading` while the stored session is being read at launch, then
/// `AsyncData(null)` for signed out or `AsyncData(session)` for signed in.
/// The router's redirect watches this.

@ProviderFor(SessionController)
final sessionControllerProvider = SessionControllerProvider._();

/// Who is signed in on this device.
///
/// `AsyncLoading` while the stored session is being read at launch, then
/// `AsyncData(null)` for signed out or `AsyncData(session)` for signed in.
/// The router's redirect watches this.
final class SessionControllerProvider
    extends $AsyncNotifierProvider<SessionController, AuthSession?> {
  /// Who is signed in on this device.
  ///
  /// `AsyncLoading` while the stored session is being read at launch, then
  /// `AsyncData(null)` for signed out or `AsyncData(session)` for signed in.
  /// The router's redirect watches this.
  SessionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionControllerHash();

  @$internal
  @override
  SessionController create() => SessionController();
}

String _$sessionControllerHash() => r'f38d8f001a76c35eefefe9f30f3d79664a995bd6';

/// Who is signed in on this device.
///
/// `AsyncLoading` while the stored session is being read at launch, then
/// `AsyncData(null)` for signed out or `AsyncData(session)` for signed in.
/// The router's redirect watches this.

abstract class _$SessionController extends $AsyncNotifier<AuthSession?> {
  FutureOr<AuthSession?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AuthSession?>, AuthSession?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthSession?>, AuthSession?>,
              AsyncValue<AuthSession?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
