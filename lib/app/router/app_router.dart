import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/app/router/auth_redirect.dart';
import 'package:j_donuts/core/widgets/placeholder_screen.dart';
import 'package:j_donuts/core/widgets/shared_axis_page.dart';
import 'package:j_donuts/core/widgets/splash_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/otp_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/phone_screen.dart';
import 'package:j_donuts/features/auth/presentation/session/session_controller.dart';
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
  _step(
    AppRoutes.name,
    (context, state) => const PlaceholderScreen(title: 'Name'),
  ),
  _step(
    AppRoutes.dateOfBirth,
    (context, state) => const PlaceholderScreen(title: 'Date of birth'),
  ),
  _placeholder(AppRoutes.welcome, 'Welcome'),
];

List<RouteBase> get _shellRoutes => [
  _placeholder(AppRoutes.home, 'Home', Icons.home_outlined),
  _placeholder(AppRoutes.rewards, 'Rewards', Icons.emoji_events_outlined),
  _placeholder(AppRoutes.orders, 'Orders', Icons.receipt_long_outlined),
  _placeholder(AppRoutes.wallet, 'Wallet', Icons.wallet_outlined),
  _placeholder(AppRoutes.settings, 'Settings', Icons.settings_outlined),
];

GoRoute _step(String path, GoRouterWidgetBuilder builder) => GoRoute(
  path: path,
  pageBuilder: (context, state) => SharedAxisPage<void>(
    context: context,
    key: state.pageKey,
    name: path,
    child: builder(context, state),
  ),
);

GoRoute _placeholder(
  String path,
  String title, [
  IconData icon = Icons.construction_rounded,
]) => GoRoute(
  path: path,
  builder: (context, state) => PlaceholderScreen(title: title, icon: icon),
);
