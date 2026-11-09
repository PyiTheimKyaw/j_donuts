// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(challengeRepository)
final challengeRepositoryProvider = ChallengeRepositoryProvider._();

final class ChallengeRepositoryProvider
    extends
        $FunctionalProvider<
          ChallengeRepository,
          ChallengeRepository,
          ChallengeRepository
        >
    with $Provider<ChallengeRepository> {
  ChallengeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'challengeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$challengeRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChallengeRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChallengeRepository create(Ref ref) {
    return challengeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChallengeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChallengeRepository>(value),
    );
  }
}

String _$challengeRepositoryHash() =>
    r'89703fbb0835098cc38017dc6a14f24f945b7a5a';

@ProviderFor(watchChallenges)
final watchChallengesProvider = WatchChallengesProvider._();

final class WatchChallengesProvider
    extends
        $FunctionalProvider<WatchChallenges, WatchChallenges, WatchChallenges>
    with $Provider<WatchChallenges> {
  WatchChallengesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchChallengesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchChallengesHash();

  @$internal
  @override
  $ProviderElement<WatchChallenges> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchChallenges create(Ref ref) {
    return watchChallenges(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchChallenges value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchChallenges>(value),
    );
  }
}

String _$watchChallengesHash() => r'4994588c25a03e8da96da27947ff4c935a64109d';
