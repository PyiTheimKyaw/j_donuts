import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/core/widgets/app_image.dart';
import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';

/// Progress drawn into the artwork itself, as the brief asks: the donut is
/// coloured in a quarter at a time, the coffee gets an arc that fills.
class ChallengeArt extends StatelessWidget {
  const ChallengeArt({required this.challenge, required this.size, super.key});

  final Challenge challenge;
  final double size;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: AppMotion.reduceMotion(context) ? challenge.fraction : 0,
        end: challenge.fraction,
      ),
      duration: AppMotion.scaled(context, AppDurations.ringSweep),
      curve: AppCurves.sweep,
      builder: (context, progress, _) => SizedBox.square(
        dimension: size,
        child: switch (challenge.artwork) {
          ChallengeArtwork.donut => _DonutQuarters(
            challenge: challenge,
            progress: progress,
          ),
          ChallengeArtwork.coffee => _CoffeeArc(
            challenge: challenge,
            progress: progress,
          ),
        },
      ),
    );
  }
}

/// The full-colour photo is revealed through a pie clip over a desaturated
/// copy. Progress snaps to whole quarters so 1/4 reads as exactly one quarter.
class _DonutQuarters extends StatelessWidget {
  const _DonutQuarters({required this.challenge, required this.progress});

  final Challenge challenge;
  final double progress;

  static const int _quarters = 4;
  static const ColorFilter _washedOut = ColorFilter.matrix([
    0.33, 0.33, 0.33, 0, 60, //
    0.33, 0.33, 0.33, 0, 60, //
    0.33, 0.33, 0.33, 0, 60, //
    0, 0, 0, 1, 0, //
  ]);

  @override
  Widget build(BuildContext context) {
    final quarters = (progress * _quarters).floorToDouble() / _quarters;
    final image = AppImage(challenge.image);

    return ClipOval(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(colorFilter: _washedOut, child: image),
          ClipPath(
            clipper: ProgressPieClipper(fraction: quarters),
            child: image,
          ),
          CustomPaint(painter: _QuarterLinesPainter(filledQuarters: quarters)),
        ],
      ),
    );
  }
}

class ProgressPieClipper extends CustomClipper<Path> {
  const ProgressPieClipper({required this.fraction});

  final double fraction;

  static const double _startAngle = -math.pi / 2;

  @override
  Path getClip(Size size) {
    // A 360° arc collapses to an empty path, which would hide a complete
    // donut entirely; a full reveal is simply the whole tile.
    if (fraction >= 1) return Path()..addRect(Offset.zero & size);
    final center = size.center(Offset.zero);
    final radius = size.longestSide;
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        _startAngle,
        2 * math.pi * fraction,
        false,
      )
      ..close();
  }

  @override
  bool shouldReclip(ProgressPieClipper oldClipper) =>
      oldClipper.fraction != fraction;
}

/// Faint dividers on the unfilled quarters hint at how many are left.
class _QuarterLinesPainter extends CustomPainter {
  const _QuarterLinesPainter({required this.filledQuarters});

  final double filledQuarters;

  @override
  void paint(Canvas canvas, Size size) {
    if (filledQuarters >= 1) return;
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..color = AppColors.surface.withValues(alpha: 0.7)
      ..strokeWidth = 2;
    for (var i = 0; i < 4; i++) {
      final angle = -math.pi / 2 + i * math.pi / 2;
      canvas.drawLine(
        center,
        center + Offset.fromDirection(angle, size.shortestSide / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_QuarterLinesPainter oldDelegate) =>
      oldDelegate.filledQuarters != filledQuarters;
}

class _CoffeeArc extends StatelessWidget {
  const _CoffeeArc({required this.challenge, required this.progress});

  final Challenge challenge;
  final double progress;

  static const double _cupFraction = 0.62;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CoffeeArcPainter(progress: progress),
      child: Align(
        alignment: const Alignment(0, 0.6),
        child: FractionallySizedBox(
          widthFactor: _cupFraction * 0.75,
          heightFactor: _cupFraction,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.md),
            child: AppImage(challenge.image),
          ),
        ),
      ),
    );
  }
}

/// An open arc over the cup, from the lower left over the top to the lower
/// right, like the design's handle-shaped gauge.
class CoffeeArcPainter extends CustomPainter {
  const CoffeeArcPainter({required this.progress});

  final double progress;

  static const double _startAngle = math.pi * 0.85;
  static const double _sweepAngle = math.pi * 1.3;
  static const double _strokeFraction = 0.09;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.shortestSide * _strokeFraction;
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.shortestSide / 2 - stroke / 2,
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawArc(
        rect,
        _startAngle,
        _sweepAngle,
        false,
        paint..color = AppColors.ringTrack,
      )
      ..drawArc(
        rect,
        _startAngle,
        _sweepAngle * progress.clamp(0, 1),
        false,
        paint..color = AppColors.warning,
      );
  }

  @override
  bool shouldRepaint(CoffeeArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
