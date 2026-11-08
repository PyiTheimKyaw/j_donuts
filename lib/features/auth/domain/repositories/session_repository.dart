import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/auth_session.dart';

/// Persists the signed-in session across app launches.
///
/// Kept separate from `AuthRepository` so the storage mechanism (secure
/// storage today) can change independently of how users authenticate.
abstract interface class SessionRepository {
  FutureResult<AuthSession?> read();

  FutureResult<void> save(AuthSession session);

  FutureResult<void> clear();
}
