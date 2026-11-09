import 'dart:math' as math;

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
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Rungs enter top to bottom; only once they have all landed does the
/// connector below the current tier fill toward the next. Each connector is
/// drawn per rung, so a taller caption (Gold's two lines) cannot throw the
/// fill height off.
class TierLadderView extends StatelessWidget {
  const TierLadderView({required this.member, super.key});

  final Member member;

  static const double badgeSize = 40;
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
    final l10n = AppLocalizations.of(context);
    final isCurrent = step.status == TierStatus.current;
    final fill = connectorFill;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              AnimatedScale(
                scale: isCurrent ? 1.1 : 1,
                duration: AppMotion.scaled(context, AppDurations.medium),
                child: TierShield(tier: step.tier, isCurrent: isCurrent),
              ),
              if (fill != null)
                Expanded(
                  child: _Connector(fill: fill, delay: fillDelay),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: fill == null ? 0 : TierLadderView.rungGap,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.tier.label(l10n),
                    style: AppTypography.subtitle.copyWith(
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                  Text(
                    _caption(context, l10n),
                    style: AppTypography.caption.copyWith(color: AppColors.ink),
                  ),
                ],
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

/// Shield with the tier's initial and one to three stars, as in the design.
class TierShield extends StatelessWidget {
  const TierShield({required this.tier, this.isCurrent = false, super.key});

  final LoyaltyTier tier;
  final bool isCurrent;

  (Color, Color) get _colors => switch (tier) {
    LoyaltyTier.bronze => (AppColors.tierBronze, AppColors.tierBronze),
    LoyaltyTier.silver => (AppColors.tierSilver, AppColors.tierSilverShade),
    LoyaltyTier.gold => (AppColors.tierGold, AppColors.tierGoldShade),
    LoyaltyTier.platinum => (
      AppColors.tierPlatinum,
      AppColors.tierPlatinumShade,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final (fill, shade) = _colors;
    final stars = math.max(1, tier.index);
    const size = TierLadderView.badgeSize;

    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _ShieldPainter(fill: fill, shade: shade, glow: isCurrent),
        child: Padding(
          padding: const EdgeInsets.only(top: size * 0.14),
          child: Column(
            children: [
              Text(
                '★' * stars,
                style: AppTypography.caption.copyWith(
                  color: shade,
                  fontSize: size * 0.18,
                  height: 1,
                ),
              ),
              Text(
                tier.name[0].toUpperCase(),
                style: AppTypography.subtitle.copyWith(
                  color: shade,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShieldPainter extends CustomPainter {
  const _ShieldPainter({
    required this.fill,
    required this.shade,
    required this.glow,
  });

  final Color fill;
  final Color shade;
  final bool glow;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final shield = Path()
      ..moveTo(w * 0.5, 0)
      ..cubicTo(w * 0.72, h * 0.1, w * 0.88, h * 0.1, w, h * 0.12)
      ..lineTo(w, h * 0.5)
      ..cubicTo(w, h * 0.78, w * 0.72, h * 0.92, w * 0.5, h)
      ..cubicTo(w * 0.28, h * 0.92, 0, h * 0.78, 0, h * 0.5)
      ..lineTo(0, h * 0.12)
      ..cubicTo(w * 0.12, h * 0.1, w * 0.28, h * 0.1, w * 0.5, 0)
      ..close();
    if (glow) {
      canvas.drawPath(
        shield.shift(const Offset(0, 2)),
        Paint()
          ..color = shade.withValues(alpha: 0.4)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }
    canvas
      ..drawPath(
        shield,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.lerp(fill, AppColors.surface, 0.45)!, fill],
          ).createShader(Offset.zero & size),
      )
      ..drawPath(
        shield,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = shade.withValues(alpha: 0.6),
      );
  }

  @override
  bool shouldRepaint(_ShieldPainter oldDelegate) =>
      oldDelegate.fill != fill ||
      oldDelegate.shade != shade ||
      oldDelegate.glow != glow;
}
