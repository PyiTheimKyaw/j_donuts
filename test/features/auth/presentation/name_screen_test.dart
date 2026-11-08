import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/presentation/screens/date_of_birth_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/name_screen.dart';

import '../../../helpers/auth_flow_driver.dart';
import '../../../helpers/pump_app.dart';

void main() {
  const continueKey = Key('name-continue');
  final firstName = find.byKey(const Key('first-name-field'));
  final lastName = find.byKey(const Key('last-name-field'));

  Future<void> typeFirst(WidgetTester tester, String value) async {
    await tester.enterText(firstName, value);
    await tester.pump();
  }

  Future<void> typeLast(WidgetTester tester, String value) async {
    await tester.enterText(lastName, value);
    await tester.pump();
  }

  group('NameScreen first name', () {
    testWidgets('Continue is disabled until a first name is entered', (
      tester,
    ) async {
      await tester.reachNameStep();

      expect(tester.isButtonEnabled(continueKey), isFalse);

      await typeFirst(tester, 'Ye Min');
      expect(tester.isButtonEnabled(continueKey), isTrue);
    });

    testWidgets('does not show "required" before the field is left', (
      tester,
    ) async {
      await tester.reachNameStep();

      expect(find.text(tester.l10n.nameRequired), findsNothing);

      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();
      expect(find.text(tester.l10n.nameRequired), findsOneWidget);
    });

    testWidgets('rejects digits as soon as they are typed', (tester) async {
      await tester.reachNameStep();

      await typeFirst(tester, 'Ye Min 2');

      expect(find.text(tester.l10n.nameInvalidCharacters), findsOneWidget);
      expect(tester.isButtonEnabled(continueKey), isFalse);
    });

    testWidgets('accepts a Myanmar-script name', (tester) async {
      await tester.reachNameStep();

      await typeFirst(tester, 'ကျော်ကျော်');

      expect(find.text(tester.l10n.nameInvalidCharacters), findsNothing);
      expect(tester.isButtonEnabled(continueKey), isTrue);
    });

    testWidgets('rejects a name over the length limit', (tester) async {
      await tester.reachNameStep();

      await typeFirst(tester, 'a' * (AuthPolicy.maxNameLength + 1));

      expect(
        find.text(tester.l10n.nameTooLong(AuthPolicy.maxNameLength)),
        findsOneWidget,
      );
    });
  });

  group('NameScreen last name', () {
    testWidgets('is optional', (tester) async {
      await tester.reachNameStep();

      await typeFirst(tester, 'Hania');

      expect(tester.isButtonEnabled(continueKey), isTrue);
    });

    testWidgets('follows the same character rules', (tester) async {
      await tester.reachNameStep();
      await typeFirst(tester, 'Ye Min');

      await typeLast(tester, 'Win!');

      expect(find.text(tester.l10n.nameInvalidCharacters), findsOneWidget);
      expect(tester.isButtonEnabled(continueKey), isFalse);
    });
  });

  group('NameScreen navigation', () {
    testWidgets('Continue opens the date of birth step', (tester) async {
      await tester.reachDateOfBirthStep();

      expect(find.byType(DateOfBirthScreen), findsOneWidget);
    });

    testWidgets('keeps both names when returning with Back', (tester) async {
      await tester.reachDateOfBirthStep(lastName: 'Win');

      await tester.tap(find.byIcon(Icons.arrow_back_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(NameScreen), findsOneWidget);
      expect(find.text('Ye Min'), findsOneWidget);
      expect(find.text('Win'), findsOneWidget);
    });
  });
}
