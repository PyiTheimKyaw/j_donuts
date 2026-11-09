import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/app_button.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/features/auth/presentation/session/welcome_pending.dart';
import 'package:j_donuts/features/auth/presentation/widgets/donut_illustration.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  static const int tileCount = 4;

  void _explore(BuildContext context, WidgetRef ref) {
    ref.read(welcomePendingProvider.notifier).clear();
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.authBackground),
        child: Column(
          children: [
            const Expanded(child: _DonutTiles()),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.gutter,
                  AppSpacing.xl,
                  AppSpacing.gutter,
                  AppSpacing.xl,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EntranceAnimation(
                      index: tileCount,
                      gap: AppDurations.sectionStaggerGap,
                      child: Text(
                        l10n.welcomeTitle,
                        style: AppTypography.headline,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    EntranceAnimation(
                      index: tileCount + 1,
                      gap: AppDurations.sectionStaggerGap,
                      child: AppButton(
                        key: const Key('welcome-explore'),
                        label: l10n.letsExplore,
                        onPressed: () => _explore(context, ref),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Two staggered columns that bleed off the screen edges, as in the design.
class _DonutTiles extends StatelessWidget {
  const _DonutTiles();

  static const double _rightColumnDrop = 48;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                _tile(0, AppColors.pastelBlue, AppColors.icingPurple, -1, 6),
                const SizedBox(height: AppSpacing.lg),
                _tile(2, AppColors.pastelPeach, AppColors.icingPink, -1, 5),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: _rightColumnDrop),
              child: Column(
                children: [
                  _tile(
                    1,
                    AppColors.pastelPink,
                    AppColors.icingChocolate,
                    1,
                    5,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _tile(
                    3,
                    AppColors.pastelYellow,
                    AppColors.icingChocolate,
                    1,
                    5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(int index, Color tint, Color icing, double fromSide, int flex) {
    return Expanded(
      flex: flex,
      child: EntranceAnimation(
        index: index,
        gap: AppDurations.sectionStaggerGap,
        duration: AppDurations.emphasis,
        curve: AppCurves.emphasized,
        offset: Offset(fromSide * AppMotionOffsets.driftIn, 0),
        child: _DonutTile(tint: tint, icing: icing, tilt: fromSide * 0.4),
      ),
    );
  }
}

class _DonutTile extends StatelessWidget {
  const _DonutTile({
    required this.tint,
    required this.icing,
    required this.tilt,
  });

  final Color tint;
  final Color icing;
  final double tilt;

  static const double _donutFraction = 0.7;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: DonutIllustration(
            size: constraints.biggest.shortestSide * _donutFraction,
            icing: icing,
            rotation: tilt,
          ),
        ),
      ),
    );
  }
}
