import 'package:flutter/material.dart';

/// Colour tokens lifted from the J'Donuts design screens.
///
/// Widgets never reference raw hex values; they read these tokens either
/// directly or through [ThemeData] / [ColorScheme].
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF4FC8EC); // cyan buttons, nav bar
  static const Color primaryDark = Color(0xFF2BB3DC);
  static const Color accent = Color(0xFFF04E98); // magenta links, pill, ring
  static const Color accentSoft = Color(0xFFFFB1D1);
  static const Color warning = Color(0xFFFF8A1F); // orange badges, coffee arc
  static const Color purple = Color(0xFF6B4FBB); // banner background

  // Backgrounds
  static const Color authGradientTop = Color(0xFFFFDCE7);
  static const Color authGradientBottom = Color(0xFFFFF6F9);
  static const Color homeHeaderTop = Color(0xFFFFEBD6);
  static const Color homeHeaderBottom = Color(0xFFFFF4E8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF3F4F6);
  static const Color scaffold = Color(0xFFF7F7F9);

  // Ink
  static const Color ink = Color(0xFF1F1F2E);
  static const Color inkSecondary = Color(0xFF6B7280);
  static const Color inkTertiary = Color(0xFF9CA3AF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE5E7EB);

  // Feedback
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color skeletonBase = Color(0xFFECEDF0);
  static const Color skeletonHighlight = Color(0xFFF8F8FA);

  // Loyalty tiers
  static const Color tierBronze = Color(0xFFC98A5A);
  static const Color tierSilver = Color(0xFFB8BCC4);
  static const Color tierGold = Color(0xFFE7C45A);
  static const Color tierPlatinum = Color(0xFF9ED8F0);

  // Disabled
  static const Color disabledFill = Color(0xFFE2E4E8);
  static const Color disabledInk = Color(0xFFB4B8C0);

  static const LinearGradient authBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [authGradientTop, authGradientBottom],
  );

  static const LinearGradient homeHeader = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [homeHeaderTop, homeHeaderBottom],
  );
}
