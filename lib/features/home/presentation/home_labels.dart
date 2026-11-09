import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

extension LoyaltyTierLabel on LoyaltyTier {
  String label(AppLocalizations l10n) => switch (this) {
    LoyaltyTier.bronze => l10n.tierBronze,
    LoyaltyTier.silver => l10n.tierSilver,
    LoyaltyTier.gold => l10n.tierGold,
    LoyaltyTier.platinum => l10n.tierPlatinum,
  };
}

extension SectionKindLabel on SectionKind {
  String title(AppLocalizations l10n) => switch (this) {
    SectionKind.seasonal => l10n.seasonalSpecials,
    SectionKind.popular => l10n.popular,
    SectionKind.orderAgain => l10n.orderAgain,
  };
}

/// One product can sit in several sections, and Flutter rejects two heroes
/// with the same tag on one page, so the tag includes the section.
String productHeroTag({required String sectionId, required String productId}) =>
    'product-image-$sectionId-$productId';
