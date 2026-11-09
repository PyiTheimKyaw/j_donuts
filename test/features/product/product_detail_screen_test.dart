import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/features/home/presentation/widgets/product_section.dart';
import 'package:j_donuts/features/product/presentation/screens/product_detail_screen.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/signed_in_app.dart';

void main() {
  final increment = find.byKey(const Key('quantity-increment'));
  final decrement = find.byKey(const Key('quantity-decrement'));
  final addToCart = find.byKey(const Key('add-to-cart'));

  Future<void> openCoconut(WidgetTester tester) =>
      tester.pumpScreen(const ProductDetailScreen(productId: 'p_coconut'));

  Finder textIn(Finder parent, String text) =>
      find.descendant(of: parent, matching: find.text(text));

  group('ProductDetailScreen content', () {
    testWidgets('shows code, name, grouped MMK price and description', (
      tester,
    ) async {
      await openCoconut(tester);

      expect(find.text('JD022123'), findsOneWidget);
      expect(find.text('Coconut Donut'), findsOneWidget);
      expect(find.byKey(const Key('product-price')), findsOneWidget);
      expect(
        tester.widget<Text>(find.byKey(const Key('product-price'))).data,
        '3,200 MMK',
      );
      expect(find.text(tester.l10n.whatsThis), findsOneWidget);
      expect(find.textContaining('Enjoy our scrumptious donuts'), findsOne);
    });

    testWidgets('fades the description lighter towards the bottom', (
      tester,
    ) async {
      await openCoconut(tester);

      final fade = find.byKey(const Key('product-description-fade'));
      expect(fade, findsOneWidget);
      expect(
        find.descendant(
          of: fade,
          matching: find.textContaining('Enjoy our scrumptious donuts'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('shows the New badge from data', (tester) async {
      await openCoconut(tester);

      expect(find.byKey(const Key('product-new-badge')), findsOneWidget);
    });

    testWidgets('has no New badge for a product that is not new', (
      tester,
    ) async {
      await tester.pumpScreen(const ProductDetailScreen(productId: 'p_glazed'));

      expect(find.byKey(const Key('product-new-badge')), findsNothing);
    });

    testWidgets('explains when the product does not exist', (tester) async {
      await tester.pumpScreen(const ProductDetailScreen(productId: 'missing'));

      expect(find.text(tester.l10n.productNotFound), findsOneWidget);
    });
  });

  group('ProductDetailScreen quantity', () {
    testWidgets('starts at 1 with decrease disabled', (tester) async {
      await openCoconut(tester);

      expect(find.text('1'), findsOneWidget);
      await tester.tap(decrement);
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('the total follows the quantity', (tester) async {
      await openCoconut(tester);

      await tester.tap(increment);
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
      expect(textIn(addToCart, '6,400 MMK'), findsOneWidget);

      await tester.tap(decrement);
      await tester.pumpAndSettle();
      expect(textIn(addToCart, '3,200 MMK'), findsOneWidget);
    });
  });

  group('ProductDetailScreen add to cart', () {
    testWidgets('confirms the quantity, then returns to the total', (
      tester,
    ) async {
      await openCoconut(tester);
      await tester.tap(increment);
      await tester.pumpAndSettle();

      await tester.tap(addToCart);
      await tester.pumpAndSettle();

      expect(find.text(tester.l10n.addedToCart(2)), findsOneWidget);
      expect(
        textIn(addToCart, tester.l10n.addedShort.toUpperCase()),
        findsOneWidget,
      );

      await tester.pump(AppDurations.confirmationHold);
      await tester.pumpAndSettle();
      expect(textIn(addToCart, '6,400 MMK'), findsOneWidget);
    });
  });

  testWidgets('a Home tile opens the detail for that product', (tester) async {
    await tester.pumpSignedInApp();

    await tester.tap(find.byType(ProductTile).first);
    await tester.pumpAndSettle();

    expect(find.byType(ProductDetailScreen), findsOneWidget);
    expect(find.text('Mistletoe Romance box'), findsOneWidget);
  });
}
