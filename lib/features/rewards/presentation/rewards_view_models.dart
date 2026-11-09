import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';
import 'package:j_donuts/features/rewards/rewards_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rewards_view_models.g.dart';

@riverpod
Stream<List<Challenge>> rewardChallenges(Ref ref) =>
    ref.watch(watchChallengesProvider).call();

@riverpod
class SelectedRewardTab extends _$SelectedRewardTab {
  @override
  ChallengeTab build() => ChallengeTab.earn;

  ChallengeTab get selected => state;

  set selected(ChallengeTab tab) => state = tab;
}
