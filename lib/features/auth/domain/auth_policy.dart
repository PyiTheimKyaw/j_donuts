/// Business rules for authentication that are not tied to a single field.
///
/// Field-level limits live next to their validators; these are the
/// flow-level constants shared by the repository and the presentation layer.
abstract final class AuthPolicy {
  /// Number of digits in a one-time code.
  static const int otpLength = 6;

  /// Wrong codes allowed before entry locks until a new code is requested.
  static const int maxOtpAttempts = 3;

  /// How long the user waits before Resend becomes active.
  static const Duration otpResendCooldown = Duration(minutes: 5);

  /// Youngest age allowed to hold an account.
  static const int minimumAgeYears = 13;

  /// Longest first or last name, counted in Unicode code points after trim.
  static const int maxNameLength = 50;
}
