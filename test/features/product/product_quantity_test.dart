import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/product/presentation/product_view_models.dart';

void main() {
  late ProviderContainer container;
  const productId = 'p_coconut';

  setUp(() => container = ProviderContainer());
  tearDown(() => container.dispose());

  int quantity() => container.read(productQuantityProvider(productId));

  ProductQuantity controller() =>
      container.read(productQuantityProvider(productId).notifier);

  group('ProductQuantity', () {
    test('starts at the minimum of 1', () {
      expect(quantity(), 1);
    });

    test('never goes below 1', () {
      controller().decrement();

      expect(quantity(), 1);
    });

    test('counts up and back down', () {
      controller()
        ..increment()
        ..increment()
        ..decrement();

      expect(quantity(), 2);
    });

    test('stops at the maximum', () {
      for (var i = 0; i < ProductQuantity.maximum + 5; i++) {
        controller().increment();
      }

      expect(quantity(), ProductQuantity.maximum);
    });

    test('is tracked per product', () {
      controller().increment();

      expect(container.read(productQuantityProvider('p_glazed')), 1);
    });
  });
}
