import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Wrapped in a [Hero] so the arc keeps sweeping across step transitions
/// instead of restarting on each screen; morphs into a check at 100%.
class ProgressRing extends StatelessWidget {
  const ProgressRing({required this.step, required this.totalSteps, super.key});

  final int step;
  final int totalSteps;

  static const String heroTag = 'auth-progress-ring';
  static const double strokeWidth = 7;

  double get progress => step / totalSteps;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Semantics(
      label: l10n.progressStep(step, totalSteps),
      child: Hero(
        tag: heroTag,
        flightShuttleBuilder: _flight,
        child: _AnimatedRing(progress: progress),
      ),
    );
  }

  static Widget _flight(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection direction,
    BuildContext fromContext,
    BuildContext toContext,
  ) {
    final from = _AnimatedRing.of(fromContext).progress;
    final to = _AnimatedRing.of(toContext).progress;
    final curved = CurvedAnimation(parent: animation, curve: AppCurves.sweep);
    return AnimatedBuilder(
      animation: curved,
      builder: (context, _) =>
          _RingArt(progress: from + (to - from) * curved.value),
    );
  }
}

class _AnimatedRing extends StatelessWidget {
  const _AnimatedRing({required this.progress});

  final double progress;

  static _AnimatedRing of(BuildContext heroContext) =>
      (heroContext.widget as Hero).child as _AnimatedRing;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: progress),
      duration: AppMotion.scaled(context, AppDurations.emphasis),
      curve: AppCurves.sweep,
      builder: (context, value, _) => _RingArt(progress: value),
    );
  }
}

class _RingArt extends StatelessWidget {
  const _RingArt({required this.progress});

  final double progress;

  bool get isComplete => progress >= 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppSizes.progressRing,
      child: AnimatedSwitcher(
        duration: AppMotion.scaled(context, AppDurations.medium),
        switchInCurve: AppCurves.overshoot,
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: isComplete
            ? const _CheckBadge(key: ValueKey('check'))
            : CustomPaint(
                key: const ValueKey('ring'),
                // AnimatedSwitcher's Stack loosens constraints; without an
                // explicit size the childless painter collapses to zero.
                size: const Size.square(AppSizes.progressRing),
                painter: _RingPainter(progress: progress),
              ),
      ),
    );
  }
}

class _CheckBadge extends StatelessWidget {
  const _CheckBadge({super.key});

  static const double _iconSize = 22;

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.accent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_rounded,
        color: AppColors.onPrimary,
        size: _iconSize,
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress});

  final double progress;

  static const double _startAngle = -math.pi / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - ProgressRing.strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = ProgressRing.strokeWidth
      ..color = AppColors.pastelBlue;
    canvas.drawCircle(center, radius, track);

    if (progress <= 0) return;
    final sweep = 2 * math.pi * progress.clamp(0.0, 1.0);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = ProgressRing.strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = AppColors.accent;
    canvas.drawArc(rect, _startAngle, sweep, false, arc);
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
