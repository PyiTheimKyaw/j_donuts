import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';
import 'package:j_donuts/features/product/presentation/money_labels.dart';
import 'package:j_donuts/features/product/presentation/product_view_models.dart';
import 'package:j_donuts/features/product/presentation/widgets/add_to_cart_button.dart';
import 'package:j_donuts/features/product/presentation/widgets/product_detail_parts.dart';
import 'package:j_donuts/features/product/presentation/widgets/product_detail_states.dart';
import 'package:j_donuts/features/product/presentation/widgets/quantity_stepper.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// [heroTag] is the tag of the tile that was tapped. A product can appear in
/// several Home sections, so the tag comes from the caller rather than being
/// derived from the id; without one (e.g. a deep link) there is no flight.
class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({required this.productId, this.heroTag, super.key});

  final String productId;
  final String? heroTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailProvider(productId));

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.ink),
          tooltip: AppLocalizations.of(context).back,
          onPressed: () => context.pop(),
        ),
      ),
      body: switch (product) {
        AsyncValue(hasValue: true, value: final Product product) =>
          _ProductContent(product: product, heroTag: heroTag),
        AsyncValue(hasValue: true) => const ProductDetailMessage(
          isError: false,
        ),
        AsyncError() => ProductDetailMessage(
          isError: true,
          onRetry: () => ref.invalidate(productDetailProvider(productId)),
        ),
        _ => const ProductDetailLoading(),
      },
    );
  }
}

class _ProductContent extends ConsumerWidget {
  const _ProductContent({required this.product, required this.heroTag});

  final Product product;
  final String? heroTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(productQuantityProvider(product.id));
    final controller = ref.read(productQuantityProvider(product.id).notifier);

    return Column(
      children: [
        Expanded(
          child: _ScrollableDetails(
            product: product,
            heroTag: heroTag,
            stepper: QuantityStepper(
              value: quantity,
              onDecrement: quantity > ProductQuantity.minimum
                  ? controller.decrement
                  : null,
              onIncrement: quantity < ProductQuantity.maximum
                  ? controller.increment
                  : null,
            ),
          ),
        ),
        _AddToCartBar(product: product, quantity: quantity),
      ],
    );
  }
}

class _ScrollableDetails extends StatelessWidget {
  const _ScrollableDetails({
    required this.product,
    required this.heroTag,
    required this.stepper,
  });

  final Product product;
  final String? heroTag;
  final Widget stepper;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductDetailCard(
            product: product,
            heroTag: heroTag,
            stepper: stepper,
          ),
          const SizedBox(height: AppSpacing.xl),
          EntranceAnimation(
            index: 2,
            child: ProductDescription(text: product.description),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _AddToCartBar extends StatelessWidget {
  const _AddToCartBar({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.sm,
        AppSpacing.gutter,
        AppSpacing.lg,
      ),
      child: EntranceAnimation(
        index: 3,
        child: AddToCartButton(
          totalLabel: formatMmk(context, product.priceMmk * quantity),
          onAdded: () => _confirmAdded(context),
        ),
      ),
    );
  }

  void _confirmAdded(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).addedToCart(quantity)),
        ),
      );
  }
}
