import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

enum SocialProvider { google, apple, facebook }

/// Visual only; the brief asks for a placeholder instead of real sign-in.
class SocialSignInRow extends StatelessWidget {
  const SocialSignInRow({super.key});

  static const double _iconSize = 30;
  static const double _spacing = 56;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final provider in SocialProvider.values) ...[
          if (provider != SocialProvider.values.first)
            const SizedBox(width: _spacing),
          _SocialButton(
            provider: provider,
            semanticsLabel: l10n.continueWithProvider(provider.label),
            onTap: () => _showPlaceholder(context, l10n, provider),
          ),
        ],
      ],
    );
  }

  void _showPlaceholder(
    BuildContext context,
    AppLocalizations l10n,
    SocialProvider provider,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(l10n.providerNotAvailable(provider.label))),
      );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.provider,
    required this.semanticsLabel,
    required this.onTap,
  });

  final SocialProvider provider;
  final String semanticsLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: InkResponse(
        onTap: onTap,
        radius: AppSizes.minTapTarget / 2 + AppSpacing.xs,
        child: SizedBox.square(
          dimension: AppSizes.minTapTarget,
          child: Center(child: _glyph),
        ),
      ),
    );
  }

  Widget get _glyph => switch (provider) {
    SocialProvider.google => Text(
      'G',
      style: AppTypography.headline.copyWith(
        color: AppColors.googleBlue,
        fontSize: SocialSignInRow._iconSize,
        height: 1,
      ),
    ),
    SocialProvider.apple => const Icon(
      Icons.apple,
      size: SocialSignInRow._iconSize + 4,
      color: AppColors.ink,
    ),
    SocialProvider.facebook => const Icon(
      Icons.facebook,
      size: SocialSignInRow._iconSize + 4,
      color: AppColors.facebookBlue,
    ),
  };
}

extension on SocialProvider {
  String get label => switch (this) {
    SocialProvider.google => 'Google',
    SocialProvider.apple => 'Apple',
    SocialProvider.facebook => 'Facebook',
  };
}
