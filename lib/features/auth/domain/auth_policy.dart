/// Flow-level rules shared by repository and presentation. Field-specific
/// patterns stay beside their validators.
abstract final class AuthPolicy {
  static const int otpLength = 6;

  static const int maxOtpAttempts = 3;

  static const Duration otpResendCooldown = Duration(minutes: 5);

  static const int minimumAgeYears = 13;

  /// Unicode code points after trimming, not UTF-16 units.
  static const int maxNameLength = 50;
}
