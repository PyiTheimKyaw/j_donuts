import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/core/time/clock.dart';
import 'package:j_donuts/features/auth/auth_providers.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/domain/validators/validators.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_state.dart';
import 'package:j_donuts/features/auth/presentation/session/session_controller.dart';
import 'package:j_donuts/features/auth/presentation/session/welcome_pending.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_flow_controller.g.dart';

/// Kept alive because Onboarding sets the intent before any step is listening;
/// an auto-disposed provider would drop it. [start] resets the state instead.
@Riverpod(keepAlive: true)
class AuthFlowController extends _$AuthFlowController {
  @override
  AuthFlowState build() => const AuthFlowState();

  void start(AuthIntent intent) {
    ref.read(welcomePendingProvider.notifier).clear();
    state = AuthFlowState(intent: intent);
  }

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

  void firstNameChanged(String value) =>
      state = state.copyWith(firstName: value, error: null);

  void lastNameChanged(String value) =>
      state = state.copyWith(lastName: value, error: null);

  void birthMonthChanged(int month) =>
      state = state.copyWith(birthMonth: month, error: null);

  void birthDayChanged(int? day) =>
      state = state.copyWith(birthDay: day, error: null);

  void birthYearChanged(int? year) =>
      state = state.copyWith(birthYear: year, error: null);

  Result<String> get firstNameResult =>
      NameValidator.validateFirst(state.firstName);

  Result<String?> get lastNameResult =>
      NameValidator.validateLast(state.lastName);

  bool get isNameValid => firstNameResult.isSuccess && lastNameResult.isSuccess;

  Result<BirthDate> get birthDateResult => BirthDateValidator.validate(
    year: state.birthYear,
    month: state.birthMonth,
    day: state.birthDay,
    today: ref.read(clockProvider)(),
  );

  /// Marks Welcome as pending before the session starts, because the session
  /// change is what triggers the redirect away from this step.
  Future<bool> completeRegistration() async {
    final details = _registrationDetails();
    if (details == null || state.isSubmitting) return false;

    state = state.copyWith(isSubmitting: true, error: null);
    final result = await ref.read(registerUserProvider).call(details);
    state = state.copyWith(isSubmitting: false, error: result.failureOrNull);

    final session = result.valueOrNull;
    if (session == null) return false;
    ref.read(welcomePendingProvider.notifier).markPending();
    ref.read(sessionControllerProvider.notifier).signedIn(session);
    return true;
  }

  RegistrationDetails? _registrationDetails() {
    final phone = state.phone;
    final firstName = firstNameResult.valueOrNull;
    final lastName = lastNameResult;
    final birthDate = birthDateResult.valueOrNull;
    if (phone == null || firstName == null || birthDate == null) return null;
    if (lastName.isFailure) return null;
    return RegistrationDetails(
      phone: phone,
      name: PersonName(firstName: firstName, lastName: lastName.valueOrNull),
      birthDate: birthDate,
    );
  }
}
