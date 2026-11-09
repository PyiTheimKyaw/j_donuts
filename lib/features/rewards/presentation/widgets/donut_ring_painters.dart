import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';

/// Shared measurements so the static donut, the reveal clip and the caps line
/// up to the pixel.
final class RingGeometry {
  RingGeometry(Size size)
    : center = size.center(Offset.zero),
      outer = size.shortestSide / 2 * _insetForShadow {
    band = outer * bandFraction;
    radius = outer - band / 2;
  }

  /// Leaves room inside the canvas for the contact shadow below the ring.
  static const double _insetForShadow = 0.94;
  static const double bandFraction = 0.38;

  /// The arc starts just right of twelve o'clock, as in the design.
  static const double startAngle = -math.pi * 0.42;

  final Offset center;
  final double outer;
  late final double band;
  late final double radius;

  double get inner => outer - band;

  Rect get centerline => Rect.fromCircle(center: center, radius: radius);

  Offset pointAt(double angle, [double offsetAcross = 0]) =>
      center + Offset.fromDirection(angle, radius + offsetAcross);
}

/// The groove the icing sits in: a flat track with a faint inner shade.
class RingTrackPainter extends CustomPainter {
  const RingTrackPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final ring = RingGeometry(size);
    canvas.drawCircle(
      ring.center,
      ring.radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ring.band
        ..shader = _crossSection(ring, const [
          AppColors.ringTrackShade,
          AppColors.ringTrack,
          AppColors.ringTrack,
        ]),
    );
  }

  @override
  bool shouldRepaint(RingTrackPainter oldDelegate) => false;
}

/// The complete donut, painted once and never repainted: the sweep animation
/// reveals it with a clip, so the expensive blurs and gradients cost one
/// frame, not every frame.
class IcingRingPainter extends CustomPainter {
  const IcingRingPainter();

  static const int sprinkleCount = 26;
  static const int _seed = 11;

  @override
  void paint(Canvas canvas, Size size) {
    final ring = RingGeometry(size);
    _paintContactShadow(canvas, ring);
    _paintTube(canvas, ring);
    _paintHighlight(canvas, ring);
    paintSprinkles(canvas, ring);
  }

  void _paintContactShadow(Canvas canvas, RingGeometry ring) {
    canvas.drawCircle(
      ring.center.translate(0, ring.band * 0.1),
      ring.radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ring.band * 0.92
        ..color = AppColors.ringIcingShadow
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, ring.band * 0.12),
    );
  }

  /// Light along the middle of the band, darker toward both edges: the
  /// cross-section of a tube, which is what reads as "inflated".
  void _paintTube(Canvas canvas, RingGeometry ring) {
    canvas.drawCircle(
      ring.center,
      ring.radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ring.band
        ..shader = _crossSection(ring, const [
          AppColors.ringIcingEdge,
          AppColors.ringIcingLight,
          AppColors.ringIcingDeep,
        ]),
    );
  }

  /// A soft glossy streak on the upper-left of the tube, strongest where the
  /// light (from the top left) hits it and fading round the far side.
  void _paintHighlight(Canvas canvas, RingGeometry ring) {
    final rect = Rect.fromCircle(
      center: ring.center,
      radius: ring.radius - ring.band * 0.14,
    );
    canvas.drawArc(
      rect,
      0,
      2 * math.pi,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ring.band * 0.16
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, ring.band * 0.06)
        ..shader = const SweepGradient(
          colors: [
            AppColors.ringHighlightClear,
            AppColors.ringHighlight,
            AppColors.ringHighlightClear,
            AppColors.ringHighlightClear,
          ],
          stops: [0.35, 0.62, 0.9, 1],
        ).createShader(rect),
    );
  }

  /// Capsules with their own light and shadow. Near the tube's edges they
  /// shrink and foreshorten, which sells the curvature of the surface.
  static void paintSprinkles(Canvas canvas, RingGeometry ring) {
    final random = math.Random(_seed);
    for (var i = 0; i < sprinkleCount; i++) {
      final angle =
          (i + random.nextDouble() * 0.7) / sprinkleCount * 2 * math.pi;
      final across = (random.nextDouble() - 0.5) * 1.5;
      final tilt = random.nextDouble() * math.pi;
      final isWhite = random.nextDouble() < 0.55;
      _paintSprinkle(
        canvas,
        ring,
        at: ring.pointAt(angle, across * ring.band / 2 * 0.62),
        across: across,
        tilt: tilt,
        color: isWhite ? AppColors.sprinkleWhite : AppColors.ringSprinkle,
      );
    }
  }

  static void _paintSprinkle(
    Canvas canvas,
    RingGeometry ring, {
    required Offset at,
    required double across,
    required double tilt,
    required Color color,
  }) {
    final curvature = math.sqrt(1 - (across * across * 0.35).clamp(0, 0.9));
    final length = ring.band * 0.26 * curvature;
    final thickness = ring.band * 0.085;
    final body = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: length, height: thickness),
      Radius.circular(thickness / 2),
    );
    canvas
      ..save()
      ..translate(at.dx, at.dy)
      ..rotate(tilt)
      ..drawRRect(
        body.shift(Offset(0, thickness * 0.45)),
        Paint()
          ..color = AppColors.sprinkleShadow
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, thickness * 0.4),
      )
      ..drawRRect(
        body,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: color == AppColors.sprinkleWhite
                ? const [AppColors.surface, AppColors.ringSprinkle]
                : const [AppColors.ringSprinkle, AppColors.ringIcingLight],
          ).createShader(body.outerRect),
      )
      ..restore();
  }

  @override
  bool shouldRepaint(IcingRingPainter oldDelegate) => false;
}

