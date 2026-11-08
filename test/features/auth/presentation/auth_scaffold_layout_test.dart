import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/theme/app_theme.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_controller.dart';
import 'package:j_donuts/features/auth/presentation/screens/date_of_birth_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/name_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/phone_screen.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

import '../../../helpers/test_overrides.dart';

/// A small Android phone (360x640 dp) with the soft keyboard up and the
/// largest supported text scale: the tightest space an auth step must fit.
const Size _smallPhone = Size(360, 640);
const double _keyboardHeight = 280;
const double _maxTextScale = 1.3;

void main() {
  late ProviderContainer container;

  Future<void> pumpStep(WidgetTester tester, Widget step) async {
    tester.view
      ..physicalSize = _smallPhone
      ..devicePixelRatio = 1
      ..viewInsets = const FakeViewPadding(bottom: _keyboardHeight);
    tester.platformDispatcher.textScaleFactorTestValue = _maxTextScale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    container = ProviderContainer(overrides: testOverrides());
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: step,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Pumps frame by frame so an overflow that exists only mid-animation is
  /// reported, not skipped over by `pumpAndSettle`.
  Future<void> pumpEveryFrame(WidgetTester tester) async {
    for (var frame = 0; frame < 30; frame++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
  }

  AuthFlowController flow() =>
      container.read(authFlowControllerProvider.notifier);

  group('Auth steps fit a small phone with the keyboard open', () {
    testWidgets('date of birth while its error appears and disappears', (
      tester,
    ) async {
      await pumpStep(tester, const DateOfBirthScreen());

      flow()
        ..birthMonthChanged(4)
        ..birthDayChanged(31)
        ..birthYearChanged(1990);
      await pumpEveryFrame(tester);
      expect(find.text("That isn't a real calendar date."), findsOneWidget);

      flow().birthDayChanged(30);
      await pumpEveryFrame(tester);

      expect(tester.takeException(), isNull);
    });

    testWidgets('name step with both errors showing', (tester) async {
      await pumpStep(tester, const NameScreen());

      flow()
        ..firstNameChanged('Ye Min 2')
        ..lastNameChanged('Win!');
      await pumpEveryFrame(tester);

      expect(tester.takeException(), isNull);
    });

    testWidgets('phone step', (tester) async {
      await pumpStep(tester, const PhoneScreen());

      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('Continue stays pinned to the bottom on a roomy screen', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(390, 844)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    container = ProviderContainer(overrides: testOverrides());
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const NameScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final continueTop = tester.getTopLeft(
      find.byKey(const Key('name-continue')),
    );
    final lastFieldBottom = tester.getBottomLeft(
      find.byKey(const Key('last-name-field')),
    );
    expect(continueTop.dy - lastFieldBottom.dy, greaterThan(200));
  });
}
