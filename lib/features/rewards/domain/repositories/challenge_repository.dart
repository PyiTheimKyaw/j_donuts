import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';

abstract interface class ChallengeRepository {
  Stream<List<Challenge>> watchChallenges();
}
