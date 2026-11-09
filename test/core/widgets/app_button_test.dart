import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/widgets/app_button.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders the label in upper case', (tester) async {
      await tester.pumpScreen(
        Scaffold(
          body: AppButton(label: 'Continue', onPressed: () {}),
        ),
      );

      expect(find.text('CONTINUE'), findsOneWidget);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpScreen(
        const Scaffold(body: AppButton(label: 'Continue', onPressed: null)),
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.enabled, isFalse);
    });

    testWidgets('shows a spinner instead of the label while loading', (
      tester,
    ) async {
      await tester.pumpScreen(
        Scaffold(
          body: AppButton(label: 'Continue', isLoading: true, onPressed: () {}),
        ),
        settle: false,
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('CONTINUE'), findsNothing);
    });

    testWidgets('ignores taps while loading', (tester) async {
      var taps = 0;
      await tester.pumpScreen(
        Scaffold(
          body: AppButton(
            label: 'Continue',
            isLoading: true,
            onPressed: () => taps++,
          ),
        ),
        settle: false,
      );

      await tester.tap(find.byType(AppButton));
      await tester.pump();

      expect(taps, 0);
    });

    testWidgets('invokes onPressed once per tap when idle', (tester) async {
      var taps = 0;
      await tester.pumpScreen(
        Scaffold(
          body: AppButton(label: 'Continue', onPressed: () => taps++),
        ),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();

      expect(taps, 1);
    });
  });
}
