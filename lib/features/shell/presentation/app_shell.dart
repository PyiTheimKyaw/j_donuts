import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/features/home/presentation/catalog_sync_controller.dart';
import 'package:j_donuts/features/shell/presentation/app_bottom_nav.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Holds the catalogue sync listener for as long as a member is signed in, so
/// reconnecting refreshes data no matter which tab is open.
class AppShell extends ConsumerWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(catalogSyncControllerProvider, (_, _) {});
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(
        selectedIndex: navigationShell.currentIndex,
        onSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          AppNavDestination(icon: Icons.home_outlined, label: l10n.tabHome),
          AppNavDestination(
            icon: Icons.workspace_premium_outlined,
            label: l10n.tabReward,
          ),
          AppNavDestination(icon: Icons.donut_large, label: l10n.tabOrders),
          AppNavDestination(
            icon: Icons.account_balance_wallet_outlined,
            label: l10n.tabWallet,
          ),
          AppNavDestination(
            icon: Icons.settings_outlined,
            label: l10n.tabSettings,
          ),
        ],
      ),
    );
  }
}
