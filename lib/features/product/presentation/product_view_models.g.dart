// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_view_models.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productDetail)
final productDetailProvider = ProductDetailFamily._();

final class ProductDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Product?>, Product?, Stream<Product?>>
    with $FutureModifier<Product?>, $StreamProvider<Product?> {
  ProductDetailProvider._({
    required ProductDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'productDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDetailHash();

  @override
  String toString() {
    return r'productDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Product?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Product?> create(Ref ref) {
    final argument = this.argument as String;
    return productDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDetailHash() => r'e89b1eaf769f26ce8888c8654c21cc3f779869a4';

final class ProductDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Product?>, String> {
  ProductDetailFamily._()
    : super(
        retry: null,
        name: r'productDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductDetailProvider call(String productId) =>
      ProductDetailProvider._(argument: productId, from: this);

  @override
  String toString() => r'productDetailProvider';
}

/// Per product and auto-disposed, so leaving the screen resets the count to 1
/// rather than carrying a stale quantity into the next visit.

@ProviderFor(ProductQuantity)
final productQuantityProvider = ProductQuantityFamily._();

/// Per product and auto-disposed, so leaving the screen resets the count to 1
/// rather than carrying a stale quantity into the next visit.
final class ProductQuantityProvider
    extends $NotifierProvider<ProductQuantity, int> {
  /// Per product and auto-disposed, so leaving the screen resets the count to 1
  /// rather than carrying a stale quantity into the next visit.
  ProductQuantityProvider._({
    required ProductQuantityFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'productQuantityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productQuantityHash();

  @override
  String toString() {
    return r'productQuantityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductQuantity create() => ProductQuantity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProductQuantityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productQuantityHash() => r'fcfefeb99b49f79a58f2541fb84a412084fc193a';

/// Per product and auto-disposed, so leaving the screen resets the count to 1
/// rather than carrying a stale quantity into the next visit.

final class ProductQuantityFamily extends $Family
    with $ClassFamilyOverride<ProductQuantity, int, int, int, String> {
  ProductQuantityFamily._()
    : super(
        retry: null,
        name: r'productQuantityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Per product and auto-disposed, so leaving the screen resets the count to 1
  /// rather than carrying a stale quantity into the next visit.

  ProductQuantityProvider call(String productId) =>
      ProductQuantityProvider._(argument: productId, from: this);

  @override
  String toString() => r'productQuantityProvider';
}

/// Per product and auto-disposed, so leaving the screen resets the count to 1
/// rather than carrying a stale quantity into the next visit.

abstract class _$ProductQuantity extends $Notifier<int> {
  late final _$args = ref.$arg as String;
  String get productId => _$args;

  int build(String productId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
