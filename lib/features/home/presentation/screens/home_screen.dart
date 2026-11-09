import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/core/network/network_providers.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/core/widgets/offline_banner.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';
import 'package:j_donuts/features/home/presentation/catalog_sync_controller.dart';
import 'package:j_donuts/features/home/presentation/home_labels.dart';
import 'package:j_donuts/features/home/presentation/home_view_models.dart';
import 'package:j_donuts/features/home/presentation/widgets/banner_carousel.dart';
import 'package:j_donuts/features/home/presentation/widgets/member_header.dart';
import 'package:j_donuts/features/home/presentation/widgets/nearby_shops.dart';
import 'package:j_donuts/features/home/presentation/widgets/product_section.dart';
import 'package:j_donuts/features/home/presentation/widgets/section_state.dart';
import 'package:j_donuts/features/home/presentation/widgets/shops_scenery.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref
        .read(catalogSyncControllerProvider.notifier)
        .refresh();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(result.isSuccess ? l10n.refreshed : l10n.refreshFailed),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOnlineProvider).value == false;
    // The shell's Scaffold uses extendBody, so its bottom padding already
    // includes the floating nav bar; adding the bar again leaves a gap.
    final navClearance = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () => _refresh(context, ref),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: OfflineBanner(isOffline: isOffline)),
            const SliverToBoxAdapter(child: _HeaderBlock()),
            const SliverToBoxAdapter(child: _SectionsBlock()),
            SliverToBoxAdapter(child: _ShopsBlock(navClearance: navClearance)),
          ],
        ),
      ),
    );
  }
}

void _showComingSoon(BuildContext context, String feature) {
  final l10n = AppLocalizations.of(context);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(l10n.comingSoon(feature))));
}

class _HeaderBlock extends ConsumerWidget {
  const _HeaderBlock();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(currentMemberProvider);
    final greeting = ref.watch(greetingNameProvider).value;
    final banners = ref.watch(homeBannersProvider);
    final l10n = AppLocalizations.of(context);

    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.homeHeader),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.lg,
            bottom: AppSpacing.xl,
          ),
          child: Column(
            children: [
              EntranceAnimation(
                child: SectionState(
                  value: member,
                  skeleton: const MemberHeaderSkeleton(),
                  isEmpty: (value) => value == null,
                  onRetry: () => ref.invalidate(currentMemberProvider),
                  builder: (value) => MemberHeader(
                    member: value!,
                    displayName: greeting ?? value.name,
                    onNotificationsTap: () =>
                        _showComingSoon(context, l10n.notifications),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              EntranceAnimation(
                index: 1,
                gap: AppDurations.sectionStaggerGap,
                child: SectionState(
                  value: banners,
                  skeleton: const BannerCarouselSkeleton(),
                  isEmpty: (value) => value.isEmpty,
                  onRetry: () => ref.invalidate(homeBannersProvider),
                  builder: (value) => BannerCarousel(banners: value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionsBlock extends ConsumerWidget {
  const _SectionsBlock();

  static const List<SectionKind> _placeholderKinds = SectionKind.values;

  void _openProduct(BuildContext context, Product product, String heroTag) =>
      unawaited(
        context.push(AppRoutes.productPath(product.id), extra: heroTag),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(homeSectionsProvider);

    return SectionState(
      value: sections,
      onRetry: () => ref.invalidate(homeSectionsProvider),
      isEmpty: (value) => value.isEmpty,
      skeleton: Column(
        children: [
          for (final kind in _placeholderKinds)
            _SectionFrame(
              title: kind.title(AppLocalizations.of(context)),
              child: ProductRowSkeleton(
                shape: ProductTileShape.forSection(kind),
              ),
            ),
        ],
      ),
      builder: (value) => Column(
        children: [
          for (final (index, section) in value.indexed)
            EntranceAnimation(
              index: index + 2,
              gap: AppDurations.sectionStaggerGap,
              child: _SectionFrame(
                title: section.kind.title(AppLocalizations.of(context)),
                child: SectionState(
                  value: AsyncData(section),
                  onRetry: () => ref.invalidate(homeSectionsProvider),
                  isEmpty: (value) => value.products.isEmpty,
                  skeleton: const SizedBox.shrink(),
                  builder: (value) => ProductRow(
                    section: value,
                    onProductTap: (product, {required heroTag}) =>
                        _openProduct(context, product, heroTag),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            title: title,
            onSeeAll: () => _showComingSoon(context, title),
          ),
          child,
        ],
      ),
    );
  }
}

/// Runs to the bottom of the scroll view and under the floating nav, so the
/// painted grass meets the pink band instead of stopping above the bar.
class _ShopsBlock extends ConsumerWidget {
  const _ShopsBlock({required this.navClearance});

  final double navClearance;

  /// Cards stand on the grass: it starts this far above the cards' bottom.
  static const double _cardsOnGrass = 24;
  static const double _gapAboveNav = AppSpacing.xl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shops = ref.watch(nearbyShopsProvider);

    return Container(
      key: const Key('nearby-shops-block'),
      margin: const EdgeInsets.only(top: AppSpacing.xxl),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xl)),
      ),
      child: CustomPaint(
        painter: ShopsSceneryPainter(
          groundHeight: navClearance + _gapAboveNav + _cardsOnGrass,
          sproutLine: navClearance + _gapAboveNav * 0.4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NearbyShopsHeader(shopCount: shops.value?.length),
            SectionState(
              value: shops,
              skeleton: const NearbyShopsSkeleton(),
              isEmpty: (value) => value.isEmpty,
              onRetry: () => ref.invalidate(nearbyShopsProvider),
              builder: (value) => NearbyShops(shops: value),
            ),
            SizedBox(height: navClearance + _gapAboveNav),
          ],
        ),
      ),
    );
  }
}
