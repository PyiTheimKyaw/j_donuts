import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/features/auth/domain/entities/auth_session.dart';

/// Pure so routing policy is unit-tested without a GoRouter. `null` allows
/// the requested [location]. [welcomePending] routes a just-registered user to
/// Welcome; everyone else signed in lands on Home.
String? resolveAuthRedirect({
  required AsyncValue<AuthSession?> session,
  required String location,
  bool welcomePending = false,
}) {
  final path = Uri.parse(location).path;
  final isSplash = path == AppRoutes.splash;

  if (session.isLoading && !session.hasValue) {
    return isSplash ? null : AppRoutes.splash;
  }

  final signedIn = session.value != null;
  final isPublic = AppRoutes.isPublic(location);

  if (signedIn && (isPublic || isSplash)) {
    return welcomePending ? AppRoutes.welcome : AppRoutes.home;
  }
  if (!signedIn && (!isPublic || isSplash)) return AppRoutes.onboarding;
  return null;
}
