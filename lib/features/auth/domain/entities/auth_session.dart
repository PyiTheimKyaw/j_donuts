import 'package:equatable/equatable.dart';
import 'package:j_donuts/features/auth/domain/entities/phone_number.dart';

final class AuthSession extends Equatable {
  const AuthSession({required this.phone, required this.startedAt});

  final PhoneNumber phone;
  final DateTime startedAt;

  @override
  List<Object?> get props => [phone, startedAt];
}

enum AuthIntent {
  /// An existing account is not an error here; it simply logs in after OTP.
  register,

  /// The number must already be registered.
  logIn,
}

sealed class OtpVerification extends Equatable {
  const OtpVerification();
}

/// Carries the session the repository has already started.
final class ReturningUser extends OtpVerification {
  const ReturningUser(this.session);

  final AuthSession session;

  @override
  List<Object?> get props => [session];
}

final class NewUser extends OtpVerification {
  const NewUser(this.phone);

  final PhoneNumber phone;

  @override
  List<Object?> get props => [phone];
}
