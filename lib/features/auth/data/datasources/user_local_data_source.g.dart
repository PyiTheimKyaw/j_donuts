// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_local_data_source.dart';

// ignore_for_file: type=lint
mixin _$UserLocalDataSourceMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  UserLocalDataSourceManager get managers => UserLocalDataSourceManager(this);
}

class UserLocalDataSourceManager {
  final _$UserLocalDataSourceMixin _db;
  UserLocalDataSourceManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
}
