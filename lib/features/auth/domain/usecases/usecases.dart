import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/domain/repositories/auth_repository.dart';

// Deliberately thin: one named user action each, a single seam for tests.
final class RequestOtp {
  const RequestOtp(this._repository);

  final AuthRepository _repository;

  FutureResult<void> call(PhoneNumber phone, AuthIntent intent) =>
      _repository.requestOtp(phone, intent);
}

final class VerifyOtp {
  const VerifyOtp(this._repository);

  final AuthRepository _repository;

  FutureResult<OtpVerification> call(PhoneNumber phone, OtpCode code) =>
      _repository.verifyOtp(phone, code);
}

final class RegisterUser {
  const RegisterUser(this._repository);

  final AuthRepository _repository;

  FutureResult<AuthSession> call(RegistrationDetails details) =>
      _repository.register(details);
}

final class RestoreSession {
  const RestoreSession(this._repository);

  final AuthRepository _repository;

  FutureResult<AuthSession?> call() => _repository.currentSession();
}

final class GetProfile {
  const GetProfile(this._repository);

  final AuthRepository _repository;

  FutureResult<UserProfile> call(PhoneNumber phone) =>
      _repository.profileOf(phone);
}

final class LogOut {
  const LogOut(this._repository);

  final AuthRepository _repository;

  FutureResult<void> call() => _repository.logOut();
}
