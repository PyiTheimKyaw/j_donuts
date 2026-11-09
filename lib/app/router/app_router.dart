import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/app/router/auth_redirect.dart';
import 'package:j_donuts/core/widgets/placeholder_screen.dart';
import 'package:j_donuts/core/widgets/shared_axis_page.dart';
import 'package:j_donuts/core/widgets/splash_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/date_of_birth_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/name_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/otp_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/phone_screen.dart';
import 'package:j_donuts/features/auth/presentation/session/session_controller.dart';
import 'package:j_donuts/features/auth/presentation/session/welcome_pending.dart';
import 'package:j_donuts/features/home/presentation/screens/home_screen.dart';
import 'package:j_donuts/features/home/presentation/screens/welcome_screen.dart';
import 'package:j_donuts/features/shell/presentation/app_shell.dart';
import 'package:j_donuts/features/shell/presentation/settings_screen.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final refresh = _SessionRefresh();
  ref
    ..listen(sessionControllerProvider, (_, _) => refresh.notify())
    ..onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) => resolveAuthRedirect(
      session: ref.read(sessionControllerProvider),
      location: state.matchedLocation,
      welcomePending: ref.read(welcomePendingProvider),
    ),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      ..._authRoutes,
      ..._shellRoutes,
      GoRoute(
        path: AppRoutes.product,
        builder: (context, state) =>
            PlaceholderScreen(title: 'Product ${state.pathParameters['id']}'),
      ),
    ],
    errorBuilder: (context, state) => PlaceholderScreen(
      title: state.error?.message ?? 'Not found',
      icon: Icons.error_outline_rounded,
    ),
  );
}

/// go_router only accepts a Listenable for refresh.
final class _SessionRefresh extends ChangeNotifier {
  void notify() => notifyListeners();
}

List<RouteBase> get _authRoutes => [
  GoRoute(
    path: AppRoutes.onboarding,
    builder: (context, state) => const OnboardingScreen(),
  ),
  _step(AppRoutes.phone, (context, state) => const PhoneScreen()),
  _step(AppRoutes.otp, (context, state) => const OtpScreen()),
  _step(AppRoutes.name, (context, state) => const NameScreen()),
  _step(AppRoutes.dateOfBirth, (context, state) => const DateOfBirthScreen()),
  GoRoute(
    path: AppRoutes.welcome,
    builder: (context, state) => const WelcomeScreen(),
  ),
];

List<RouteBase> get _shellRoutes => [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        AppShell(navigationShell: navigationShell),
    branches: [
      _branch(AppRoutes.home, (context, state) => const HomeScreen()),
      _branch(
        AppRoutes.rewards,
        (context, state) => const PlaceholderScreen(
          title: 'Rewards',
          icon: Icons.workspace_premium_outlined,
        ),
      ),
      _branch(
        AppRoutes.orders,
        (context, state) => PlaceholderScreen(
          title: AppLocalizations.of(context).tabOrders,
          icon: Icons.donut_large,
        ),
      ),
      _branch(
        AppRoutes.wallet,
        (context, state) => PlaceholderScreen(
          title: AppLocalizations.of(context).tabWallet,
          icon: Icons.account_balance_wallet_outlined,
        ),
      ),
      _branch(AppRoutes.settings, (context, state) => const SettingsScreen()),
    ],
  ),
];

StatefulShellBranch _branch(String path, GoRouterWidgetBuilder builder) =>
    StatefulShellBranch(
      routes: [GoRoute(path: path, builder: builder)],
    );

GoRoute _step(String path, GoRouterWidgetBuilder builder) => GoRoute(
  path: path,
  pageBuilder: (context, state) => SharedAxisPage<void>(
    context: context,
    key: state.pageKey,
    name: path,
    child: builder(context, state),
  ),
);
