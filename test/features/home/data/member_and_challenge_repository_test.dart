import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/home/data/datasources/member_local_data_source.dart';
import 'package:j_donuts/features/home/data/repositories/member_repository_impl.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/features/rewards/data/datasources/challenge_local_data_source.dart';
import 'package:j_donuts/features/rewards/data/repositories/challenge_repository_impl.dart';
import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';

import '../../../helpers/catalog_fixtures.dart';

void main() {
  late CatalogHarness harness;

  setUp(() => harness = CatalogHarness());
  tearDown(() => harness.dispose());

  test(
    'one member record carries the Rewards numbers for every screen',
    () async {
      final member = await MemberRepositoryImpl(
        local: MemberLocalDataSource(harness.database),
        seed: harness.seed,
      ).watchMember().first;

      expect(member?.tier, LoyaltyTier.silver);
      expect(member?.nextTier, LoyaltyTier.gold);
      expect(member?.totalPoints, 680000);
      expect(member?.pointsToNextTier, 500);
      expect(member?.rewardCount, 3);
    },
  );

  test(
    'challenges arrive in seed order with progress for the artwork',
    () async {
      final challenges = await ChallengeRepositoryImpl(
        local: ChallengeLocalDataSource(harness.database),
        seed: harness.seed,
      ).watchChallenges().first;

      final earn = challenges.where((c) => c.tab == ChallengeTab.earn).toList();
      expect(earn.map((c) => '${c.progress}/${c.goal}'), [
        '4/4',
        '1/4',
        '9/12',
      ]);
      expect(earn.first.isComplete, isTrue);
      expect(earn.last.artwork, ChallengeArtwork.coffee);
      expect(earn.last.fraction, closeTo(0.75, 1e-9));
    },
  );

  test('Member.nextTier is null at the top tier', () {
    const member = Member(
      id: 'm',
      name: 'n',
      photo: ImageRef('asset://images/member/avatar.jpg'),
      tier: LoyaltyTier.platinum,
      totalPoints: 0,
      pointsToNextTier: 0,
      notificationCount: 0,
      rewardCount: 0,
    );

    expect(member.nextTier, isNull);
  });
}
