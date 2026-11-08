import 'dart:async';

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
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_controller.dart';
import 'package:j_donuts/features/auth/presentation/widgets/donut_illustration.dart';
import 'package:j_donuts/features/auth/presentation/widgets/legal_footer.dart';
import 'package:j_donuts/features/auth/presentation/widgets/social_sign_in_row.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  static const int circleCount = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.authBackground),
        child: Column(
          children: [
            const Expanded(child: _DonutCircles()),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.gutter,
                ),
                child: _Actions(
                  onGetStarted: () =>
                      _startFlow(context, ref, AuthIntent.register),
                  onLogIn: () => _startFlow(context, ref, AuthIntent.logIn),
                  l10n: l10n,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startFlow(BuildContext context, WidgetRef ref, AuthIntent intent) {
    ref.read(authFlowControllerProvider.notifier).start(intent);
    final mode = intent == AuthIntent.logIn
        ? AppRoutes.modeLogin
        : AppRoutes.modeRegister;
    unawaited(context.push('${AppRoutes.phone}?${AppRoutes.modeParam}=$mode'));
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.onGetStarted,
    required this.onLogIn,
    required this.l10n,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onLogIn;
  final AppLocalizations l10n;

  static const int _firstIndex = OnboardingScreen.circleCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EntranceAnimation(
          index: _firstIndex,
          child: Text(
            l10n.onboardingTitle,
            style: AppTypography.display,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        EntranceAnimation(
          index: _firstIndex + 1,
          child: AppButton(label: l10n.getStarted, onPressed: onGetStarted),
        ),
        const SizedBox(height: AppSpacing.sm),
        EntranceAnimation(
          index: _firstIndex + 2,
          child: _LogInPrompt(onLogIn: onLogIn, l10n: l10n),
        ),
        const SizedBox(height: AppSpacing.lg),
        const EntranceAnimation(
          index: _firstIndex + 3,
          child: SocialSignInRow(),
        ),
        const SizedBox(height: AppSpacing.xl),
        const EntranceAnimation(index: _firstIndex + 4, child: LegalFooter()),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _LogInPrompt extends StatelessWidget {
  const _LogInPrompt({required this.onLogIn, required this.l10n});

  final VoidCallback onLogIn;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(l10n.alreadyHaveAccount, style: AppTypography.body),
        TextButton(
          onPressed: onLogIn,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accent,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            minimumSize: const Size(0, AppSizes.minTapTarget),
          ),
          child: Text(
            l10n.logIn,
            style: AppTypography.body.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _DonutCircles extends StatelessWidget {
  const _DonutCircles();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final hero = (w * 0.62).clamp(0.0, h * 0.7);
        final satellite = w * 0.46;

        return ClipRect(
          child: Stack(
            children: [
              _circle(
                index: 1,
                left: -satellite * 0.45,
                top: -satellite * 0.2,
                size: satellite,
                color: AppColors.pastelCyan,
                icing: AppColors.icingChocolate,
                from: const Offset(-1, -1),
              ),
              _circle(
                index: 2,
                left: w - satellite * 0.55,
                top: -satellite * 0.1,
                size: satellite,
                color: AppColors.pastelBlue,
                icing: AppColors.icingPink,
                from: const Offset(1, -1),
              ),
              _circle(
                index: 3,
                left: -satellite * 0.5,
                top: h * 0.55,
                size: satellite,
                color: AppColors.pastelLavender,
                icing: AppColors.icingPurple,
                from: const Offset(-1, 1),
              ),
              _circle(
                index: 4,
                left: w - satellite * 0.5,
                top: h * 0.58,
                size: satellite,
                color: AppColors.pastelPink,
                icing: AppColors.icingWhite,
                from: const Offset(1, 1),
              ),
              _circle(
                index: 0,
                left: (w - hero) / 2,
                top: (h - hero) / 2,
                size: hero,
                color: AppColors.pastelPeach,
                icing: AppColors.icingPink,
                from: Offset.zero,
                scaleFrom: 0.6,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _circle({
    required int index,
    required double left,
    required double top,
    required double size,
    required Color color,
    required Color icing,
    required Offset from,
    double scaleFrom = 0.8,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: EntranceAnimation(
        index: index,
        duration: AppDurations.emphasis,
        curve: AppCurves.overshoot,
        offset: from * AppMotionOffsets.driftIn,
        beginScale: scaleFrom,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: DonutIllustration(size: size * 0.6, icing: icing, rotation: 0.3),
    );
  }
}
