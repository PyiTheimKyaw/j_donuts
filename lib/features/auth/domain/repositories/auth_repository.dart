import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';

/// Authentication contract the presentation layer depends on.
///
/// The data layer ships a fake implementation that waits about a second and
/// stores users locally. A real API client implements this same interface,
/// so swapping it never touches a screen.
abstract interface class AuthRepository {
  /// Sends (pretends to send) a one-time code to [phone].
  ///
  /// With [AuthIntent.logIn] an unknown number fails with
  /// `NotRegisteredFailure`. Requesting a code also resets the wrong-attempt
  /// counter.
  FutureResult<void> requestOtp(PhoneNumber phone, AuthIntent intent);

  /// Checks [code] for [phone].
  ///
  /// Fails with `InvalidOtpFailure` (carrying attempts left) or
  /// `OtpLockedFailure` once the limit is reached. On success a
  /// [ReturningUser] already carries a started session.
  FutureResult<OtpVerification> verifyOtp(PhoneNumber phone, OtpCode code);

  /// Creates the account and starts a session.
  FutureResult<AuthSession> register(RegistrationDetails details);

  /// Looks up the profile for a signed-in number.
  FutureResult<UserProfile> profileOf(PhoneNumber phone);

  /// Session persisted on this device, or `null` when signed out.
  FutureResult<AuthSession?> currentSession();

  /// Ends the session on this device.
  FutureResult<void> logOut();
}