/// Rounded tube ends at the start and at the moving tip. The reveal clip cuts
/// the tube square; these spheres turn the cut into the end of a tube.
class IcingCapsPainter extends CustomPainter {
  const IcingCapsPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final ring = RingGeometry(size);
    final tipAngle =
        RingGeometry.startAngle + 2 * math.pi * progress.clamp(0, 1);
    if (progress < 1) _paintCap(canvas, ring, tipAngle);
    _paintCap(canvas, ring, RingGeometry.startAngle);
  }

  /// Shaded with the tube's own cross-section gradient (centred on the
  /// donut, not on the cap), so the end reads as the tube curving round
  /// rather than a separate ball stuck on.
  void _paintCap(Canvas canvas, RingGeometry ring, double angle) {
    final center = ring.pointAt(angle);
    canvas.drawCircle(
      center,
      ring.band / 2,
      Paint()
        ..shader = _crossSection(ring, const [
          AppColors.ringIcingEdge,
          AppColors.ringIcingLight,
          AppColors.ringIcingDeep,
        ]),
    );
  }

  @override
  bool shouldRepaint(IcingCapsPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// A pie slice from the start angle; grows with the sweep to reveal the
/// cached donut underneath.
class SweepRevealClipper extends CustomClipper<Path> {
  const SweepRevealClipper({required this.progress});

  final double progress;

  @override
  Path getClip(Size size) {
    if (progress >= 1) return Path()..addRect(Offset.zero & size);
    final center = size.center(Offset.zero);
    final reach = size.longestSide;
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: reach),
        RingGeometry.startAngle,
        2 * math.pi * progress.clamp(0, 1),
        false,
      )
      ..close();
  }

  @override
  bool shouldReclip(SweepRevealClipper oldClipper) =>
      oldClipper.progress != progress;
}

/// Maps three colours across the band (inner edge, middle, outer edge) with a
/// radial gradient centred on the donut.
Shader _crossSection(RingGeometry ring, List<Color> innerMiddleOuter) {
  final innerStop = ring.inner / ring.outer;
  final middleStop = ring.radius / ring.outer;
  return RadialGradient(
    colors: innerMiddleOuter,
    stops: [innerStop, middleStop, 1],
  ).createShader(Rect.fromCircle(center: ring.center, radius: ring.outer));
}
