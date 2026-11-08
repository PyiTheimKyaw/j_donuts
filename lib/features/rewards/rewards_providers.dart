import 'package:j_donuts/core/db/database_provider.dart';
import 'package:j_donuts/features/home/home_providers.dart';
import 'package:j_donuts/features/rewards/data/datasources/challenge_local_data_source.dart';
import 'package:j_donuts/features/rewards/data/repositories/challenge_repository_impl.dart';
import 'package:j_donuts/features/rewards/domain/repositories/challenge_repository.dart';
import 'package:j_donuts/features/rewards/domain/usecases/watch_challenges.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rewards_providers.g.dart';

@Riverpod(keepAlive: true)
ChallengeRepository challengeRepository(Ref ref) => ChallengeRepositoryImpl(
  local: ChallengeLocalDataSource(ref.watch(appDatabaseProvider)),
  seed: ref.watch(seedLoaderProvider),
);

@riverpod
WatchChallenges watchChallenges(Ref ref) =>
    WatchChallenges(ref.watch(challengeRepositoryProvider));
