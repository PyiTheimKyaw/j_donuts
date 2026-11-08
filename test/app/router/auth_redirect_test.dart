import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/app/router/auth_redirect.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';

void main() {
  final session = AuthSession(
    phone: const PhoneNumber('9254135592'),
    startedAt: DateTime(2026, 11, 8),
  );
  const loading = AsyncLoading<AuthSession?>();
  const signedOut = AsyncData<AuthSession?>(null);
  final signedIn = AsyncData<AuthSession?>(session);

  String? redirect(AsyncValue<AuthSession?> state, String location) =>
      resolveAuthRedirect(session: state, location: location);

  group('resolveAuthRedirect while the session is loading', () {
    test('holds every destination on the splash screen', () {
      expect(redirect(loading, AppRoutes.home), AppRoutes.splash);
      expect(redirect(loading, AppRoutes.onboarding), AppRoutes.splash);
      expect(redirect(loading, AppRoutes.productPath('p_1')), AppRoutes.splash);
    });

    test('allows the splash screen itself', () {
      expect(redirect(loading, AppRoutes.splash), isNull);
    });
  });

  group('resolveAuthRedirect when signed out', () {
    test('sends splash and protected routes to onboarding', () {
      expect(redirect(signedOut, AppRoutes.splash), AppRoutes.onboarding);
      expect(redirect(signedOut, AppRoutes.home), AppRoutes.onboarding);
      expect(redirect(signedOut, AppRoutes.rewards), AppRoutes.onboarding);
      expect(redirect(signedOut, AppRoutes.welcome), AppRoutes.onboarding);
      expect(
        redirect(signedOut, AppRoutes.productPath('p_1')),
        AppRoutes.onboarding,
      );
    });

    test('allows every auth step, including with a query string', () {
      expect(redirect(signedOut, AppRoutes.onboarding), isNull);
      expect(redirect(signedOut, '${AppRoutes.phone}?mode=login'), isNull);
      expect(redirect(signedOut, AppRoutes.otp), isNull);
      expect(redirect(signedOut, AppRoutes.name), isNull);
      expect(redirect(signedOut, AppRoutes.dateOfBirth), isNull);
    });
  });

  group('resolveAuthRedirect when signed in', () {
    test('sends splash and auth steps to home', () {
      expect(redirect(signedIn, AppRoutes.splash), AppRoutes.home);
      expect(redirect(signedIn, AppRoutes.onboarding), AppRoutes.home);
      expect(redirect(signedIn, AppRoutes.phone), AppRoutes.home);
      expect(redirect(signedIn, AppRoutes.otp), AppRoutes.home);
    });

    test('allows welcome, the tabs and product detail', () {
      expect(redirect(signedIn, AppRoutes.welcome), isNull);
      expect(redirect(signedIn, AppRoutes.home), isNull);
      expect(redirect(signedIn, AppRoutes.rewards), isNull);
      expect(redirect(signedIn, AppRoutes.settings), isNull);
      expect(redirect(signedIn, AppRoutes.productPath('p_1')), isNull);
    });
  });

  group('resolveAuthRedirect right after registration', () {
    String? redirectPending(String location) => resolveAuthRedirect(
      session: signedIn,
      location: location,
      welcomePending: true,
    );

    test('sends the new user from the last auth step to Welcome', () {
      expect(redirectPending(AppRoutes.dateOfBirth), AppRoutes.welcome);
    });

    test('allows Welcome itself and anything beyond it', () {
      expect(redirectPending(AppRoutes.welcome), isNull);
      expect(redirectPending(AppRoutes.home), isNull);
    });
  });
}
