import 'package:j_donuts/features/home/data/datasources/member_local_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/seed_loader.dart';
import 'package:j_donuts/features/home/data/mappers/catalog_mapper.dart';
import 'package:j_donuts/features/home/data/repositories/seeded_stream.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/features/home/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  MemberRepositoryImpl({required this._local, required this._seed});

  final MemberLocalDataSource _local;
  final SeedLoader _seed;

  @override
  Stream<Member?> watchMember() => seededStream(
    _seed,
    () => _local.watchMember().map(
      (row) => row == null ? null : CatalogMapper.member(row),
    ),
  );
}
