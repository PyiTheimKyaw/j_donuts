import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/core/widgets/placeholder_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Application router.
///
/// Phase 0 wires every path to a placeholder so the navigation graph and the
/// auth redirect seam exist before the screens do. Real screens replace the
/// builders feature by feature.
@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    redirect: (context, state) => _redirect(ref, state),
    routes: [
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

/// Auth guard. Returns the path to send the user to, or `null` to allow.
///
/// Session awareness arrives in Phase 2; until then nothing redirects.
String? _redirect(Ref ref, GoRouterState state) => null;

List<RouteBase> get _authRoutes => [
  _placeholder(AppRoutes.onboarding, 'Onboarding'),
  _placeholder(AppRoutes.phone, 'Phone number'),
  _placeholder(AppRoutes.otp, 'Verify number'),
  _placeholder(AppRoutes.name, 'Name'),
  _placeholder(AppRoutes.dateOfBirth, 'Date of birth'),
  _placeholder(AppRoutes.welcome, 'Welcome'),
];

List<RouteBase> get _shellRoutes => [
  _placeholder(AppRoutes.home, 'Home', Icons.home_outlined),
  _placeholder(AppRoutes.rewards, 'Rewards', Icons.emoji_events_outlined),
  _placeholder(AppRoutes.orders, 'Orders', Icons.receipt_long_outlined),
  _placeholder(AppRoutes.wallet, 'Wallet', Icons.wallet_outlined),
  _placeholder(AppRoutes.settings, 'Settings', Icons.settings_outlined),
];

GoRoute _placeholder(
  String path,
  String title, [
  IconData icon = Icons.construction_rounded,
]) => GoRoute(
  path: path,
  builder: (context, state) => PlaceholderScreen(title: title, icon: icon),
);
