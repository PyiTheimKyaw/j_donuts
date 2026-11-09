import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/theme/app_theme.dart';
import 'package:j_donuts/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_donuts/features/home/presentation/screens/home_screen.dart';
import 'package:j_donuts/features/home/presentation/screens/welcome_screen.dart';
import 'package:j_donuts/features/product/presentation/screens/product_detail_screen.dart';
import 'package:j_donuts/features/rewards/presentation/screens/rewards_screen.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/reward_tabs.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/tier_ladder_view.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

import '../helpers/test_overrides.dart';

/// The brief's smallest supported phone (4.7", 375x667 dp) at its largest
/// supported text scale. Any RenderFlex overflow fails the test.
const Size _smallestPhone = Size(375, 667);
const double _maxTextScale = 1.3;
const Size _narrowAndroidPhone = Size(360, 640);

void main() {
  /// Rewards never settles: the Earn button pulses for as long as a
  /// challenge is complete, so it is pumped for a fixed time instead.
  const entranceTime = Duration(seconds: 3);

  Future<void> pumpOnSmallestPhone(
    WidgetTester tester,
    Widget screen, {
    bool settles = true,
  }) async {
    tester.view
      ..physicalSize = _smallestPhone
      ..devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = _maxTextScale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(
      ProviderScope(
        overrides: testOverrides(),
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: screen,
        ),
      ),
    );
    settles ? await tester.pumpAndSettle() : await tester.pump(entranceTime);
  }

  /// Lazily built slivers only lay out once scrolled into view.
  Future<void> scrollToEnd(WidgetTester tester) async {
    final scrollable = find.byType(Scrollable).first;
    for (var page = 0; page < 6; page++) {
      await tester.drag(scrollable, const Offset(0, -500));
      await tester.pump(entranceTime);
    }
  }

  group('On a 4.7" phone with 1.3x text', () {
    testWidgets('Onboarding fits', (tester) async {
      await pumpOnSmallestPhone(tester, const OnboardingScreen());

      expect(tester.takeException(), isNull);
    });

    testWidgets('Welcome fits', (tester) async {
      await pumpOnSmallestPhone(tester, const WelcomeScreen());

      expect(tester.takeException(), isNull);
    });

    testWidgets('Home lays out every section', (tester) async {
      await pumpOnSmallestPhone(tester, const HomeScreen());
      await scrollToEnd(tester);

      expect(tester.takeException(), isNull);
    });

    testWidgets('Product detail lays out', (tester) async {
      await pumpOnSmallestPhone(
        tester,
        const ProductDetailScreen(productId: 'p_coconut'),
      );
      await scrollToEnd(tester);

      expect(tester.takeException(), isNull);
    });

    testWidgets('Rewards lays out the header and every card', (tester) async {
      await pumpOnSmallestPhone(tester, const RewardsScreen(), settles: false);
      await scrollToEnd(tester);

      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('the tier ladder never runs under the Rewards tabs', (
    tester,
  ) async {
    await pumpOnSmallestPhone(tester, const RewardsScreen(), settles: false);
    tester.view.physicalSize = _narrowAndroidPhone;
    await tester.pump(entranceTime);

    final ladderBottom = tester.getRect(find.byType(TierLadderView)).bottom;
    final tabsTop = tester.getRect(find.byType(RewardTabs)).top;
    expect(ladderBottom, lessThanOrEqualTo(tabsTop));
  });
}
