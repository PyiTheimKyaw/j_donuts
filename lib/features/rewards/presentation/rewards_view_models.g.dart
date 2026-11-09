// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards_view_models.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rewardChallenges)
final rewardChallengesProvider = RewardChallengesProvider._();

final class RewardChallengesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Challenge>>,
          List<Challenge>,
          Stream<List<Challenge>>
        >
    with $FutureModifier<List<Challenge>>, $StreamProvider<List<Challenge>> {
  RewardChallengesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rewardChallengesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rewardChallengesHash();

  @$internal
  @override
  $StreamProviderElement<List<Challenge>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Challenge>> create(Ref ref) {
    return rewardChallenges(ref);
  }
}

String _$rewardChallengesHash() => r'3389683898c095a4a917a55825ae317a682aa834';

@ProviderFor(SelectedRewardTab)
final selectedRewardTabProvider = SelectedRewardTabProvider._();

final class SelectedRewardTabProvider
    extends $NotifierProvider<SelectedRewardTab, ChallengeTab> {
  SelectedRewardTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedRewardTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedRewardTabHash();

  @$internal
  @override
  SelectedRewardTab create() => SelectedRewardTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChallengeTab value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChallengeTab>(value),
    );
  }
}

String _$selectedRewardTabHash() => r'8b92ec0a9a64a2c27691a7c243fa999b2b4447ce';

abstract class _$SelectedRewardTab extends $Notifier<ChallengeTab> {
  ChallengeTab build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ChallengeTab, ChallengeTab>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChallengeTab, ChallengeTab>,
              ChallengeTab,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
