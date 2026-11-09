import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/app.dart';
import 'package:j_donuts/app/locale/app_locale.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/l10n/generated/app_localizations_en.dart';
import 'package:j_donuts/l10n/generated/app_localizations_my.dart';

import '../helpers/pump_app.dart';
import '../helpers/test_overrides.dart';

void main() {
  final english = AppLocalizationsEn();
  final burmese = AppLocalizationsMy();

  group('Language toggle', () {
    testWidgets('switches the onboarding screen to Burmese and back', (
      tester,
    ) async {
      await tester.pumpApp();
      expect(find.text(english.onboardingTitle), findsOneWidget);

      await tester.tap(find.byKey(const Key('language-my')));
      await tester.pumpAndSettle();
      expect(find.text(burmese.onboardingTitle), findsOneWidget);

      await tester.tap(find.byKey(const Key('language-en')));
      await tester.pumpAndSettle();
      expect(find.text(english.onboardingTitle), findsOneWidget);
    });

    testWidgets('the choice survives a relaunch', (tester) async {
      final store = InMemoryKeyValueStore();
      await tester.pumpApp(overrides: testOverrides(store: store));
      await tester.tap(find.byKey(const Key('language-my')));
      await tester.pumpAndSettle();

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        ProviderScope(
          key: UniqueKey(),
          overrides: testOverrides(store: store),
          child: const JDonutsApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(burmese.onboardingTitle), findsOneWidget);
    });
  });

  group('AppLocale', () {
    test('follows the device language until the user chooses', () async {
      final container = ProviderContainer(overrides: testOverrides());
      addTearDown(container.dispose);

      expect(await container.read(appLocaleProvider.future), isNull);
    });

    test('ignores a stored language this build does not support', () async {
      final store = InMemoryKeyValueStore({AppLocale.storageKey: 'fr'});
      final container = ProviderContainer(
        overrides: testOverrides(store: store),
      );
      addTearDown(container.dispose);

      expect(await container.read(appLocaleProvider.future), isNull);
    });
  });
}
