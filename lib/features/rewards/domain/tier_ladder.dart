import 'package:equatable/equatable.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';

enum TierStatus { achieved, current, next, future }

final class TierStep extends Equatable {
  const TierStep({required this.tier, required this.status});

  final LoyaltyTier tier;
  final TierStatus status;

  @override
  List<Object?> get props => [tier, status];
}

/// The ladder always shows three rungs starting at the member's tier, so a
/// Silver member sees Silver, Gold, Platinum. Near the top the window slides
/// down instead of shrinking, keeping three rungs on screen.
abstract final class TierLadder {
  static const int visibleSteps = 3;

  static List<TierStep> stepsFor(LoyaltyTier current) {
    const tiers = LoyaltyTier.values;
    final lastStart = tiers.length - visibleSteps;
    final start = current.index.clamp(0, lastStart);
    return [
      for (final tier in tiers.skip(start).take(visibleSteps))
        TierStep(tier: tier, status: _statusOf(tier, current)),
    ];
  }

  static TierStatus _statusOf(LoyaltyTier tier, LoyaltyTier current) {
    if (tier.index < current.index) return TierStatus.achieved;
    if (tier == current) return TierStatus.current;
    if (tier.index == current.index + 1) return TierStatus.next;
    return TierStatus.future;
  }
}
