import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/features/auth/data/datasources/user_local_data_source.dart';
import 'package:j_donuts/features/auth/data/mappers/user_mapper.dart';
import 'package:j_donuts/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/presentation/screens/name_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/otp_screen.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/test_overrides.dart';

void main() {
  const number = '09254135592';
  const wrongCode = '000000';
  const rightCode = FakeAuthRepository.defaultOtp;
  final otpInput = find.byKey(const Key('otp-input'));
  final resendButton = find.byKey(const Key('otp-resend'));

  Future<void> openOtpStep(
    WidgetTester tester, {
    bool login = false,
    List<Override>? overrides,
  }) async {
    await tester.pumpApp(overrides: overrides);
    final entry = login
        ? tester.l10n.logIn
        : tester.l10n.getStarted.toUpperCase();
    await tester.tap(find.text(entry));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('phone-field')), number);
    await tester.pump();
    await tester.tap(find.byKey(const Key('phone-continue')));
    await tester.pumpAndSettle();
    expect(find.byType(OtpScreen), findsOneWidget);
  }

  Future<void> enterCode(WidgetTester tester, String code) async {
    await tester.enterText(otpInput, code);
    await tester.pumpAndSettle();
  }

  bool inputEnabled(WidgetTester tester) => tester
      .widget<TextField>(
        find.descendant(of: otpInput, matching: find.byType(TextField)),
      )
      .enabled!;

  bool inputFocused(WidgetTester tester) => tester
      .widget<EditableText>(
        find.descendant(of: otpInput, matching: find.byType(EditableText)),
      )
      .focusNode
      .hasFocus;

  Future<AppDatabase> databaseWithRegisteredUser() async {
    final database = AppDatabase(NativeDatabase.memory());
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
    return database;
  }

  group('OtpScreen layout', () {
    testWidgets('shows the number the code was sent to', (tester) async {
      await openOtpStep(tester);

      expect(
        find.text(tester.l10n.otpSubtitle('+959254135592')),
        findsOneWidget,
      );
    });

    testWidgets('starts the resend countdown at 5:00', (tester) async {
      await openOtpStep(tester);

      expect(find.textContaining('5:00'), findsOneWidget);
      expect(resendButton, findsNothing);
    });
  });

  group('OtpScreen wrong codes', () {
    testWidgets('clears the boxes and shows attempts left', (tester) async {
      await openOtpStep(tester);

      await enterCode(tester, wrongCode);

      expect(find.textContaining(tester.l10n.otpInvalid), findsOneWidget);
      expect(
        find.textContaining(tester.l10n.otpAttemptsLeft(2)),
        findsOneWidget,
      );
      expect(find.text('0'), findsNothing);
      expect(inputFocused(tester), isTrue);
    });

    testWidgets('locks entry after three wrong codes', (tester) async {
      await openOtpStep(tester);

      for (var i = 0; i < AuthPolicy.maxOtpAttempts; i++) {
        await enterCode(tester, wrongCode);
      }

      expect(find.text(tester.l10n.otpLocked), findsOneWidget);
      expect(inputEnabled(tester), isFalse);
    });

    testWidgets('Resend unlocks entry once the countdown ends', (tester) async {
      await openOtpStep(tester);
      for (var i = 0; i < AuthPolicy.maxOtpAttempts; i++) {
        await enterCode(tester, wrongCode);
      }

      await tester.pump(AuthPolicy.otpResendCooldown);
      await tester.pumpAndSettle();
      expect(find.textContaining('0:00'), findsNothing);

      await tester.tap(resendButton);
      await tester.pumpAndSettle();

      expect(inputEnabled(tester), isTrue);
      expect(find.text(tester.l10n.otpLocked), findsNothing);
      expect(find.textContaining('5:00'), findsOneWidget);
      expect(find.text(tester.l10n.otpResent), findsOneWidget);
    });
  });

  group('OtpScreen correct code', () {
    testWidgets('a new number continues to the name step', (tester) async {
      await openOtpStep(tester);

      await enterCode(tester, rightCode);

      expect(find.byType(OtpScreen), findsNothing);
      expect(find.byType(NameScreen), findsOneWidget);
    });

    testWidgets('a pasted message is reduced to its digits', (tester) async {
      await openOtpStep(tester);

      await enterCode(tester, 'Your code: 123 456');

      expect(find.byType(NameScreen), findsOneWidget);
    });

    testWidgets('a returning user lands on Home', (tester) async {
      final database = await databaseWithRegisteredUser();
      await openOtpStep(
        tester,
        login: true,
        overrides: testOverrides(database: database),
      );

      await enterCode(tester, rightCode);

      expect(find.byType(OtpScreen), findsNothing);
      expect(find.text('Home'), findsWidgets);
    });
  });
}
