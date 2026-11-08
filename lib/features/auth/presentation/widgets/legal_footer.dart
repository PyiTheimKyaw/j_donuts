import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class LegalFooter extends StatelessWidget {
  const LegalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final linkStyle = AppTypography.caption.copyWith(color: AppColors.accent);

    return Text.rich(
      TextSpan(
        style: AppTypography.caption,
        children: [
          TextSpan(text: l10n.legalPrefix),
          TextSpan(
            text: l10n.termsOfUse,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => showLegalPlaceholder(context, l10n.termsOfUse),
          ),
          TextSpan(text: l10n.legalAnd),
          TextSpan(
            text: l10n.privacyPolicy,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => showLegalPlaceholder(context, l10n.privacyPolicy),
          ),
          TextSpan(text: l10n.legalSuffix),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  static Future<void> showLegalPlaceholder(BuildContext context, String title) {
    final l10n = AppLocalizations.of(context);
    return showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.title),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.legalPlaceholderBody, style: AppTypography.bodySmall),
            const SizedBox(height: AppSpacing.xl),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(sheetContext).pop(),
                child: Text(l10n.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
