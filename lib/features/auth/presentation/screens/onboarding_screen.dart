import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/locale/language_toggle.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/app_button.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_controller.dart';
import 'package:j_donuts/features/auth/presentation/widgets/legal_footer.dart';
import 'package:j_donuts/features/auth/presentation/widgets/onboarding_donut_circles.dart';
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
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  const Expanded(child: OnboardingDonutCircles()),
                  _ScrollableWhenTooTall(
                    maxHeight: constraints.maxHeight,
                    child: _Actions(
                      onGetStarted: () =>
                          _startFlow(context, ref, AuthIntent.register),
                      onLogIn: () => _startFlow(context, ref, AuthIntent.logIn),
                      l10n: l10n,
                    ),
                  ),
                ],
              ),
            ),
            const _LanguageCorner(),
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

/// Reachable before sign-up, so the whole registration flow can be done in
/// either language.
class _LanguageCorner extends StatelessWidget {
  const _LanguageCorner();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSpacing.sm,
            right: AppSpacing.gutter,
          ),
          child: LanguageToggle(),
        ),
      ),
    );
  }
}

/// The circles give up their space first; only when the actions alone are
/// taller than the screen (a 4.7" phone at 1.3x text) do they scroll.
class _ScrollableWhenTooTall extends StatelessWidget {
  const _ScrollableWhenTooTall({required this.maxHeight, required this.child});

  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
            child: child,
          ),
        ),
      ),
    );
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
