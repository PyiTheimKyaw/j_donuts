import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';

/// Painted rather than bundled so onboarding carries no licensed imagery.
class DonutIllustration extends StatelessWidget {
  const DonutIllustration({
    required this.size,
    this.icing = AppColors.icingPink,
    this.sprinkles = const [
      AppColors.icingChocolate,
      AppColors.icingWhite,
      AppColors.primary,
    ],
    this.rotation = 0,
    super.key,
  });

  final double size;
  final Color icing;
  final List<Color> sprinkles;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: CustomPaint(
        size: Size.square(size),
        painter: _DonutPainter(icing: icing, sprinkles: sprinkles),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter({required this.icing, required this.sprinkles});

  final Color icing;
  final List<Color> sprinkles;

  static const int _sprinkleCount = 22;
  static const int _seed = 7;
  static const double _holeRatio = 0.34;
  static const double _icingRatio = 0.9;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outer = size.shortestSide / 2;
    final hole = outer * _holeRatio;

    _paintDough(canvas, center, outer, hole);
    _paintIcing(canvas, center, outer * _icingRatio, hole * 1.05);
    _paintSprinkles(canvas, center, outer, hole);
  }

  void _paintDough(Canvas canvas, Offset center, double outer, double hole) {
    final shadow = Paint()
      ..color = AppColors.donutShadow.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(
      _ring(center.translate(0, outer * 0.08), outer, hole),
      shadow,
    );

    final dough = Paint()
      ..shader = const RadialGradient(
        colors: [AppColors.donutDough, AppColors.donutShadow],
        stops: [0.75, 1],
      ).createShader(Rect.fromCircle(center: center, radius: outer));
    canvas.drawPath(_ring(center, outer, hole), dough);
  }

  void _paintIcing(Canvas canvas, Offset center, double outer, double hole) {
    final paint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.4),
        colors: [Color.lerp(icing, Colors.white, 0.25)!, icing],
      ).createShader(Rect.fromCircle(center: center, radius: outer));
    canvas.drawPath(_wavyRing(center, outer, hole), paint);
  }

  void _paintSprinkles(
    Canvas canvas,
    Offset center,
    double outer,
    double hole,
  ) {
    final random = math.Random(_seed);
    final paint = Paint()..strokeCap = StrokeCap.round;
    final bandInner = hole * 1.35;
    final bandOuter = outer * 0.82;
    for (var i = 0; i < _sprinkleCount; i++) {
      final angle = random.nextDouble() * 2 * math.pi;
      final radius = bandInner + random.nextDouble() * (bandOuter - bandInner);
      final position = center + Offset.fromDirection(angle, radius);
      final tilt = random.nextDouble() * math.pi;
      paint
        ..color = sprinkles[i % sprinkles.length]
        ..strokeWidth = outer * 0.07;
      canvas.drawLine(
        position - Offset.fromDirection(tilt, outer * 0.08),
        position + Offset.fromDirection(tilt, outer * 0.08),
        paint,
      );
    }
  }

  Path _ring(Offset center, double outer, double hole) => Path()
    ..addOval(Rect.fromCircle(center: center, radius: outer))
    ..addOval(Rect.fromCircle(center: center, radius: hole))
    ..fillType = PathFillType.evenOdd;

  Path _wavyRing(Offset center, double outer, double hole) {
    const waves = 9;
    final path = Path();
    for (var i = 0; i <= 360; i += 3) {
      final angle = i * math.pi / 180;
      final wobble = 1 + 0.045 * math.sin(angle * waves);
      final point = center + Offset.fromDirection(angle, outer * wobble);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path
      ..close()
      ..addOval(Rect.fromCircle(center: center, radius: hole))
      ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldRepaint(_DonutPainter oldDelegate) =>
      oldDelegate.icing != icing || oldDelegate.sprinkles != sprinkles;
}
