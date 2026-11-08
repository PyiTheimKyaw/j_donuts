import 'package:j_donuts/features/auth/auth_providers.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/domain/validators/validators.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_state.dart';
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
}
