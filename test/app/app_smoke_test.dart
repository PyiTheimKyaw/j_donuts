import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/app.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/features/auth/data/repositories/secure_session_repository.dart';
import 'package:j_donuts/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

import '../helpers/test_overrides.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester, {KeyValueStore? store}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: testOverrides(store: store),
        child: const JDonutsApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('JDonutsApp', () {
    testWidgets('boots to onboarding when nobody is signed in', (tester) async {
      await pumpApp(tester);

      expect(find.byType(OnboardingScreen), findsOneWidget);
    });

    testWidgets('boots to home when a session is stored', (tester) async {
      final store = InMemoryKeyValueStore({
        SecureSessionRepository.storageKey:
            '{"phone":"9254135592","startedAt":"2026-11-08T00:00:00.000Z"}',
      });

      await pumpApp(tester, store: store);

      expect(find.text('Home'), findsWidgets);
    });

    testWidgets('ships English and Burmese locales', (tester) async {
      await pumpApp(tester);

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

      await pumpApp(tester);

      final context = tester.element(find.byType(Scaffold));
      final scaled = MediaQuery.textScalerOf(context).scale(10);

      expect(scaled, 10 * JDonutsApp.maxTextScale);
    });
  });
}
