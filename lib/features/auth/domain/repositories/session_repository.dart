import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/auth_session.dart';

/// Separate from `AuthRepository` so the storage mechanism can change
/// independently of how users authenticate.
abstract interface class SessionRepository {
  FutureResult<AuthSession?> read();

  FutureResult<void> save(AuthSession session);

  FutureResult<void> clear();
}
