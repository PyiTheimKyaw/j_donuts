import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';

abstract interface class AuthRepository {
  /// [AuthIntent.logIn] with an unknown number fails with
  /// `NotRegisteredFailure`. Also resets the wrong-attempt counter.
  FutureResult<void> requestOtp(PhoneNumber phone, AuthIntent intent);

  /// `InvalidOtpFailure` carries attempts left; `OtpLockedFailure` once the
  /// limit is hit. A [ReturningUser] result already has a started session.
  FutureResult<OtpVerification> verifyOtp(PhoneNumber phone, OtpCode code);

  FutureResult<AuthSession> register(RegistrationDetails details);

  FutureResult<UserProfile> profileOf(PhoneNumber phone);

  FutureResult<AuthSession?> currentSession();

  FutureResult<void> logOut();
}
