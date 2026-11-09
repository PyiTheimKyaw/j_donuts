import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/app_image.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/core/widgets/skeleton.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';
import 'package:j_donuts/features/home/presentation/widgets/product_section.dart';
import 'package:j_donuts/features/product/presentation/money_labels.dart';
import 'package:j_donuts/features/product/presentation/product_view_models.dart';
import 'package:j_donuts/features/product/presentation/widgets/add_to_cart_button.dart';
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
        AsyncValue(hasValue: true) => const _Message(isError: false),
        AsyncError() => _Message(
          isError: true,
          onRetry: () => ref.invalidate(productDetailProvider(productId)),
        ),
        _ => const _LoadingCard(),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProductCard(
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
                const SizedBox(height: AppSpacing.xl),
                EntranceAnimation(
                  index: 2,
                  child: _Description(text: product.description),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
        SafeArea(
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
              onAdded: () => _confirmAdded(context, quantity),
            ),
          ),
        ),
      ],
    );
  }

  void _confirmAdded(BuildContext context, int quantity) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).addedToCart(quantity)),
        ),
      );
  }
}

/// The stepper straddles the card's bottom edge, as in the design, so it is
/// laid out in a Stack with the card padded to leave room for its top half.
class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.heroTag,
    required this.stepper,
  });

  final Product product;
  final String? heroTag;
  final Widget stepper;

  static const double _imageHeight = 240;
  static const double _stepperOverlap = 32;

  @override
  Widget build(BuildContext context) {
    final image = AppImage(product.image, fit: BoxFit.contain);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: _stepperOverlap),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            _stepperOverlap + AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.xl),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EntranceAnimation(child: _Heading(product: product)),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: _imageHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  child: heroTag == null
                      ? image
                      : Hero(tag: heroTag!, child: image),
                ),
              ),
            ],
          ),
        ),
        EntranceAnimation(
          index: 1,
          curve: AppCurves.overshoot,
          beginScale: AppMotionScales.popFrom,
          offset: Offset.zero,
          child: stepper,
        ),
      ],
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.code,
                style: AppTypography.caption.copyWith(
                  color: AppColors.inkTertiary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(product.name, style: AppTypography.headline),
              const SizedBox(height: AppSpacing.xs),
              Text(
                formatMmk(context, product.priceMmk),
                key: const Key('product-price'),
                style: AppTypography.subtitle,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (product.isNew) _NewBadge(label: l10n.newBadge),
            if (product.hasDiscount) ...[
              const SizedBox(height: AppSpacing.xs),
              DiscountBadge(percent: product.discountPercent!),
            ],
          ],
        ),
      ],
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('product-new-badge'),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + AppSpacing.xxs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: AppColors.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.text});

  final String text;

  static const double _labelWidth = 72;
  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _labelWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.help_rounded,
                  color: AppColors.success,
                  size: _iconSize,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.whatsThis, style: AppTypography.label),
              ],
            ),
          ),
          const VerticalDivider(color: AppColors.divider, width: AppSpacing.xl),
          Expanded(
            child: ShaderMask(
              key: const Key('product-description-fade'),
              // srcIn repaints only the glyphs with the gradient, so the text
              // lightens line by line; an overlay would tint the gaps too.
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.ink,
                  AppColors.inkSecondary,
                  AppColors.inkTertiary,
                ],
              ).createShader(bounds),
              child: Text(text, style: AppTypography.bodySmall),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  static const double _cardHeight = 380;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      child: Column(
        children: [
          Skeleton(height: _cardHeight, radius: AppRadii.xl),
          SizedBox(height: AppSpacing.xl),
          Skeleton(height: AppSpacing.xxxl * 2),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.isError, this.onRetry});

  final bool isError;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isError ? Icons.cloud_off_rounded : Icons.search_off_rounded,
              size: AppSpacing.xxxl,
              color: AppColors.inkTertiary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              isError ? l10n.errorGeneric : l10n.productNotFound,
              style: AppTypography.body,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null)
              TextButton(onPressed: onRetry, child: Text(l10n.retry)),
          ],
        ),
      ),
    );
  }
}
