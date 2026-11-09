import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/features/auth/data/repositories/secure_session_repository.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';

final class _ThrowingStore implements KeyValueStore {
  @override
  Future<String?> read(String key) async => throw Exception('keychain locked');

  @override
  Future<void> write(String key, String value) async =>
      throw Exception('keychain locked');

  @override
  Future<void> delete(String key) async => throw Exception('keychain locked');
}

void main() {
  final session = AuthSession(
    phone: const PhoneNumber('9254135592'),
    startedAt: DateTime(2026, 11, 8, 10, 30),
  );

  group('SecureSessionRepository', () {
    test('reads null when nothing is stored', () async {
      final repository = SecureSessionRepository(InMemoryKeyValueStore());

      expect(await repository.read(), const Success<AuthSession?>(null));
    });

    test('round-trips a saved session', () async {
      final repository = SecureSessionRepository(InMemoryKeyValueStore());

      await repository.save(session);

      expect((await repository.read()).valueOrNull, session);
    });

    test('clear removes the session', () async {
      final repository = SecureSessionRepository(InMemoryKeyValueStore());
      await repository.save(session);

      await repository.clear();

      expect((await repository.read()).valueOrNull, isNull);
    });

    test('writes under a single well-known key', () async {
      final store = InMemoryKeyValueStore();
      final repository = SecureSessionRepository(store);

      await repository.save(session);

      expect(await store.read(SecureSessionRepository.storageKey), isNotNull);
    });

    test('reports corrupt stored data as a StorageFailure', () async {
      final store = InMemoryKeyValueStore({
        SecureSessionRepository.storageKey: 'not json',
      });
      final repository = SecureSessionRepository(store);

      expect((await repository.read()).failureOrNull, isA<StorageFailure>());
    });

    test('reports storage errors as StorageFailure, never throws', () async {
      final repository = SecureSessionRepository(_ThrowingStore());

      expect((await repository.read()).failureOrNull, isA<StorageFailure>());
      expect(
        (await repository.save(session)).failureOrNull,
        isA<StorageFailure>(),
      );
      expect((await repository.clear()).failureOrNull, isA<StorageFailure>());
    });
  });
}
