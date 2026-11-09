import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/app.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/core/time/clock.dart';
import 'package:j_donuts/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_donuts/features/home/presentation/screens/home_screen.dart';
import 'package:j_donuts/features/home/presentation/screens/welcome_screen.dart';
import 'package:j_donuts/features/shell/presentation/settings_screen.dart';

import '../helpers/auth_flow_driver.dart';
import '../helpers/pump_app.dart';
import '../helpers/test_overrides.dart';

/// "Relaunch" means a brand-new ProviderScope over the same database and the
/// same secure store, which is exactly what survives a real app restart.
void main() {
  testWidgets('registration survives a relaunch; logging out does not', (
    tester,
  ) async {
    final database = testDatabase();
    final store = InMemoryKeyValueStore();
    addTearDown(database.close);
    List<Override> sameDevice() => [
      ...testOverrides(
        database: database,
        store: store,
        closeDatabaseOnDispose: false,
      ),
      clockProvider.overrideWithValue(() => DateTime(2026, 11, 9)),
    ];

    await tester.reachDateOfBirthStep(overrides: sameDevice());
    await tester.enterBirthDate(monthName: 'May', day: '1', year: '1980');
    await tester.tap(find.byKey(const Key('dob-continue')));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeScreen), findsOneWidget);

    await relaunch(tester, sameDevice());
    expect(
      find.byType(HomeScreen),
      findsOneWidget,
      reason: 'a stored session skips onboarding (and Welcome) on relaunch',
    );

    await tester.tap(find.bySemanticsLabel(tester.l10n.tabSettings).last);
    await tester.pumpAndSettle();
    expect(find.byType(SettingsScreen), findsOneWidget);
    await tester.tap(find.byKey(const Key('settings-log-out')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings-log-out-confirm')));
    await tester.pumpAndSettle();
    expect(find.byType(OnboardingScreen), findsOneWidget);

    await relaunch(tester, sameDevice());
    expect(
      find.byType(OnboardingScreen),
      findsOneWidget,
      reason: 'logging out clears the stored session',
    );
  });
}

Future<void> relaunch(WidgetTester tester, List<Override> overrides) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(),
      overrides: overrides,
      child: const JDonutsApp(),
    ),
  );
  await tester.pumpAndSettle();
}
