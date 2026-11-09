import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/features/auth/presentation/widgets/donut_illustration.dart';

/// Satellites are placed by an anchor on the available area minus an inset
/// sized by the satellite, so they bleed off the edges at any screen size.
class _SatelliteSpec {
  const _SatelliteSpec({
    required this.index,
    required this.anchor,
    required this.inset,
    required this.color,
    required this.icing,
    required this.from,
  });

  final int index;
  final Offset anchor;
  final Offset inset;
  final Color color;
  final Color icing;
  final Offset from;

  Offset positionIn(Size area, double satellite) => Offset(
    anchor.dx * area.width - inset.dx * satellite,
    anchor.dy * area.height - inset.dy * satellite,
  );
}

class OnboardingDonutCircles extends StatelessWidget {
  const OnboardingDonutCircles({super.key});

  static const List<_SatelliteSpec> _satellites = [
    _SatelliteSpec(
      index: 1,
      anchor: Offset.zero,
      inset: Offset(0.45, 0.2),
      color: AppColors.pastelCyan,
      icing: AppColors.icingChocolate,
      from: Offset(-1, -1),
    ),
    _SatelliteSpec(
      index: 2,
      anchor: Offset(1, 0),
      inset: Offset(0.55, 0.1),
      color: AppColors.pastelBlue,
      icing: AppColors.icingPink,
      from: Offset(1, -1),
    ),
    _SatelliteSpec(
      index: 3,
      anchor: Offset(0, 0.55),
      inset: Offset(0.5, 0),
      color: AppColors.pastelLavender,
      icing: AppColors.icingPurple,
      from: Offset(-1, 1),
    ),
    _SatelliteSpec(
      index: 4,
      anchor: Offset(1, 0.58),
      inset: Offset(0.5, 0),
      color: AppColors.pastelPink,
      icing: AppColors.icingWhite,
      from: Offset(1, 1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          _CircleStack(area: constraints.biggest),
    );
  }
}

class _CircleStack extends StatelessWidget {
  const _CircleStack({required this.area});

  final Size area;

  static const double _satelliteWidthFraction = 0.46;

  @override
  Widget build(BuildContext context) {
    final satellite = area.width * _satelliteWidthFraction;

    return ClipRect(
      child: Stack(
        children: [
          for (final spec in OnboardingDonutCircles._satellites)
            _EnteringCircle(
              index: spec.index,
              position: spec.positionIn(area, satellite),
              size: satellite,
              color: spec.color,
              icing: spec.icing,
              from: spec.from,
            ),
          _HeroCircle(area: area),
        ],
      ),
    );
  }
}

/// Clamped by height as well so the hero never overflows a short viewport.
class _HeroCircle extends StatelessWidget {
  const _HeroCircle({required this.area});

  final Size area;

  static const double _widthFraction = 0.62;
  static const double _maxHeightFraction = 0.7;
  static const double _beginScale = 0.6;

  @override
  Widget build(BuildContext context) {
    final hero = (area.width * _widthFraction).clamp(
      0.0,
      area.height * _maxHeightFraction,
    );

    return _EnteringCircle(
      index: 0,
      position: Offset((area.width - hero) / 2, (area.height - hero) / 2),
      size: hero,
      color: AppColors.pastelPeach,
      icing: AppColors.icingPink,
      from: Offset.zero,
      beginScale: _beginScale,
    );
  }
}

class _EnteringCircle extends StatelessWidget {
  const _EnteringCircle({
    required this.index,
    required this.position,
    required this.size,
    required this.color,
    required this.icing,
    required this.from,
    this.beginScale = _satelliteBeginScale,
  });

  final int index;
  final Offset position;
  final double size;
  final Color color;
  final Color icing;
  final Offset from;
  final double beginScale;

  static const double _satelliteBeginScale = 0.8;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: EntranceAnimation(
        index: index,
        duration: AppDurations.emphasis,
        curve: AppCurves.overshoot,
        offset: from * AppMotionOffsets.driftIn,
        beginScale: beginScale,
        child: _PastelCircle(size: size, color: color, icing: icing),
      ),
    );
  }
}

class _PastelCircle extends StatelessWidget {
  const _PastelCircle({
    required this.size,
    required this.color,
    required this.icing,
  });

  final double size;
  final Color color;
  final Color icing;

  static const double _donutSizeFraction = 0.6;
  static const double _donutRotation = 0.3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: DonutIllustration(
        size: size * _donutSizeFraction,
        icing: icing,
        rotation: _donutRotation,
      ),
    );
  }
}
