import 'package:j_donuts/core/db/database_provider.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/features/auth/data/datasources/user_local_data_source.dart';
import 'package:j_donuts/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:j_donuts/features/auth/data/repositories/secure_session_repository.dart';
import 'package:j_donuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:j_donuts/features/auth/domain/repositories/session_repository.dart';
import 'package:j_donuts/features/auth/domain/usecases/usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

// Composition root: the only file binding auth interfaces to implementations.

@Riverpod(keepAlive: true)
UserLocalDataSource userLocalDataSource(Ref ref) =>
    UserLocalDataSource(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SessionRepository sessionRepository(Ref ref) =>
    SecureSessionRepository(ref.watch(keyValueStoreProvider));

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => FakeAuthRepository(
  users: ref.watch(userLocalDataSourceProvider),
  sessions: ref.watch(sessionRepositoryProvider),
);

@riverpod
RequestOtp requestOtp(Ref ref) => RequestOtp(ref.watch(authRepositoryProvider));

@riverpod
VerifyOtp verifyOtp(Ref ref) => VerifyOtp(ref.watch(authRepositoryProvider));

@riverpod
RegisterUser registerUser(Ref ref) =>
    RegisterUser(ref.watch(authRepositoryProvider));

@riverpod
RestoreSession restoreSession(Ref ref) =>
    RestoreSession(ref.watch(authRepositoryProvider));

@riverpod
GetProfile getProfile(Ref ref) => GetProfile(ref.watch(authRepositoryProvider));

@riverpod
LogOut logOut(Ref ref) => LogOut(ref.watch(authRepositoryProvider));
