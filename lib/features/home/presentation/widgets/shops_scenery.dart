import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';

/// Flat landscape behind the nearby-shops cards: clouds top right, trees at the
/// edges, hills behind the cards and grass along the bottom.
///
/// Every coordinate is a fraction of the canvas so the scene holds its shape on
/// any phone width; only [groundHeight] is absolute, because the grass has to
/// reach exactly as far as the content that sits on it.
class ShopsSceneryPainter extends CustomPainter {
  const ShopsSceneryPainter({
    required this.groundHeight,
    required this.sproutLine,
  });

  final double groundHeight;

  /// Distance from the bottom where sprouts stand: in the strip of grass
  /// that stays visible between the cards and the floating nav.
  final double sproutLine;

  static const double _grassWaveCount = 3;
  static const double _grassWaveDepth = 10;

  @override
  void paint(Canvas canvas, Size size) {
    final groundTop = size.height - groundHeight;
    _paintClouds(canvas, size);
    _paintFarHills(canvas, size, groundTop);
    _paintTrees(canvas, size, groundTop);
    _paintGrass(canvas, size, groundTop);
    _paintSprouts(canvas, size, groundTop);
  }

  void _paintClouds(Canvas canvas, Size size) {
    final w = size.width;
    final puffs = <(double, double, double)>[
      (0.74, 0.25, 0.09),
      (0.86, 0.21, 0.13),
      (1.02, 0.19, 0.17),
      (0.94, 0.28, 0.10),
    ];
    final bounds = Rect.fromLTWH(
      w * 0.6,
      size.height * 0.1,
      w * 0.5,
      size.height * 0.25,
    );
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.sceneryCloud, AppColors.sceneryCloudShade],
      ).createShader(bounds);
    for (final (x, y, r) in puffs) {
      canvas.drawCircle(Offset(w * x, size.height * y), w * r, paint);
    }
  }

  void _paintFarHills(Canvas canvas, Size size, double groundTop) {
    final w = size.width;
    final crest = groundTop - size.height * 0.16;
    final path = Path()
      ..moveTo(0, groundTop)
      ..lineTo(0, crest + 30)
      ..quadraticBezierTo(w * 0.28, crest - 40, w * 0.55, crest + 10)
      ..quadraticBezierTo(w * 0.8, crest + 50, w, crest)
      ..lineTo(w, groundTop)
      ..close();
    canvas.drawPath(path, Paint()..color = AppColors.sceneryHillFar);
  }

  void _paintTrees(Canvas canvas, Size size, double groundTop) {
    final w = size.width;
    final trees = <(double, double, Color)>[
      (-0.02, 0.26, AppColors.sceneryTreeDark),
      (0.07, 0.19, AppColors.sceneryTreeLight),
      (0.95, 0.22, AppColors.sceneryTreeDark),
      (1.03, 0.16, AppColors.sceneryTreeLight),
    ];
    for (final (x, height, color) in trees) {
      _paintTree(
        canvas,
        base: Offset(w * x, groundTop + 6),
        height: size.height * height,
        color: color,
      );
    }
  }

  /// A stack of three rounded canopies, widest at the bottom.
  void _paintTree(
    Canvas canvas, {
    required Offset base,
    required double height,
    required Color color,
  }) {
    final paint = Paint()..color = color;
    final trunkWidth = height * 0.07;
    canvas.drawRect(
      Rect.fromLTWH(
        base.dx - trunkWidth / 2,
        base.dy - height * 0.3,
        trunkWidth,
        height * 0.3,
      ),
      paint,
    );
    for (var tier = 0; tier < 3; tier++) {
      final radius = height * (0.24 - tier * 0.05);
      final centerY = base.dy - height * (0.38 + tier * 0.22);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(base.dx, centerY),
          width: radius * 2,
          height: radius * 1.6,
        ),
        paint,
      );
    }
  }

  void _paintGrass(Canvas canvas, Size size, double groundTop) {
    final w = size.width;
    final path = Path()..moveTo(0, size.height);
    for (var x = 0.0; x <= w; x += 4) {
      final phase = x / w * math.pi * 2 * _grassWaveCount;
      path.lineTo(x, groundTop + math.sin(phase) * _grassWaveDepth);
    }
    path
      ..lineTo(w, size.height)
      ..close();
    final bounds = Rect.fromLTWH(0, groundTop, w, groundHeight);
    canvas.drawPath(
      path,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.sceneryGrassLight, AppColors.sceneryGrass],
        ).createShader(bounds),
    );
  }

  void _paintSprouts(Canvas canvas, Size size, double groundTop) {
    const positions = [0.12, 0.31, 0.47, 0.68, 0.86];
    final paint = Paint()..color = AppColors.scenerySprout;
    for (final (index, x) in positions.indexed) {
      final leaf = size.height * (index.isEven ? 0.035 : 0.025);
      final base = Offset(size.width * x, size.height - sproutLine);
      _paintLeaf(canvas, base, leaf, -0.5, paint);
      _paintLeaf(canvas, base, leaf * 1.2, 0.1, paint);
      _paintLeaf(canvas, base, leaf, 0.6, paint);
    }
  }

  void _paintLeaf(
    Canvas canvas,
    Offset base,
    double length,
    double tilt,
    Paint paint,
  ) {
    canvas
      ..save()
      ..translate(base.dx, base.dy)
      ..rotate(tilt);
    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(length * 0.4, -length * 0.5, 0, -length)
      ..quadraticBezierTo(-length * 0.4, -length * 0.5, 0, 0);
    canvas
      ..drawPath(path, paint)
      ..restore();
  }

  @override
  bool shouldRepaint(ShopsSceneryPainter oldDelegate) =>
      oldDelegate.groundHeight != groundHeight ||
      oldDelegate.sproutLine != sproutLine;
}
