import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/app_image.dart';
import 'package:j_donuts/core/widgets/skeleton.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Display only: the brief asks for no action on Explore now or Order online.
class NearbyShops extends StatelessWidget {
  const NearbyShops({required this.shops, super.key});

  final List<Shop> shops;

  static const double cardWidth = 260;
  static const double imageHeight = 130;
  static const double listHeight = 250;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
        itemCount: shops.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, index) => _ShopCard(shop: shops[index]),
      ),
    );
  }
}

class NearbyShopsHeader extends StatelessWidget {
  const NearbyShopsHeader({required this.shopCount, super.key});

  final int? shopCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final count = shopCount;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.xl,
        AppSpacing.gutter,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (count != null)
            Text(
              l10n.nearbyShopsTitle(count),
              style: AppTypography.title.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.primary,
              minimumSize: const Size(0, AppSizes.minTapTarget - AppSpacing.sm),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            ),
            child: Text(l10n.exploreNow.toUpperCase()),
          ),
        ],
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.shop});

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: NearbyShops.cardWidth,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.md),
            child: AppImage(
              shop.image,
              width: double.infinity,
              height: NearbyShops.imageHeight,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            shop.name,
            style: AppTypography.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Expanded(
            child: Text(
              shop.address,
              style: AppTypography.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            l10n.orderOnline,
            style: AppTypography.label.copyWith(color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}

class NearbyShopsSkeleton extends StatelessWidget {
  const NearbyShopsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: NearbyShops.listHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
        itemCount: 2,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (_, _) =>
            const Skeleton(width: NearbyShops.cardWidth, radius: AppRadii.lg),
      ),
    );
  }
}
