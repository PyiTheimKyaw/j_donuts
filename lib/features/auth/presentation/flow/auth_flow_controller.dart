import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/auth/auth_providers.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/domain/validators/validators.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_state.dart';
import 'package:j_donuts/features/auth/presentation/session/session_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_flow_controller.g.dart';

/// Kept alive because Onboarding sets the intent before any step is listening;
/// an auto-disposed provider would drop it. [start] resets the state instead.
@Riverpod(keepAlive: true)
class AuthFlowController extends _$AuthFlowController {
  @override
  AuthFlowState build() => const AuthFlowState();

  void start(AuthIntent intent) => state = AuthFlowState(intent: intent);

  void switchToRegister() =>
      state = state.copyWith(intent: AuthIntent.register, error: null);

  void phoneChanged(String input) => state = state.copyWith(
    phoneInput: input,
    phone: PhoneValidator.validate(input).valueOrNull,
    error: null,
  );

  /// Returns true when the step may advance. A second call while a request is
  /// in flight is a no-op, which is what makes a double tap harmless.
  Future<bool> submitPhone() async {
    final phone = state.phone;
    if (phone == null || state.isSubmitting) return false;

    state = state.copyWith(isSubmitting: true, error: null);
    final result = await ref.read(requestOtpProvider).call(phone, state.intent);
    state = state.copyWith(isSubmitting: false, error: result.failureOrNull);
    return result.isSuccess;
  }

  /// A [ReturningUser] is signed in here so the router redirect, not the
  /// screen, decides where they land.
  Future<OtpVerification?> verifyOtp(String input) async {
    final phone = state.phone;
    final code = OtpValidator.validate(input).valueOrNull;
    if (phone == null || code == null) return null;
    if (state.isSubmitting || state.isOtpLocked) return null;

    state = state.copyWith(isSubmitting: true, error: null);
    final result = await ref.read(verifyOtpProvider).call(phone, code);
    final failure = result.failureOrNull;
    state = state.copyWith(
      isSubmitting: false,
      error: failure,
      isOtpLocked: failure is OtpLockedFailure,
    );

    final outcome = result.valueOrNull;
    if (outcome is ReturningUser) {
      ref.read(sessionControllerProvider.notifier).signedIn(outcome.session);
    }
    return outcome;
  }

  /// Requesting a new code is what lifts an OTP lock.
  Future<bool> resendOtp() async {
    final phone = state.phone;
    if (phone == null || state.isSubmitting) return false;

    state = state.copyWith(isSubmitting: true, error: null);
    final result = await ref.read(requestOtpProvider).call(phone, state.intent);
    state = state.copyWith(
      isSubmitting: false,
      error: result.failureOrNull,
      isOtpLocked: result.isFailure && state.isOtpLocked,
    );
    return result.isSuccess;
  }
}
