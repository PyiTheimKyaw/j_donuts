import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Deliberately static so it does not compete with the onboarding entrance.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.authBackground),
      child: Center(
        child: Text(
          l10n.appTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
