import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/formatting/number_format.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/features/home/presentation/home_labels.dart';
import 'package:j_donuts/features/rewards/domain/tier_ladder.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/tier_shield.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Rungs enter top to bottom; only once they have all landed does the
/// connector below the current tier fill toward the next. Each connector is
/// drawn per rung, so a taller caption (Gold's two lines) cannot throw the
/// fill height off.
class TierLadderView extends StatelessWidget {
  const TierLadderView({required this.member, super.key});

  final Member member;

  static const double badgeSize = TierShield.size;
  static const double rungGap = 36;

  @override
  Widget build(BuildContext context) {
    final steps = TierLadder.stepsFor(member.tier);
    final currentIndex = steps.indexWhere(
      (step) => step.status == TierStatus.current,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, step) in steps.indexed)
          EntranceAnimation(
            index: index,
            gap: AppDurations.sectionStaggerGap,
            offset: const Offset(-AppMotionOffsets.slideIn, 0),
            child: _Rung(
              step: step,
              member: member,
              connectorFill: index == steps.length - 1
                  ? null
                  : _connectorFill(index, currentIndex),
              fillDelay: AppDurations.sectionStaggerGap * steps.length,
            ),
          ),
      ],
    );
  }

  double _connectorFill(int index, int currentIndex) {
    if (index < currentIndex) return 1;
    if (index == currentIndex) return member.tierProgress;
    return 0;
  }
}

class _Rung extends StatelessWidget {
  const _Rung({
    required this.step,
    required this.member,
    required this.connectorFill,
    required this.fillDelay,
  });

  final TierStep step;
  final Member member;

  /// `null` for the last rung, which has nothing below it.
  final double? connectorFill;
  final Duration fillDelay;

  @override
  Widget build(BuildContext context) {
    final isCurrent = step.status == TierStatus.current;
    final fill = connectorFill;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RungMarker(
            step: step,
            isCurrent: isCurrent,
            connectorFill: fill,
            fillDelay: fillDelay,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: fill == null ? 0 : TierLadderView.rungGap,
              ),
              child: _RungText(
                step: step,
                isCurrent: isCurrent,
                caption: _caption(context, AppLocalizations.of(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _caption(BuildContext context, AppLocalizations l10n) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return switch (step.status) {
      TierStatus.achieved => l10n.tierAchieved,
      TierStatus.current => l10n.tierYouAreHere,
      TierStatus.next => l10n.tierRemaining(
        formatGrouped(member.pointsToNextTier, locale: locale),
        step.tier.label(l10n),
      ),
      TierStatus.future => l10n.tierSoon,
    };
  }
}

class _RungMarker extends StatelessWidget {
  const _RungMarker({
    required this.step,
    required this.isCurrent,
    required this.connectorFill,
    required this.fillDelay,
  });

  final TierStep step;
  final bool isCurrent;
  final double? connectorFill;
  final Duration fillDelay;

  static const double _currentScale = 1.1;

  @override
  Widget build(BuildContext context) {
    final fill = connectorFill;

    return Column(
      children: [
        AnimatedScale(
          scale: isCurrent ? _currentScale : 1,
          duration: AppMotion.scaled(context, AppDurations.medium),
          child: TierShield(tier: step.tier, isCurrent: isCurrent),
        ),
        if (fill != null)
          Expanded(
            child: _Connector(fill: fill, delay: fillDelay),
          ),
      ],
    );
  }
}

class _RungText extends StatelessWidget {
  const _RungText({
    required this.step,
    required this.isCurrent,
    required this.caption,
  });

  final TierStep step;
  final bool isCurrent;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          step.tier.label(AppLocalizations.of(context)),
          style: AppTypography.subtitle.copyWith(
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
        Text(
          caption,
          style: AppTypography.caption.copyWith(color: AppColors.ink),
        ),
      ],
    );
  }
}

class _Connector extends StatelessWidget {
  const _Connector({required this.fill, required this.delay});

  final double fill;
  final Duration delay;

  static const double width = 3;
  static const double _delayShare = 0.35;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = AppMotion.reduceMotion(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: reduceMotion ? fill : 0, end: fill),
      duration: AppMotion.scaled(context, AppDurations.emphasis + delay),
      curve: const Interval(_delayShare, 1, curve: AppCurves.standard),
      builder: (context, value, _) => CustomPaint(
        size: const Size(width, double.infinity),
        painter: _ConnectorPainter(filledFraction: value),
      ),
    );
  }
}

class _ConnectorPainter extends CustomPainter {
  const _ConnectorPainter({required this.filledFraction});

  final double filledFraction;

  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width / 2;
    final paint = Paint()..strokeWidth = _Connector.width;
    final filledTo = size.height * filledFraction.clamp(0, 1);
    canvas
      ..drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint..color = AppColors.ladderTrack,
      )
      ..drawLine(
        Offset(x, 0),
        Offset(x, filledTo),
        paint..color = AppColors.inkSecondary,
      );
  }

  @override
  bool shouldRepaint(_ConnectorPainter oldDelegate) =>
      oldDelegate.filledFraction != filledFraction;
}
