import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:j_donuts/features/auth/presentation/screens/date_of_birth_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/name_screen.dart';

import 'pump_app.dart';

const String newUserNumber = '09254135592';
const double _monthScrollStep = 120;

/// Drives the real registration flow through the UI, so step tests start
/// from the same state a user would reach rather than from seeded providers.
extension AuthFlowDriver on WidgetTester {
  Future<void> reachNameStep({List<Override>? overrides}) async {
    await pumpApp(overrides: overrides);
    await tap(find.text(l10n.getStarted.toUpperCase()));
    await pumpAndSettle();
    await enterText(find.byKey(const Key('phone-field')), newUserNumber);
    await pump();
    await tap(find.byKey(const Key('phone-continue')));
    await pumpAndSettle();
    await enterText(
      find.byKey(const Key('otp-input')),
      FakeAuthRepository.defaultOtp,
    );
    await pumpAndSettle();
    expect(find.byType(NameScreen), findsOneWidget);
  }

  Future<void> reachDateOfBirthStep({
    String firstName = 'Ye Min',
    String lastName = 'Phyoe Win',
    List<Override>? overrides,
  }) async {
    await reachNameStep(overrides: overrides);
    await enterText(find.byKey(const Key('first-name-field')), firstName);
    await enterText(find.byKey(const Key('last-name-field')), lastName);
    await pump();
    await tap(find.byKey(const Key('name-continue')));
    await pumpAndSettle();
    expect(find.byType(DateOfBirthScreen), findsOneWidget);
  }

  /// [monthName] must be the English name; tests run in the `en` locale.
  Future<void> enterBirthDate({
    required String monthName,
    required String day,
    required String year,
  }) async {
    await tap(find.byKey(const Key('dob-month-field')));
    await pumpAndSettle();
    final option = find.descendant(
      of: find.byType(BottomSheet),
      matching: find.text(monthName),
    );
    await scrollUntilVisible(
      option,
      _monthScrollStep,
      scrollable: find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(Scrollable),
      ),
    );
    await tap(option);
    await pumpAndSettle();
    await enterText(find.byKey(const Key('dob-day-field')), day);
    await enterText(find.byKey(const Key('dob-year-field')), year);
    await pump();
  }

  bool isButtonEnabled(Key key) => widget<FilledButton>(
    find.descendant(of: find.byKey(key), matching: find.byType(FilledButton)),
  ).enabled;
}
