import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:j_donuts/app/locale/app_locale.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Each language is labelled in its own script, so a reader can find theirs
/// whichever language the app is currently showing.
class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key});

  static const Locale english = Locale('en');
  static const Locale burmese = Locale('my');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = Localizations.localeOf(context).languageCode;
    void select(Locale locale) =>
        ref.read(appLocaleProvider.notifier).select(locale);

    return Semantics(
      label: l10n.languageLabel,
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final (locale, label) in [
                (english, l10n.languageEnglish),
                (burmese, l10n.languageBurmese),
              ])
                _LanguageOption(
                  key: Key('language-${locale.languageCode}'),
                  label: label,
                  isSelected: locale.languageCode == current,
                  onTap: () => select(locale),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.scaled(context, AppDurations.fast);

    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isSelected ? null : onTap,
        child: AnimatedContainer(
          duration: duration,
          curve: AppCurves.standard,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.pill),
          ),
          child: AnimatedDefaultTextStyle(
            duration: duration,
            style: AppTypography.label.copyWith(
              color: isSelected ? AppColors.onPrimary : AppColors.inkSecondary,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
