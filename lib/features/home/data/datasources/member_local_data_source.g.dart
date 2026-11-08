// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_local_data_source.dart';

// ignore_for_file: type=lint
mixin _$MemberLocalDataSourceMixin on DatabaseAccessor<AppDatabase> {
  $MembersTable get members => attachedDatabase.members;
  MemberLocalDataSourceManager get managers =>
      MemberLocalDataSourceManager(this);
}

class MemberLocalDataSourceManager {
  final _$MemberLocalDataSourceMixin _db;
  MemberLocalDataSourceManager(this._db);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db.attachedDatabase, _db.members);
}
