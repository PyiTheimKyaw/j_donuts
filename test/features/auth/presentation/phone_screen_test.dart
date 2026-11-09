import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/widgets/app_button.dart';
import 'package:j_donuts/features/auth/data/datasources/user_local_data_source.dart';
import 'package:j_donuts/features/auth/data/mappers/user_mapper.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/presentation/screens/otp_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/phone_screen.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/test_overrides.dart';

void main() {
  const validNumber = '09254135592';
  final continueButton = find.byKey(const Key('phone-continue'));
  final phoneField = find.byKey(const Key('phone-field'));

  Future<void> openPhoneStep(WidgetTester tester, {bool login = false}) async {
    final label = login
        ? tester.l10n.logIn
        : tester.l10n.getStarted.toUpperCase();
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();
    expect(find.byType(PhoneScreen), findsOneWidget);
  }

  Future<void> enterPhone(WidgetTester tester, String number) async {
    await tester.enterText(phoneField, number);
    await tester.pump();
  }

  bool continueEnabled(WidgetTester tester) => tester
      .widget<FilledButton>(
        find.descendant(
          of: continueButton,
          matching: find.byType(FilledButton),
        ),
      )
      .enabled;

  group('PhoneScreen validation', () {
    testWidgets('Continue is disabled until the number is valid', (
      tester,
    ) async {
      await tester.pumpApp();
      await openPhoneStep(tester);

      expect(continueEnabled(tester), isFalse);

      await enterPhone(tester, '0925');
      await tester.pump();
      expect(continueEnabled(tester), isFalse);

      await enterPhone(tester, validNumber);
      expect(continueEnabled(tester), isTrue);
    });

    testWidgets('shows the format error only after the field loses focus', (
      tester,
    ) async {
      await tester.pumpApp();
      await openPhoneStep(tester);

      await enterPhone(tester, '0812345678');
      await tester.pump();
      expect(find.text(tester.l10n.phoneInvalid), findsNothing);

      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();
      expect(find.text(tester.l10n.phoneInvalid), findsOneWidget);
    });

    testWidgets('keeps the typed number when returning with Back', (
      tester,
    ) async {
      await tester.pumpApp();
      await openPhoneStep(tester);
      await enterPhone(tester, validNumber);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();
      expect(find.byType(OtpScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back_rounded));
      await tester.pumpAndSettle();

      expect(find.text(validNumber), findsOneWidget);
    });
  });

  group('PhoneScreen registration', () {
    testWidgets('a valid number advances to the OTP step', (tester) async {
      await tester.pumpApp();
      await openPhoneStep(tester);

      await enterPhone(tester, validNumber);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      expect(find.byType(OtpScreen), findsOneWidget);
    });

    testWidgets('shows the loading state and sends one request on double tap', (
      tester,
    ) async {
      await tester.pumpApp(
        overrides: testOverrides(latency: const Duration(milliseconds: 300)),
      );
      await openPhoneStep(tester);
      await enterPhone(tester, validNumber);

      await tester.tap(continueButton);
      await tester.pump();
      await tester.tap(continueButton, warnIfMissed: false);
      await tester.pump(const Duration(milliseconds: 50));

      expect(
        find.descendant(
          of: find.byType(AppButton),
          matching: find.byType(CircularProgressIndicator),
        ),
        findsOneWidget,
      );

      await tester.pumpAndSettle();
      expect(find.byType(OtpScreen), findsOneWidget);
    });
  });

  group('PhoneScreen login', () {
    testWidgets(
      'an unregistered number shows the message and a Register link',
      (tester) async {
        await tester.pumpApp();
        await openPhoneStep(tester, login: true);

        await enterPhone(tester, validNumber);
        await tester.tap(continueButton);
        await tester.pumpAndSettle();

        expect(find.byType(PhoneScreen), findsOneWidget);
        expect(find.text(tester.l10n.phoneNotRegistered), findsOneWidget);
        expect(find.byKey(const Key('register-link')), findsOneWidget);
      },
    );

    testWidgets('the Register link switches to registration and continues', (
      tester,
    ) async {
      await tester.pumpApp();
      await openPhoneStep(tester, login: true);
      await enterPhone(tester, validNumber);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('register-link')));
      await tester.pumpAndSettle();
      expect(find.text(tester.l10n.phoneNotRegistered), findsNothing);

      await tester.tap(continueButton);
      await tester.pumpAndSettle();
      expect(find.byType(OtpScreen), findsOneWidget);
    });

    testWidgets('a registered number goes straight to the OTP step', (
      tester,
    ) async {
      final database = testDatabase();
      await UserLocalDataSource(database).upsert(
        UserMapper.toCompanion(
          const RegistrationDetails(
            phone: PhoneNumber('9254135592'),
            name: PersonName(firstName: 'Hania'),
            birthDate: BirthDate(year: 1995, month: 3, day: 4),
          ),
          createdAt: DateTime(2026),
        ),
      );
      await tester.pumpApp(overrides: testOverrides(database: database));
      await openPhoneStep(tester, login: true);

      await enterPhone(tester, validNumber);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      expect(find.byType(OtpScreen), findsOneWidget);
    });
  });
}
