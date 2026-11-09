import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/features/rewards/domain/tier_ladder.dart';

Member _member({
  LoyaltyTier tier = LoyaltyTier.silver,
  int total = 680000,
  int remaining = 500,
  int start = 678800,
}) => Member(
  id: 'm',
  name: 'Hania',
  photo: const ImageRef('asset://images/member/avatar.jpg'),
  tier: tier,
  totalPoints: total,
  pointsToNextTier: remaining,
  notificationCount: 0,
  rewardCount: 0,
  tierStartPoints: start,
);

void main() {
  group('TierLadder.stepsFor', () {
    test('a Silver member sees Silver, Gold and Platinum', () {
      expect(TierLadder.stepsFor(LoyaltyTier.silver), const [
        TierStep(tier: LoyaltyTier.silver, status: TierStatus.current),
        TierStep(tier: LoyaltyTier.gold, status: TierStatus.next),
        TierStep(tier: LoyaltyTier.platinum, status: TierStatus.future),
      ]);
    });

    test('a Bronze member sees the three tiers starting at Bronze', () {
      expect(TierLadder.stepsFor(LoyaltyTier.bronze).map((s) => s.tier), [
        LoyaltyTier.bronze,
        LoyaltyTier.silver,
        LoyaltyTier.gold,
      ]);
    });

    test('at the top tier the window slides down instead of shrinking', () {
      expect(TierLadder.stepsFor(LoyaltyTier.platinum), const [
        TierStep(tier: LoyaltyTier.silver, status: TierStatus.achieved),
        TierStep(tier: LoyaltyTier.gold, status: TierStatus.achieved),
        TierStep(tier: LoyaltyTier.platinum, status: TierStatus.current),
      ]);
    });
  });

  group('Member.tierProgress', () {
    test('is the share of the current tier already covered', () {
      // 1,200 of the 1,700 points between Silver's start and Gold.
      expect(_member().tierProgress, closeTo(1200 / 1700, 1e-9));
    });

    test('is complete at the top tier', () {
      expect(_member(tier: LoyaltyTier.platinum).tierProgress, 1);
    });

    test('never leaves 0..1 for inconsistent data', () {
      expect(_member(start: 700000).tierProgress, 0);
      expect(_member(remaining: 0).tierProgress, 1);
    });
  });
}
