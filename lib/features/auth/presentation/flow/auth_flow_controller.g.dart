// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kept alive because Onboarding sets the intent before any step is listening;
/// an auto-disposed provider would drop it. [start] resets the state instead.

@ProviderFor(AuthFlowController)
final authFlowControllerProvider = AuthFlowControllerProvider._();

/// Kept alive because Onboarding sets the intent before any step is listening;
/// an auto-disposed provider would drop it. [start] resets the state instead.
final class AuthFlowControllerProvider
    extends $NotifierProvider<AuthFlowController, AuthFlowState> {
  /// Kept alive because Onboarding sets the intent before any step is listening;
  /// an auto-disposed provider would drop it. [start] resets the state instead.
  AuthFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authFlowControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authFlowControllerHash();

  @$internal
  @override
  AuthFlowController create() => AuthFlowController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthFlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthFlowState>(value),
    );
  }
}

String _$authFlowControllerHash() =>
    r'5b259e8da04b550fe1c6dad701db68a9d438f15b';

/// Kept alive because Onboarding sets the intent before any step is listening;
/// an auto-disposed provider would drop it. [start] resets the state instead.

abstract class _$AuthFlowController extends $Notifier<AuthFlowState> {
  AuthFlowState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AuthFlowState, AuthFlowState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthFlowState, AuthFlowState>,
              AuthFlowState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
