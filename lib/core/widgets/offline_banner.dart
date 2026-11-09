import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Collapses to zero height when online so content below never jumps by the
/// banner's height without animating. Sits inside the header's safe area so
/// it never covers the status bar.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({required this.isOffline, super.key});

  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AppMotion.scaled(context, AppDurations.medium),
      curve: AppCurves.standard,
      alignment: Alignment.topCenter,
      child: isOffline
          ? Semantics(liveRegion: true, child: const _OfflinePill())
          : const SizedBox(width: double.infinity),
    );
  }
}

class _OfflinePill extends StatelessWidget {
  const _OfflinePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('offline-banner'),
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        0,
        AppSpacing.gutter,
        AppSpacing.md,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: const _OfflineMessage(),
    );
  }
}

class _OfflineMessage extends StatelessWidget {
  const _OfflineMessage();

  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.cloud_off_rounded,
          color: AppColors.onPrimary,
          size: _iconSize,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            AppLocalizations.of(context).offlineBanner,
            style: AppTypography.caption.copyWith(color: AppColors.onPrimary),
          ),
        ),
      ],
    );
  }
}
