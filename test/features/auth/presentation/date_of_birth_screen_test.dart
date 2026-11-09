import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/time/clock.dart';
import 'package:j_donuts/core/widgets/app_button.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/presentation/screens/date_of_birth_screen.dart';
import 'package:j_donuts/features/auth/presentation/session/session_controller.dart';
import 'package:j_donuts/features/home/presentation/screens/welcome_screen.dart';

import '../../../helpers/auth_flow_driver.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/test_overrides.dart';

void main() {
  const continueKey = Key('dob-continue');
  final today = DateTime(2026, 11, 8);

  Future<void> openStep(WidgetTester tester, {Duration? latency}) =>
      tester.reachDateOfBirthStep(
        overrides: [
          ...testOverrides(latency: latency ?? Duration.zero),
          clockProvider.overrideWithValue(() => today),
        ],
      );

  group('DateOfBirthScreen validation', () {
    testWidgets('Continue stays disabled and silent while incomplete', (
      tester,
    ) async {
      await openStep(tester);

      await tester.enterText(find.byKey(const Key('dob-day-field')), '1');
      await tester.pump();

      expect(tester.isButtonEnabled(continueKey), isFalse);
      expect(find.text(tester.l10n.dobInvalidDate), findsNothing);
    });

    testWidgets('a three-digit year does not count as complete', (
      tester,
    ) async {
      await openStep(tester);

      await tester.enterBirthDate(monthName: 'May', day: '1', year: '198');

      expect(tester.isButtonEnabled(continueKey), isFalse);
    });

    testWidgets('rejects 31 April', (tester) async {
      await openStep(tester);

      await tester.enterBirthDate(monthName: 'April', day: '31', year: '1990');

      expect(find.text(tester.l10n.dobInvalidDate), findsOneWidget);
      expect(tester.isButtonEnabled(continueKey), isFalse);
    });

    testWidgets('rejects 29 February in a common year', (tester) async {
      await openStep(tester);

      await tester.enterBirthDate(
        monthName: 'February',
        day: '29',
        year: '2003',
      );

      expect(find.text(tester.l10n.dobInvalidDate), findsOneWidget);
    });

    testWidgets('accepts 29 February in a leap year', (tester) async {
      await openStep(tester);

      await tester.enterBirthDate(
        monthName: 'February',
        day: '29',
        year: '2004',
      );

      expect(tester.isButtonEnabled(continueKey), isTrue);
    });

    testWidgets('rejects a date in the future', (tester) async {
      await openStep(tester);

      await tester.enterBirthDate(monthName: 'January', day: '1', year: '2027');

      expect(find.text(tester.l10n.dobInFuture), findsOneWidget);
    });

    testWidgets('rejects someone younger than the minimum age', (tester) async {
      await openStep(tester);
      final year = today.year - AuthPolicy.minimumAgeYears;

      await tester.enterBirthDate(
        monthName: 'November',
        day: '9',
        year: '$year',
      );

      expect(
        find.text(tester.l10n.dobTooYoung(AuthPolicy.minimumAgeYears)),
        findsOneWidget,
      );
    });
  });

  group('DateOfBirthScreen registration', () {
    testWidgets('a valid date registers and opens Welcome', (tester) async {
      await openStep(tester);
      await tester.enterBirthDate(monthName: 'May', day: '1', year: '1980');

      await tester.tap(find.byKey(continueKey));
      await tester.pumpAndSettle();

      final container = ProviderScope.containerOf(
        tester.element(find.byType(Scaffold).first),
      );
      expect(container.read(sessionControllerProvider).value, isNotNull);
      expect(find.byType(DateOfBirthScreen), findsNothing);
      expect(find.byType(WelcomeScreen), findsOneWidget);
    });

    testWidgets('shows a loading state and registers once on double tap', (
      tester,
    ) async {
      await openStep(tester, latency: const Duration(milliseconds: 300));
      await tester.enterBirthDate(monthName: 'May', day: '1', year: '1980');

      await tester.tap(find.byKey(continueKey));
      await tester.pump();
      await tester.tap(find.byKey(continueKey), warnIfMissed: false);
      await tester.pump(const Duration(milliseconds: 50));

      expect(
        find.descendant(
          of: find.byType(AppButton),
          matching: find.byType(CircularProgressIndicator),
        ),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeScreen), findsOneWidget);
    });

    testWidgets('keeps the entered date when returning with Back', (
      tester,
    ) async {
      await openStep(tester);
      await tester.enterBirthDate(monthName: 'May', day: '1', year: '1980');

      await tester.tap(find.byIcon(Icons.arrow_back_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('name-continue')));
      await tester.pumpAndSettle();

      expect(find.text('May'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('1980'), findsOneWidget);
    });
  });
}
