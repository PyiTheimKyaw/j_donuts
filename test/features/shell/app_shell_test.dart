import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_donuts/features/auth/presentation/session/session_controller.dart';
import 'package:j_donuts/features/home/presentation/screens/home_screen.dart';
import 'package:j_donuts/features/shell/presentation/app_bottom_nav.dart';
import 'package:j_donuts/features/shell/presentation/settings_screen.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/signed_in_app.dart';

void main() {
  Future<void> openTab(WidgetTester tester, String label) async {
    await tester.tap(find.bySemanticsLabel(label).last);
    await tester.pumpAndSettle();
  }

  int selectedIndex(WidgetTester tester) =>
      tester.widget<AppBottomNav>(find.byType(AppBottomNav)).selectedIndex;

  group('AppShell', () {
    testWidgets('starts on Home with the Home pill selected', (tester) async {
      await tester.pumpSignedInApp();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(selectedIndex(tester), 0);
    });

    testWidgets('moves the pill to the tab that was tapped', (tester) async {
      await tester.pumpSignedInApp();

      await openTab(tester, tester.l10n.tabSettings);

      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(selectedIndex(tester), 4);
    });

    testWidgets('keeps Home state when returning from another tab', (
      tester,
    ) async {
      await tester.pumpSignedInApp();
      final homeState = tester.state(find.byType(Scrollable).first);

      await openTab(tester, tester.l10n.tabSettings);
      await openTab(tester, tester.l10n.tabHome);

      expect(tester.state(find.byType(Scrollable).first), same(homeState));
    });
  });

  group('Settings', () {
    testWidgets('log out asks first and does nothing on cancel', (
      tester,
    ) async {
      await tester.pumpSignedInApp();
      await openTab(tester, tester.l10n.tabSettings);

      await tester.tap(find.byKey(const Key('settings-log-out')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(tester.l10n.cancel));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('confirmed log out clears the session and shows Onboarding', (
      tester,
    ) async {
      await tester.pumpSignedInApp();
      await openTab(tester, tester.l10n.tabSettings);

      await tester.tap(find.byKey(const Key('settings-log-out')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('settings-log-out-confirm')));
      await tester.pumpAndSettle();

      final container = ProviderScope.containerOf(
        tester.element(find.byType(OnboardingScreen)),
      );
      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(container.read(sessionControllerProvider).value, isNull);
    });
  });
}
