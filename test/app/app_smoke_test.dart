import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/app.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

void main() {
  group('JDonutsApp', () {
    testWidgets('boots to the onboarding route', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: JDonutsApp()));
      await tester.pumpAndSettle();

      expect(find.text('Onboarding'), findsOneWidget);
    });

    testWidgets('ships English and Burmese locales', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: JDonutsApp()));
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(Scaffold));
      final app = context.findAncestorWidgetOfExactType<MaterialApp>()!;

      expect(
        app.supportedLocales,
        containsAll([const Locale('en'), const Locale('my')]),
      );
      expect(AppLocalizations.of(context).appTitle, "J'Donuts");
    });

    testWidgets('clamps text scale to the verified maximum', (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(const ProviderScope(child: JDonutsApp()));
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(Scaffold));
      final scaled = MediaQuery.textScalerOf(context).scale(10);

      expect(scaled, 10 * JDonutsApp.maxTextScale);
    });
  });
}
