import 'package:drift/drift.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/core/db/tables/users_table.dart';

part 'user_local_data_source.g.dart';

@DriftAccessor(tables: [Users])
class UserLocalDataSource extends DatabaseAccessor<AppDatabase>
    with _$UserLocalDataSourceMixin {
  UserLocalDataSource(super.attachedDatabase);

  Future<UserRow?> findByPhone(String phone) => (select(
    users,
  )..where((row) => row.phone.equals(phone))).getSingleOrNull();

  Future<bool> exists(String phone) async => await findByPhone(phone) != null;

  Future<void> upsert(UsersCompanion user) =>
      into(users).insertOnConflictUpdate(user);
}
