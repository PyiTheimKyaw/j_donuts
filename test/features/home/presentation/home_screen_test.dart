import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/features/home/presentation/screens/home_screen.dart';
import 'package:j_donuts/features/home/presentation/widgets/banner_carousel.dart';
import 'package:j_donuts/features/home/presentation/widgets/nearby_shops.dart';
import 'package:j_donuts/features/home/presentation/widgets/product_section.dart';
import 'package:j_donuts/features/home/presentation/widgets/shops_scenery.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/signed_in_app.dart';

void main() {
  final scrollable = find.byType(Scrollable).first;

  Future<void> scrollTo(WidgetTester tester, Finder target) =>
      tester.scrollUntilVisible(target, 300, scrollable: scrollable);

  group('Home offline-first', () {
    testWidgets(
      'renders every section from the seeded database while offline',
      (tester) async {
        await tester.pumpSignedInApp();

        expect(find.byType(HomeScreen), findsOneWidget);
        expect(find.text('Hania'), findsOneWidget);
        expect(find.byType(BannerCarousel), findsOneWidget);
        expect(find.text(tester.l10n.seasonalSpecials), findsOneWidget);
        await scrollTo(tester, find.text(tester.l10n.orderAgain));
        await scrollTo(tester, find.byType(NearbyShops));
        expect(find.text(tester.l10n.nearbyShopsTitle(4)), findsOneWidget);
      },
    );

    testWidgets('shows the tier and points from the single member record', (
      tester,
    ) async {
      await tester.pumpSignedInApp();

      expect(
        find.text(tester.l10n.memberTier(tester.l10n.tierSilver)),
        findsOneWidget,
      );
      expect(
        find.text(tester.l10n.pointsToNextTier('500', tester.l10n.tierGold)),
        findsOneWidget,
      );
    });

    testWidgets('shows discount badges from data', (tester) async {
      await tester.pumpSignedInApp();

      expect(find.byType(DiscountBadge), findsWidgets);
      expect(
        find.descendant(
          of: find.byType(DiscountBadge),
          matching: find.text(tester.l10n.percentOff(50)),
        ),
        findsOneWidget,
      );
    });
  });

  group('Home connectivity', () {
    testWidgets('shows the offline banner while offline', (tester) async {
      await tester.pumpSignedInApp();

      expect(find.byKey(const Key('offline-banner')), findsOneWidget);
    });

    testWidgets('hides the banner when the network returns', (tester) async {
      final connectivity = await tester.pumpSignedInApp();

      connectivity.setOnline(online: true);
      // Not pumpAndSettle: after the refresh, network images shimmer while
      // loading and never settle in a test with no network.
      await tester.pump();
      await tester.pump(AppDurations.slow);

      expect(find.byKey(const Key('offline-banner')), findsNothing);
    });

    testWidgets('pull-to-refresh offline keeps data and says so', (
      tester,
    ) async {
      await tester.pumpSignedInApp();

      await tester.fling(scrollable, const Offset(0, 400), 1000);
      await tester.pumpAndSettle();

      expect(find.text(tester.l10n.refreshFailed), findsOneWidget);
      expect(find.text(tester.l10n.seasonalSpecials), findsOneWidget);
    });
  });

  group('Home navigation', () {
    testWidgets('a product tile opens that product', (tester) async {
      await tester.pumpSignedInApp();

      await tester.tap(find.byType(ProductTile).first);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.text('Product p_mistletoe_box'), findsOneWidget);
    });
  });

  testWidgets('Popular tiles are taller than Order again tiles', (
    tester,
  ) async {
    await tester.pumpSignedInApp();
    final popularTile = find.widgetWithText(
      ProductTile,
      'Strawberry Chocolate Donuts',
    );
    await tester.scrollUntilVisible(
      popularTile,
      300,
      scrollable: find.byType(Scrollable).first,
    );

    final tile = tester.widget<ProductTile>(popularTile);
    expect(tile.shape, ProductTileShape.portrait);
    expect(
      ProductTileShape.portrait.imageHeight,
      greaterThan(ProductTileShape.square.imageHeight),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('nearby shops sit on the illustrated scenery', (tester) async {
    await tester.pumpSignedInApp();
    final block = find.byKey(const Key('nearby-shops-block'));
    await tester.scrollUntilVisible(
      find.byType(NearbyShops),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    final scenery = find.descendant(
      of: block,
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is CustomPaint && widget.painter is ShopsSceneryPainter,
      ),
    );
    expect(scenery, findsOneWidget);
  });
}
