import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/skeleton.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class ProductDetailLoading extends StatelessWidget {
  const ProductDetailLoading({super.key});

  static const double _cardHeight = 380;
  static const double _descriptionHeight = AppSpacing.xxxl * 2;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      child: Column(
        children: [
          Skeleton(height: _cardHeight, radius: AppRadii.xl),
          SizedBox(height: AppSpacing.xl),
          Skeleton(height: _descriptionHeight),
        ],
      ),
    );
  }
}

class ProductDetailMessage extends StatelessWidget {
  const ProductDetailMessage({required this.isError, this.onRetry, super.key});

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
