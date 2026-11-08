import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';
import 'package:j_donuts/features/rewards/domain/repositories/challenge_repository.dart';

final class WatchChallenges {
  const WatchChallenges(this._repository);

  final ChallengeRepository _repository;

  Stream<List<Challenge>> call() => _repository.watchChallenges();
}
