/// Spacing scale in logical pixels. Use these instead of literal paddings.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  /// Horizontal page gutter used by every screen.
  static const double gutter = 24;
}

/// Corner radius scale.
abstract final class AppRadii {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;
}

/// Fixed component sizes that appear across screens.
abstract final class AppSizes {
  static const double buttonHeight = 56;
  static const double fieldHeight = 64;
  static const double iconButton = 44;
  static const double progressRing = 36;
  static const double otpBox = 48;
  static const double bottomNavHeight = 72;
  static const double minTapTarget = 48;
}
