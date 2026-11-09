import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Rounded only on the left: it runs off the right edge of the screen, as in
/// the design. Pops in with an overshoot so it reads as fresh news.
class RewardsBadge extends StatelessWidget {
  const RewardsBadge({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return EntranceAnimation(
      index: 2,
      gap: AppDurations.sectionStaggerGap,
      curve: AppCurves.pop,
      beginScale: AppMotionScales.popFrom,
      offset: Offset.zero,
      child: Semantics(
        label: l10n.rewardsAvailable(count),
        excludeSemantics: true,
        child: Container(
          key: const Key('rewards-badge'),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.gutter,
            AppSpacing.sm,
          ),
          decoration: const BoxDecoration(
            color: AppColors.warning,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(AppRadii.pill),
            ),
          ),
          child: _BadgeContent(count: count, label: l10n.rewards),
        ),
      ),
    );
  }
}

class _BadgeContent extends StatelessWidget {
  const _BadgeContent({required this.count, required this.label});

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTypography.subtitle.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _CountDot(count: count),
      ],
    );
  }
}

class _CountDot extends StatelessWidget {
  const _CountDot({required this.count});

  final int count;

  static const double _size = 24;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$count',
        style: AppTypography.label.copyWith(
          color: AppColors.warning,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
