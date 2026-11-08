import 'package:equatable/equatable.dart';
import 'package:j_donuts/features/auth/domain/entities/phone_number.dart';

/// Proof that a user is signed in on this device.
final class AuthSession extends Equatable {
  const AuthSession({required this.phone, required this.startedAt});

  final PhoneNumber phone;
  final DateTime startedAt;

  @override
  List<Object?> get props => [phone, startedAt];
}

/// Why the user is entering a phone number.
enum AuthIntent {
  /// "Let's get started": a new account is expected, but an existing one is
  /// welcome and simply logs in after OTP.
  register,

  /// "Already have an account? Log in": the number must exist.
  logIn,
}

/// Outcome of a correct one-time code.
sealed class OtpVerification {
  const OtpVerification();
}

/// The number already has an account; a session has been started.
final class ReturningUser extends OtpVerification {
  const ReturningUser(this.session);

  final AuthSession session;
}

/// The number is new; registration continues with name and date of birth.
final class NewUser extends OtpVerification {
  const NewUser(this.phone);

  final PhoneNumber phone;
}
