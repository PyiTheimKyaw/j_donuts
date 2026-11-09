import 'package:drift/drift.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/core/db/tables/catalog_tables.dart';

part 'challenge_local_data_source.g.dart';

@DriftAccessor(tables: [Challenges])
class ChallengeLocalDataSource extends DatabaseAccessor<AppDatabase>
    with _$ChallengeLocalDataSourceMixin {
  ChallengeLocalDataSource(super.attachedDatabase);

  Stream<List<ChallengeRow>> watchChallenges() => (select(
    challenges,
  )..orderBy([(row) => OrderingTerm.asc(row.sortOrder)])).watch();

  Future<void> upsertAll(List<ChallengesCompanion> rows) =>
      batch((batch) => batch.insertAllOnConflictUpdate(challenges, rows));
}
