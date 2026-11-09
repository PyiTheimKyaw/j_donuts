import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/time/clock.dart';
import 'package:j_donuts/features/auth/presentation/session/welcome_pending.dart';
import 'package:j_donuts/features/home/presentation/screens/home_screen.dart';
import 'package:j_donuts/features/home/presentation/screens/welcome_screen.dart';

import '../../../helpers/auth_flow_driver.dart';
import '../../../helpers/test_overrides.dart';

void main() {
  Future<void> registerToWelcome(WidgetTester tester) async {
    await tester.reachDateOfBirthStep(
      overrides: [
        ...testOverrides(),
        clockProvider.overrideWithValue(() => DateTime(2026, 11, 8)),
      ],
    );
    await tester.enterBirthDate(monthName: 'May', day: '1', year: '1980');
    await tester.tap(find.byKey(const Key('dob-continue')));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeScreen), findsOneWidget);
  }

  testWidgets("Let's explore opens Home and greets the new member by name", (
    tester,
  ) async {
    await registerToWelcome(tester);

    await tester.tap(find.byKey(const Key('welcome-explore')));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Ye Min'), findsOneWidget);
  });

  testWidgets('Welcome is shown only once', (tester) async {
    await registerToWelcome(tester);

    await tester.tap(find.byKey(const Key('welcome-explore')));
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(HomeScreen)),
    );
    expect(container.read(welcomePendingProvider), isFalse);
  });

  testWidgets('tiles are staggered photos that bleed off the top edge', (
    tester,
  ) async {
    await registerToWelcome(tester);

    final tiles = find.descendant(
      of: find.byType(WelcomeScreen),
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName.contains('welcome/tile_'),
      ),
    );
    expect(tiles, findsNWidgets(WelcomeTile.values.length));
    expect(find.byType(ShaderMask), findsOneWidget);

    final topLeft = tester.getRect(tiles.at(0));
    final topRight = tester.getRect(tiles.at(1));
    expect(topLeft.top, lessThan(0));
    expect(topRight.top, greaterThan(topLeft.top));
  });
}
