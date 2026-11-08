import 'dart:convert';

import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/domain/repositories/session_repository.dart';

final class SecureSessionRepository implements SessionRepository {
  const SecureSessionRepository(this._store);

  static const String storageKey = 'auth.session';
  static const String _phoneField = 'phone';
  static const String _startedAtField = 'startedAt';

  final KeyValueStore _store;

  @override
  FutureResult<AuthSession?> read() async {
    try {
      final raw = await _store.read(storageKey);
      if (raw == null) return const Result.success(null);
      return Result.success(_decode(raw));
    } on Exception catch (error) {
      return Result.failure(StorageFailure(message: error.toString()));
    }
  }

  @override
  FutureResult<void> save(AuthSession session) async {
    try {
      await _store.write(storageKey, _encode(session));
      return const Result.success(null);
    } on Exception catch (error) {
      return Result.failure(StorageFailure(message: error.toString()));
    }
  }

  @override
  FutureResult<void> clear() async {
    try {
      await _store.delete(storageKey);
      return const Result.success(null);
    } on Exception catch (error) {
      return Result.failure(StorageFailure(message: error.toString()));
    }
  }

  static String _encode(AuthSession session) => jsonEncode({
    _phoneField: session.phone.national,
    _startedAtField: session.startedAt.toUtc().toIso8601String(),
  });

  static AuthSession _decode(String raw) {
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return AuthSession(
      phone: PhoneNumber(json[_phoneField] as String),
      startedAt: DateTime.parse(json[_startedAtField] as String).toLocal(),
    );
  }
}
