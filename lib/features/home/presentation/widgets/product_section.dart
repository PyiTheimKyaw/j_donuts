import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/app_image.dart';
import 'package:j_donuts/core/widgets/skeleton.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';
import 'package:j_donuts/features/home/presentation/home_labels.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Seasonal boxes are photographed wide; Popular uses tall cards to give its
/// bestsellers more presence; Order again stays compact, as in the design.
enum ProductTileShape {
  landscape(imageWidth: 240, imageHeight: 160),
  portrait(imageWidth: 150, imageHeight: 200),
  square(imageWidth: 150, imageHeight: 150);

  ProductTileShape({required this.imageWidth, required this.imageHeight});

  final double imageWidth;
  final double imageHeight;

  static ProductTileShape forSection(SectionKind kind) => switch (kind) {
    SectionKind.seasonal => landscape,
    SectionKind.popular => portrait,
    SectionKind.orderAgain => square,
  };

  /// Image, gap and a two-line name.
  double get rowHeight => imageHeight + AppSpacing.sm + _nameBlockHeight;

  static const double _nameBlockHeight = 48;
}

typedef ProductTapCallback = void Function(
  Product product, {
  required String heroTag,
});

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.title, this.onSeeAll, super.key});

  final String title;
  final VoidCallback? onSeeAll;

  static const double _arrowSize = 28;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        0,
        AppSpacing.gutter - AppSpacing.sm,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(child: Text(title, style: AppTypography.title)),
          IconButton(
            tooltip: l10n.openSection(title),
            onPressed: onSeeAll,
            icon: Container(
              width: _arrowSize,
              height: _arrowSize,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chevron_right_rounded, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductRow extends StatelessWidget {
  const ProductRow({
    required this.section,
    required this.onProductTap,
    super.key,
  });

  final HomeSection section;
  final ProductTapCallback onProductTap;

  @override
  Widget build(BuildContext context) {
    final shape = ProductTileShape.forSection(section.kind);

    return SizedBox(
      height: shape.rowHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
        itemCount: section.products.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, index) {
          final product = section.products[index];
          final heroTag = productHeroTag(
            sectionId: section.id,
            productId: product.id,
          );
          return ProductTile(
            product: product,
            shape: shape,
            heroTag: heroTag,
            onTap: () => onProductTap(product, heroTag: heroTag),
          );
        },
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    required this.product,
    required this.shape,
    required this.heroTag,
    required this.onTap,
    super.key,
  });

  final Product product;
  final ProductTileShape shape;
  final String heroTag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: product.name,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: shape.imageWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: shape.imageWidth,
                height: shape.imageHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: heroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadii.lg),
                        child: ColoredBox(
                          color: AppColors.surface,
                          child: AppImage(product.image),
                        ),
                      ),
                    ),
                    if (product.hasDiscount)
                      Positioned(
                        right: AppSpacing.sm,
                        bottom: AppSpacing.sm,
                        child: DiscountBadge(percent: product.discountPercent!),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                product.name,
                style: AppTypography.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({required this.percent, super.key});

  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.onPrimary),
      ),
      child: Text(
        AppLocalizations.of(context).percentOff(percent),
        style: AppTypography.caption.copyWith(
          color: AppColors.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ProductRowSkeleton extends StatelessWidget {
  const ProductRowSkeleton({required this.shape, super.key});

  final ProductTileShape shape;

  static const int _placeholderCount = 3;
  static const double _nameLineHeight = 16;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: shape.rowHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
        itemCount: _placeholderCount,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(
              width: shape.imageWidth,
              height: shape.imageHeight,
              radius: AppRadii.lg,
            ),
            const SizedBox(height: AppSpacing.sm),
            Skeleton(width: shape.imageWidth * 0.7, height: _nameLineHeight),
          ],
        ),
      ),
    );
  }
}
