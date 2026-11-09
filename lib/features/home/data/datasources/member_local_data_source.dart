import 'package:drift/drift.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/core/db/tables/catalog_tables.dart';

part 'member_local_data_source.g.dart';

@DriftAccessor(tables: [Members])
class MemberLocalDataSource extends DatabaseAccessor<AppDatabase>
    with _$MemberLocalDataSourceMixin {
  MemberLocalDataSource(super.attachedDatabase);

  /// There is one member per device; the first row is the member.
  Stream<MemberRow?> watchMember() =>
      (select(members)..limit(1)).watchSingleOrNull();

  Future<void> upsert(MembersCompanion member) =>
      into(members).insertOnConflictUpdate(member);
}
