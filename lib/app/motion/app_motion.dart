import 'package:flutter/widgets.dart';

/// Every animation duration in the app, named by intent.
abstract final class AppDurations {
  static const Duration instant = Duration(milliseconds: 90);
  static const Duration fast = Duration(milliseconds: 160);
  static const Duration medium = Duration(milliseconds: 260);
  static const Duration slow = Duration(milliseconds: 420);
  static const Duration entrance = Duration(milliseconds: 600);
  static const Duration emphasis = Duration(milliseconds: 900);
  static const Duration ringSweep = Duration(milliseconds: 1200);
  static const Duration countUp = Duration(milliseconds: 1400);

  /// Gap between items that enter one after another.
  static const Duration staggerGap = Duration(milliseconds: 70);

  /// Gap between larger blocks, e.g. Home sections.
  static const Duration sectionStaggerGap = Duration(milliseconds: 110);

  static const Duration shake = Duration(milliseconds: 420);
  static const Duration bannerAutoPlay = Duration(seconds: 4);
  static const Duration skeletonShimmer = Duration(milliseconds: 1300);
  static const Duration attentionPulse = Duration(milliseconds: 1100);
}

/// Every easing curve in the app, named by intent.
abstract final class AppCurves {
  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const Curve decelerate = Curves.decelerate;
  static const Curve overshoot = Curves.easeOutBack;
  static const Curve pop = Curves.elasticOut;
  static const Curve sweep = Curves.easeInOutCubic;
  static const Curve count = Curves.easeOutQuart;
}

/// Distances used by slide / drift entrances, in logical pixels.
abstract final class AppMotionOffsets {
  static const double slideIn = 32;
  static const double driftIn = 48;
  static const double shakeAmplitude = 10;
}

/// Scale factors used by press and pop effects.
abstract final class AppMotionScales {
  static const double pressed = 0.96;
  static const double popFrom = 0.4;
}

/// Reads the platform "Reduce Motion" preference.
///
/// Animations call [scaled] so that a user who disabled animations gets the
/// final frame immediately instead of a tween.
abstract final class AppMotion {
  static bool reduceMotion(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context);

  static Duration scaled(BuildContext context, Duration duration) =>
      reduceMotion(context) ? Duration.zero : duration;

  /// Delay for the [index]-th item in a staggered entrance.
  static Duration staggerDelay(
    BuildContext context,
    int index, {
    Duration gap = AppDurations.staggerGap,
  }) => reduceMotion(context) ? Duration.zero : gap * index;
}
