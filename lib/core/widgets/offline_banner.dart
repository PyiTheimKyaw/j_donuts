import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Collapses to zero height when online so content below never jumps by the
/// banner's height without animating.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({required this.isOffline, super.key});

  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AnimatedSize(
      duration: AppMotion.scaled(context, AppDurations.medium),
      curve: AppCurves.standard,
      alignment: Alignment.topCenter,
      child: isOffline
          ? Semantics(
              liveRegion: true,
              child: Container(
                key: const Key('offline-banner'),
                width: double.infinity,
                color: AppColors.ink,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.gutter,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.cloud_off_rounded,
                      color: AppColors.onPrimary,
                      size: 18,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        l10n.offlineBanner,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(width: double.infinity),
    );
  }
}
