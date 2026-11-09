import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/app_image.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';
import 'package:j_donuts/features/home/presentation/widgets/product_section.dart';
import 'package:j_donuts/features/product/presentation/money_labels.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// The stepper straddles the card's bottom edge, as in the design, so it is
/// laid out in a Stack with the card padded to leave room for its top half.
class ProductDetailCard extends StatelessWidget {
  const ProductDetailCard({
    required this.product,
    required this.heroTag,
    required this.stepper,
    super.key,
  });

  final Product product;
  final String? heroTag;
  final Widget stepper;

  static const double _stepperOverlap = 32;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        _CardSurface(product: product, heroTag: heroTag),
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

class _CardSurface extends StatelessWidget {
  const _CardSurface({required this.product, required this.heroTag});

  final Product product;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ProductDetailCard._stepperOverlap),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        ProductDetailCard._stepperOverlap + AppSpacing.lg,
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
          _ProductImage(product: product, heroTag: heroTag),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product, required this.heroTag});

  final Product product;
  final String? heroTag;

  static const double _height = 240;

  @override
  Widget build(BuildContext context) {
    final image = AppImage(product.image, fit: BoxFit.contain);
    final tag = heroTag;

    return SizedBox(
      height: _height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: tag == null ? image : Hero(tag: tag, child: image),
      ),
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
        Expanded(child: _HeadingText(product: product)),
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

class _HeadingText extends StatelessWidget {
  const _HeadingText({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.code,
          style: AppTypography.caption.copyWith(color: AppColors.inkTertiary),
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

class ProductDescription extends StatelessWidget {
  const ProductDescription({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _DescriptionLabel(),
          const VerticalDivider(color: AppColors.divider, width: AppSpacing.xl),
          Expanded(child: _FadingText(text: text)),
        ],
      ),
    );
  }
}

class _DescriptionLabel extends StatelessWidget {
  const _DescriptionLabel();

  static const double _width = 72;
  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.help_rounded,
            color: AppColors.success,
            size: _iconSize,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            AppLocalizations.of(context).whatsThis,
            style: AppTypography.label,
          ),
        ],
      ),
    );
  }
}

class _FadingText extends StatelessWidget {
  const _FadingText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      key: const Key('product-description-fade'),
      // srcIn repaints only the glyphs with the gradient, so the text
      // lightens line by line; an overlay would tint the gaps too.
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.ink, AppColors.inkSecondary, AppColors.inkTertiary],
      ).createShader(bounds),
      child: Text(text, style: AppTypography.bodySmall),
    );
  }
}
