import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/features/auth/presentation/session/session_controller.dart';
import 'package:j_donuts/features/home/presentation/home_view_models.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Signing out only clears the session; the router's redirect does the
/// navigation, so this screen never routes to Onboarding itself.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider).value;
    final name = ref.watch(greetingNameProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabSettings, style: AppTypography.title),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          AppSpacing.sm,
          AppSpacing.gutter,
          AppSpacing.xxxl * 2,
        ),
        children: [
          Text(l10n.settingsAccount, style: AppTypography.caption),
          const SizedBox(height: AppSpacing.sm),
          _Card(
            child: ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: Text(name ?? '', style: AppTypography.subtitle),
              subtitle: Text(session?.phone.e164 ?? ''),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _Card(
            child: ListTile(
              key: const Key('settings-log-out'),
              leading: const Icon(Icons.logout_rounded, color: AppColors.error),
              title: Text(
                l10n.logOut,
                style: AppTypography.subtitle.copyWith(color: AppColors.error),
              ),
              onTap: () => _confirmLogOut(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogOut(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.logOutConfirmTitle),
        content: Text(l10n.logOutConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            key: const Key('settings-log-out-confirm'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.logOut),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(sessionControllerProvider.notifier).logOut();
    }
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadii.lg),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
