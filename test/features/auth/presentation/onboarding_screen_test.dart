import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_donuts/features/auth/presentation/screens/phone_screen.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('OnboardingScreen', () {
    testWidgets('is the first screen for a signed-out user', (tester) async {
      await tester.pumpApp();

      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(find.text(tester.l10n.onboardingTitle), findsOneWidget);
    });

    testWidgets("Let's get started opens the phone step", (tester) async {
      await tester.pumpApp();

      await tester.tap(find.text(tester.l10n.getStarted.toUpperCase()));
      await tester.pumpAndSettle();

      expect(find.byType(PhoneScreen), findsOneWidget);
    });

    testWidgets('Log In opens the phone step', (tester) async {
      await tester.pumpApp();

      await tester.tap(find.text(tester.l10n.logIn));
      await tester.pumpAndSettle();

      expect(find.byType(PhoneScreen), findsOneWidget);
    });

    testWidgets('social buttons show a placeholder snackbar', (tester) async {
      await tester.pumpApp();

      await tester.tap(find.byIcon(Icons.apple));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('Apple'), findsOneWidget);
    });

    testWidgets('Terms of Use opens a placeholder sheet', (tester) async {
      await tester.pumpApp();

      _tapInlineLink(tester, tester.l10n.termsOfUse);
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text(tester.l10n.legalPlaceholderBody), findsOneWidget);
    });
  });
}

void _tapInlineLink(WidgetTester tester, String linkText) {
  for (final richText in tester.widgetList<RichText>(find.byType(RichText))) {
    TapGestureRecognizer? recognizer;
    richText.text.visitChildren((span) {
      if (span is TextSpan && span.text == linkText) {
        recognizer = span.recognizer as TapGestureRecognizer?;
        return false;
      }
      return true;
    });
    if (recognizer != null) {
      recognizer!.onTap!();
      return;
    }
  }
  fail('No inline link with text "$linkText"');
}
