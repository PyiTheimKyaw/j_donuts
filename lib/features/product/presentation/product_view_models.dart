import 'package:j_donuts/features/home/domain/entities/product.dart';
import 'package:j_donuts/features/home/home_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_view_models.g.dart';

@riverpod
Stream<Product?> productDetail(Ref ref, String productId) =>
    ref.watch(watchProductProvider).call(productId);

/// Per product and auto-disposed, so leaving the screen resets the count to 1
/// rather than carrying a stale quantity into the next visit.
@riverpod
class ProductQuantity extends _$ProductQuantity {
  static const int minimum = 1;
  static const int maximum = 99;

  @override
  int build(String productId) => minimum;

  void increment() {
    if (state < maximum) state = state + 1;
  }

  void decrement() {
    if (state > minimum) state = state - 1;
  }
}
