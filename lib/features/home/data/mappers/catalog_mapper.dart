import 'package:drift/drift.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/features/home/data/dto/catalog_dto.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';
import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';

/// Rows to entities and DTOs to companions. Unknown enum strings fall back to a
/// sensible default rather than throwing, so a newer server cannot crash an
/// older app.
abstract final class CatalogMapper {
  static ImageRef image(String url, String? fallback) =>
      ImageRef(url, fallbackAsset: fallback);

  /// Seed rows point at bundled assets, so the seed URL doubles as fallback.
  static String? seedFallback(String url) =>
      url.startsWith(ImageRef.assetScheme)
      ? url.substring(ImageRef.assetScheme.length)
      : null;

  static Product product(ProductRow row) => Product(
    id: row.id,
    code: row.code,
    name: row.name,
    priceMmk: row.priceMmk,
    image: image(row.imageUrl, row.assetFallback),
    description: row.description,
    isNew: row.isNew,
    discountPercent: row.discountPercent,
  );

  static PromoBanner banner(BannerRow row) => PromoBanner(
    id: row.id,
    title: row.title,
    badge: row.badge,
    style: _byName(BannerStyle.values, row.style, BannerStyle.purple),
    image: image(row.imageUrl, row.assetFallback),
  );

  static Shop shop(ShopRow row) => Shop(
    id: row.id,
    name: row.name,
    address: row.address,
    image: image(row.imageUrl, row.assetFallback),
  );

  static SectionKind sectionKind(String value) =>
      _byName(SectionKind.values, value, SectionKind.popular);

  static Member member(MemberRow row) => Member(
    id: row.id,
    name: row.name,
    photo: image(row.photoUrl, seedFallback(row.photoUrl)),
    tier: _byName(LoyaltyTier.values, row.tier, LoyaltyTier.bronze),
    totalPoints: row.totalPoints,
    pointsToNextTier: row.pointsToNextTier,
    notificationCount: row.notificationCount,
    rewardCount: row.rewardCount,
  );

  static Challenge challenge(ChallengeRow row) => Challenge(
    id: row.id,
    title: row.title,
    artwork: _byName(
      ChallengeArtwork.values,
      row.artwork,
      ChallengeArtwork.donut,
    ),
    image: image(row.imageUrl, seedFallback(row.imageUrl)),
    progress: row.progress,
    goal: row.goal,
    rewardPoints: row.rewardPoints,
    tab: _byName(ChallengeTab.values, row.tab, ChallengeTab.earn),
  );

  static ProductsCompanion productCompanion(
    ProductDto dto, {
    required bool fromSeed,
  }) => ProductsCompanion(
    id: Value(dto.id),
    code: Value(dto.code),
    name: Value(dto.name),
    priceMmk: Value(dto.priceMmk),
    isNew: Value(dto.isNew),
    discountPercent: Value(dto.discountPercent),
    imageUrl: Value(dto.imageUrl),
    description: Value(dto.description),
    assetFallback: fromSeed
        ? Value(seedFallback(dto.imageUrl))
        : const Value.absent(),
  );

  static BannersCompanion bannerCompanion(
    BannerDto dto,
    int sortOrder, {
    required bool fromSeed,
  }) => BannersCompanion(
    id: Value(dto.id),
    title: Value(dto.title),
    badge: Value(dto.badge),
    style: Value(dto.style),
    imageUrl: Value(dto.imageUrl),
    sortOrder: Value(sortOrder),
    assetFallback: fromSeed
        ? Value(seedFallback(dto.imageUrl))
        : const Value.absent(),
  );

  static ShopsCompanion shopCompanion(
    ShopDto dto,
    int sortOrder, {
    required bool fromSeed,
  }) => ShopsCompanion(
    id: Value(dto.id),
    name: Value(dto.name),
    address: Value(dto.address),
    imageUrl: Value(dto.imageUrl),
    sortOrder: Value(sortOrder),
    assetFallback: fromSeed
        ? Value(seedFallback(dto.imageUrl))
        : const Value.absent(),
  );

  static MembersCompanion memberCompanion(MemberDto dto) =>
      MembersCompanion.insert(
        id: dto.id,
        name: dto.name,
        photoUrl: dto.photoUrl,
        tier: dto.tier,
        totalPoints: dto.totalPoints,
        pointsToNextTier: dto.pointsToNextTier,
        notificationCount: dto.notificationCount,
        rewardCount: dto.rewardCount,
      );

  static ChallengesCompanion challengeCompanion(
    ChallengeDto dto,
    int sortOrder,
  ) => ChallengesCompanion.insert(
    id: dto.id,
    title: dto.title,
    artwork: dto.artwork,
    imageUrl: dto.imageUrl,
    progress: dto.progress,
    goal: dto.goal,
    rewardPoints: dto.rewardPoints,
    tab: dto.tab,
    sortOrder: sortOrder,
  );

  static T _byName<T extends Enum>(List<T> values, String name, T fallback) {
    for (final value in values) {
      if (value.name == name) return value;
    }
    return fallback;
  }
}
