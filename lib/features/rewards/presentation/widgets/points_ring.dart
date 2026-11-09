import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/formatting/number_format.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/donut_ring_painters.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// One controller drives both the sweep and the count-up, so the number lands
/// on its total in the same frame the arc lands on its progress. The shaded
/// donut is painted once and revealed by a growing clip; only the two rounded
/// tube ends repaint each frame, which keeps the sweep cheap on mid-range
/// Android.
class PointsRing extends StatefulWidget {
  const PointsRing({
    required this.progress,
    required this.totalPoints,
    required this.diameter,
    super.key,
  });

  final double progress;
  final int totalPoints;
  final double diameter;

  @override
  State<PointsRing> createState() => _PointsRingState();
}

class _PointsRingState extends State<PointsRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = AppMotion.scaled(context, AppDurations.countUp);
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final sweep = CurvedAnimation(parent: _controller, curve: AppCurves.sweep);
    final count = CurvedAnimation(parent: _controller, curve: AppCurves.count);

    return Semantics(
      label:
          '${l10n.totalPoints} '
          '${formatGrouped(widget.totalPoints, locale: locale)}',
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: widget.diameter,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final revealed = widget.progress * sweep.value;
            return Stack(
              fit: StackFit.expand,
              children: [
                const CustomPaint(painter: RingTrackPainter()),
                ClipPath(
                  clipper: SweepRevealClipper(progress: revealed),
                  // Cached as its own layer: only the clip changes per frame.
                  child: const RepaintBoundary(
                    child: CustomPaint(painter: IcingRingPainter()),
                  ),
                ),
                CustomPaint(painter: IcingCapsPainter(progress: revealed)),
                Center(
                  child: _CenterLabel(
                    title: l10n.totalPoints,
                    value: formatGrouped(
                      (widget.totalPoints * count.value).round(),
                      locale: locale,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CenterLabel extends StatelessWidget {
  const _CenterLabel({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTypography.label.copyWith(color: AppColors.accent),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            key: const Key('points-ring-total'),
            style: AppTypography.headline.copyWith(
              color: AppColors.accent,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}
