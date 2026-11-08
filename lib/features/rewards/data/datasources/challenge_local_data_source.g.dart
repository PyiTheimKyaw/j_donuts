// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_local_data_source.dart';

// ignore_for_file: type=lint
mixin _$ChallengeLocalDataSourceMixin on DatabaseAccessor<AppDatabase> {
  $ChallengesTable get challenges => attachedDatabase.challenges;
  ChallengeLocalDataSourceManager get managers =>
      ChallengeLocalDataSourceManager(this);
}

class ChallengeLocalDataSourceManager {
  final _$ChallengeLocalDataSourceMixin _db;
  ChallengeLocalDataSourceManager(this._db);
  $$ChallengesTableTableManager get challenges =>
      $$ChallengesTableTableManager(_db.attachedDatabase, _db.challenges);
}
