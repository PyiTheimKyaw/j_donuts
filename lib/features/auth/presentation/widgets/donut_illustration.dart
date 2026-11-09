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
  static const double _icingHoleRatio = 1.05;
  static const double _shadowAlpha = 0.35;
  static const double _shadowBlur = 10;
  static const double _shadowDropRatio = 0.08;
  static const double _doughShadeStop = 0.75;
  static const Alignment _icingHighlightCenter = Alignment(-0.3, -0.4);
  static const double _icingHighlightMix = 0.25;
  static const double _sprinkleBandInnerRatio = 1.35;
  static const double _sprinkleBandOuterRatio = 0.82;
  static const double _sprinkleWidthRatio = 0.07;
  static const double _sprinkleHalfLengthRatio = 0.08;
  static const int _icingWaves = 9;
  static const double _icingWaveAmplitude = 0.045;
  static const int _icingStepDegrees = 3;
  static const int _fullTurnDegrees = 360;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outer = size.shortestSide / 2;
    final hole = outer * _holeRatio;

    _paintDough(canvas, center, outer, hole);
    _paintIcing(canvas, center, outer * _icingRatio, hole * _icingHoleRatio);
    _paintSprinkles(canvas, center, outer, hole);
  }

  void _paintDough(Canvas canvas, Offset center, double outer, double hole) {
    final shadow = Paint()
      ..color = AppColors.donutShadow.withValues(alpha: _shadowAlpha)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, _shadowBlur);
    canvas.drawPath(
      _ring(center.translate(0, outer * _shadowDropRatio), outer, hole),
      shadow,
    );

    final dough = Paint()
      ..shader = const RadialGradient(
        colors: [AppColors.donutDough, AppColors.donutShadow],
        stops: [_doughShadeStop, 1],
      ).createShader(Rect.fromCircle(center: center, radius: outer));
    canvas.drawPath(_ring(center, outer, hole), dough);
  }

  void _paintIcing(Canvas canvas, Offset center, double outer, double hole) {
    final paint = Paint()
      ..shader = RadialGradient(
        center: _icingHighlightCenter,
        colors: [
          Color.lerp(icing, AppColors.surface, _icingHighlightMix)!,
          icing,
        ],
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
    final bandInner = hole * _sprinkleBandInnerRatio;
    final bandOuter = outer * _sprinkleBandOuterRatio;
    for (var i = 0; i < _sprinkleCount; i++) {
      final angle = random.nextDouble() * 2 * math.pi;
      final radius = bandInner + random.nextDouble() * (bandOuter - bandInner);
      final position = center + Offset.fromDirection(angle, radius);
      final tilt = random.nextDouble() * math.pi;
      paint
        ..color = sprinkles[i % sprinkles.length]
        ..strokeWidth = outer * _sprinkleWidthRatio;
      canvas.drawLine(
        position - Offset.fromDirection(tilt, outer * _sprinkleHalfLengthRatio),
        position + Offset.fromDirection(tilt, outer * _sprinkleHalfLengthRatio),
        paint,
      );
    }
  }

  Path _ring(Offset center, double outer, double hole) => Path()
    ..addOval(Rect.fromCircle(center: center, radius: outer))
    ..addOval(Rect.fromCircle(center: center, radius: hole))
    ..fillType = PathFillType.evenOdd;

  Path _wavyRing(Offset center, double outer, double hole) {
    final path = Path();
    for (var i = 0; i <= _fullTurnDegrees; i += _icingStepDegrees) {
      final angle = i * math.pi / 180;
      final wobble = 1 + _icingWaveAmplitude * math.sin(angle * _icingWaves);
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
