import 'package:equatable/equatable.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';

enum LoyaltyTier { bronze, silver, gold, platinum }

/// The single loyalty record behind both Home and Rewards. The mock-ups
/// disagree (Bronze/1,290 vs Silver/500); one record means they cannot.
final class Member extends Equatable {
  const Member({
    required this.id,
    required this.name,
    required this.photo,
    required this.tier,
    required this.totalPoints,
    required this.pointsToNextTier,
    required this.notificationCount,
    required this.rewardCount,
    this.tierStartPoints = 0,
  });

  final String id;
  final String name;
  final ImageRef photo;
  final LoyaltyTier tier;
  final int totalPoints;
  final int pointsToNextTier;
  final int tierStartPoints;
  final int notificationCount;
  final int rewardCount;

  /// `null` at the top tier.
  LoyaltyTier? get nextTier {
    final next = tier.index + 1;
    return next < LoyaltyTier.values.length ? LoyaltyTier.values[next] : null;
  }

  /// 0..1 through the current tier; 1 at the top tier. Drives the points ring
  /// and the ladder line, so both always agree.
  double get tierProgress {
    if (nextTier == null) return 1;
    final covered = totalPoints - tierStartPoints;
    if (covered <= 0) return 0;
    final span = covered + pointsToNextTier;
    return (covered / span).clamp(0, 1);
  }

  @override
  List<Object?> get props => [
    id,
    name,
    photo,
    tier,
    totalPoints,
    pointsToNextTier,
    tierStartPoints,
    notificationCount,
    rewardCount,
  ];
}
