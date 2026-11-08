import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/core/time/clock.dart';
import 'package:j_donuts/features/auth/data/datasources/user_local_data_source.dart';
import 'package:j_donuts/features/auth/data/mappers/user_mapper.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:j_donuts/features/auth/domain/repositories/session_repository.dart';

/// Simulates a remote auth API against the local database. An HTTP
/// implementation of [AuthRepository] replaces it without touching other files.
final class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({
    required this._users,
    required this._sessions,
    this.latency = defaultLatency,
    this.validOtp = defaultOtp,
    this._clock = DateTime.now,
  });

  static const Duration defaultLatency = Duration(seconds: 1);

  static const String defaultOtp = '123456';

  final UserLocalDataSource _users;
  final SessionRepository _sessions;
  final Clock _clock;
  final Duration latency;
  final String validOtp;

  /// Reset whenever a new code is requested.
  final Map<String, int> _wrongAttempts = {};

  @override
  FutureResult<void> requestOtp(PhoneNumber phone, AuthIntent intent) =>
      _afterLatency(() async {
        if (intent == AuthIntent.logIn &&
            !await _users.exists(phone.national)) {
          return const Result.failure(NotRegisteredFailure());
        }
        _wrongAttempts.remove(phone.national);
        return const Result.success(null);
      });

  @override
  FutureResult<OtpVerification> verifyOtp(PhoneNumber phone, OtpCode code) =>
      _afterLatency(() async {
        final attempts = _wrongAttempts[phone.national] ?? 0;
        if (attempts >= AuthPolicy.maxOtpAttempts) {
          return const Result.failure(OtpLockedFailure());
        }
        if (code.value != validOtp) return _recordWrongAttempt(phone, attempts);
        _wrongAttempts.remove(phone.national);
        return await _resolveVerifiedUser(phone);
      });

  Result<OtpVerification> _recordWrongAttempt(PhoneNumber phone, int attempts) {
    final updated = attempts + 1;
    _wrongAttempts[phone.national] = updated;
    final remaining = AuthPolicy.maxOtpAttempts - updated;
    if (remaining <= 0) return const Result.failure(OtpLockedFailure());
    return Result.failure(InvalidOtpFailure(attemptsLeft: remaining));
  }

  FutureResult<OtpVerification> _resolveVerifiedUser(PhoneNumber phone) async {
    final row = await _users.findByPhone(phone.national);
    if (row == null) return Result.success(NewUser(phone));
    final session = AuthSession(phone: phone, startedAt: _clock());
    return (await _sessions.save(session)).map((_) => ReturningUser(session));
  }

  @override
  FutureResult<AuthSession> register(RegistrationDetails details) =>
      _afterLatency(() async {
        final now = _clock();
        await _users.upsert(UserMapper.toCompanion(details, createdAt: now));
        final session = AuthSession(phone: details.phone, startedAt: now);
        return (await _sessions.save(session)).map((_) => session);
      });

  @override
  FutureResult<UserProfile> profileOf(PhoneNumber phone) => _guard(() async {
    final row = await _users.findByPhone(phone.national);
    if (row == null) return const Result.failure(NotFoundFailure());
    return Result.success(UserMapper.toDomain(row));
  });

  @override
  FutureResult<AuthSession?> currentSession() => _sessions.read();

  @override
  FutureResult<void> logOut() => _sessions.clear();

  FutureResult<T> _afterLatency<T>(FutureResult<T> Function() action) async {
    if (latency > Duration.zero) await Future<void>.delayed(latency);
    return await _guard(action);
  }

  FutureResult<T> _guard<T>(FutureResult<T> Function() action) async {
    try {
      return await action();
    } on Exception catch (error) {
      return Result.failure(StorageFailure(message: error.toString()));
    }
  }
}
