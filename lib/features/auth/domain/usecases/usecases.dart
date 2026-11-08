import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/domain/repositories/auth_repository.dart';

/// Use cases are the only entry points the presentation layer calls.
///
/// They are thin on purpose: each names one user action and delegates to the
/// repository, which keeps screens free of repository details and gives tests
/// a single seam to mock.

/// Sends a one-time code to a phone number.
final class RequestOtp {
  const RequestOtp(this._repository);

  final AuthRepository _repository;

  FutureResult<void> call(PhoneNumber phone, AuthIntent intent) =>
      _repository.requestOtp(phone, intent);
}

/// Checks the code the user typed and reports whether they are new.
final class VerifyOtp {
  const VerifyOtp(this._repository);

  final AuthRepository _repository;

  FutureResult<OtpVerification> call(PhoneNumber phone, OtpCode code) =>
      _repository.verifyOtp(phone, code);
}

/// Completes registration for a new user.
final class RegisterUser {
  const RegisterUser(this._repository);

  final AuthRepository _repository;

  FutureResult<AuthSession> call(RegistrationDetails details) =>
      _repository.register(details);
}

/// Loads the stored session when the app launches.
final class RestoreSession {
  const RestoreSession(this._repository);

  final AuthRepository _repository;

  FutureResult<AuthSession?> call() => _repository.currentSession();
}

/// Loads the signed-in user's profile.
final class GetProfile {
  const GetProfile(this._repository);

  final AuthRepository _repository;

  FutureResult<UserProfile> call(PhoneNumber phone) =>
      _repository.profileOf(phone);
}

/// Signs the user out on this device.
final class LogOut {
  const LogOut(this._repository);

  final AuthRepository _repository;

  FutureResult<void> call() => _repository.logOut();
}
