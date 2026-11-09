import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:j_donuts/app/app.dart';
import 'package:j_donuts/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:j_donuts/features/auth/presentation/screens/date_of_birth_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/name_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/otp_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/phone_screen.dart';
import 'package:j_donuts/features/home/presentation/screens/home_screen.dart';
import 'package:j_donuts/features/home/presentation/screens/welcome_screen.dart';
import 'package:j_donuts/features/home/presentation/widgets/product_section.dart';
import 'package:j_donuts/features/product/presentation/screens/product_detail_screen.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

import 'integration_overrides.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a new member registers, lands on Home and opens a product', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: integrationOverrides(),
        child: const JDonutsApp(),
      ),
    );
    await tester.pumpAndSettle();
    final l10n = tester.l10nOf(find.byType(OnboardingScreen));

    await tester.startRegistration(l10n);
    await tester.verifyPhone('09254135592', l10n);
    await tester.enterOtp(FakeAuthRepository.defaultOtp);
    await tester.enterName(first: 'Ye Min', last: 'Phyoe Win');
    await tester.enterBirthDate(month: 'May', day: '1', year: '1980');

    expect(find.byType(WelcomeScreen), findsOneWidget);
    await tester.tapAndSettle(find.byKey(const Key('welcome-explore')));

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Ye Min'), findsOneWidget);

    await tester.tapAndSettle(find.byType(ProductTile).first);

    expect(find.byType(ProductDetailScreen), findsOneWidget);
    expect(find.text('Mistletoe Romance box'), findsOneWidget);
    expect(find.text('18,000 MMK'), findsWidgets);

    await tester.tapAndSettle(find.byKey(const Key('quantity-increment')));
    expect(find.text('36,000 MMK'), findsOneWidget);
  });
}

/// Each step asserts the screen it should land on, so a failure names the
/// step that broke instead of a missing widget three screens later.
extension on WidgetTester {
  AppLocalizations l10nOf(Finder screen) =>
      AppLocalizations.of(element(screen));

  Future<void> tapAndSettle(Finder finder) async {
    await ensureVisible(finder);
    await pumpAndSettle();
    await tap(finder);
    await pumpAndSettle();
  }

  /// On a small phone the open keyboard covers the step's Continue button and
  /// its closing animation moves the layout mid-tap. A user closes it first;
  /// so does the test, waiting for the layout to settle before tapping.
  Future<void> submitStep(Finder continueButton) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await pumpAndSettle();
    await tapAndSettle(continueButton);
  }

  Future<void> startRegistration(AppLocalizations l10n) async {
    await tapAndSettle(find.text(l10n.getStarted.toUpperCase()));
    expect(find.byType(PhoneScreen), findsOneWidget);
  }

  Future<void> verifyPhone(String number, AppLocalizations l10n) async {
    await enterText(find.byKey(const Key('phone-field')), number);
    await pump();
    await submitStep(find.byKey(const Key('phone-continue')));
    expect(find.byType(OtpScreen), findsOneWidget);
  }

  Future<void> enterOtp(String code) async {
    await enterText(find.byKey(const Key('otp-input')), code);
    await pumpAndSettle();
    expect(find.byType(NameScreen), findsOneWidget);
  }

  Future<void> enterName({required String first, required String last}) async {
    await enterText(find.byKey(const Key('first-name-field')), first);
    await enterText(find.byKey(const Key('last-name-field')), last);
    await pump();
    await submitStep(find.byKey(const Key('name-continue')));
    expect(find.byType(DateOfBirthScreen), findsOneWidget);
  }

  Future<void> enterBirthDate({
    required String month,
    required String day,
    required String year,
  }) async {
    await tapAndSettle(find.byKey(const Key('dob-month-field')));
    final option = find.descendant(
      of: find.byType(BottomSheet),
      matching: find.text(month),
    );
    await scrollUntilVisible(
      option,
      120,
      scrollable: find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(Scrollable),
      ),
    );
    await tapAndSettle(option);
    await enterText(find.byKey(const Key('dob-day-field')), day);
    await enterText(find.byKey(const Key('dob-year-field')), year);
    await pump();
    await submitStep(find.byKey(const Key('dob-continue')));
  }
}
