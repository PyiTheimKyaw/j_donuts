import 'package:j_donuts/features/home/data/datasources/seed_loader.dart';
import 'package:j_donuts/features/home/data/mappers/catalog_mapper.dart';
import 'package:j_donuts/features/home/data/repositories/seeded_stream.dart';
import 'package:j_donuts/features/rewards/data/datasources/challenge_local_data_source.dart';
import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';
import 'package:j_donuts/features/rewards/domain/repositories/challenge_repository.dart';

class ChallengeRepositoryImpl implements ChallengeRepository {
  ChallengeRepositoryImpl({required this._local, required this._seed});

  final ChallengeLocalDataSource _local;
  final SeedLoader _seed;

  @override
  Stream<List<Challenge>> watchChallenges() => seededStream(
    _seed,
    () => _local.watchChallenges().map(
      (rows) => rows.map(CatalogMapper.challenge).toList(),
    ),
  );
}
