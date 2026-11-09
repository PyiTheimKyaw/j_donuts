import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/features/auth/data/datasources/user_local_data_source.dart';
import 'package:j_donuts/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:j_donuts/features/auth/data/repositories/secure_session_repository.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';

void main() {
  late AppDatabase database;
  late SecureSessionRepository sessions;
  late FakeAuthRepository repository;

  final now = DateTime(2026, 11, 8, 12);
  const phone = PhoneNumber('9254135592');
  const otherPhone = PhoneNumber('9111111111');
  const rightCode = OtpCode(FakeAuthRepository.defaultOtp);
  const wrongCode = OtpCode('000000');
  const details = RegistrationDetails(
    phone: phone,
    name: PersonName(firstName: 'Ye Min', lastName: 'Phyoe Win'),
    birthDate: BirthDate(year: 1980, month: 5, day: 1),
  );

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    sessions = SecureSessionRepository(InMemoryKeyValueStore());
    repository = FakeAuthRepository(
      users: UserLocalDataSource(database),
      sessions: sessions,
      latency: Duration.zero,
      clock: () => now,
    );
  });

  tearDown(() => database.close());

  group('requestOtp', () {
    test('succeeds for any number when registering', () async {
      final result = await repository.requestOtp(phone, AuthIntent.register);

      expect(result.isSuccess, isTrue);
    });

    test(
      'fails with NotRegisteredFailure when logging in with a new number',
      () async {
        final result = await repository.requestOtp(phone, AuthIntent.logIn);

        expect(result.failureOrNull, isA<NotRegisteredFailure>());
      },
    );

    test('succeeds when logging in with a registered number', () async {
      await repository.register(details);

      final result = await repository.requestOtp(phone, AuthIntent.logIn);

      expect(result.isSuccess, isTrue);
    });
  });

  group('verifyOtp', () {
    test('returns NewUser for the right code and an unknown number', () async {
      final result = await repository.verifyOtp(phone, rightCode);

      expect(result.valueOrNull, const NewUser(phone));
    });

    test('does not start a session for a new user', () async {
      await repository.verifyOtp(phone, rightCode);

      expect((await sessions.read()).valueOrNull, isNull);
    });

    test(
      'returns ReturningUser and starts a session for a known number',
      () async {
        await repository.register(details);
        await sessions.clear();

        final result = await repository.verifyOtp(phone, rightCode);

        final outcome = result.valueOrNull;
        expect(outcome, isA<ReturningUser>());
        expect((outcome! as ReturningUser).session.phone, phone);
        expect((await sessions.read()).valueOrNull?.phone, phone);
      },
    );

    test('counts down attempts on wrong codes, then locks', () async {
      final first = await repository.verifyOtp(phone, wrongCode);
      final second = await repository.verifyOtp(phone, wrongCode);
      final third = await repository.verifyOtp(phone, wrongCode);

      expect(first.failureOrNull, const InvalidOtpFailure(attemptsLeft: 2));
      expect(second.failureOrNull, const InvalidOtpFailure(attemptsLeft: 1));
      expect(third.failureOrNull, isA<OtpLockedFailure>());
    });

    test('stays locked even for the right code', () async {
      for (var i = 0; i < AuthPolicy.maxOtpAttempts; i++) {
        await repository.verifyOtp(phone, wrongCode);
      }

      final result = await repository.verifyOtp(phone, rightCode);

      expect(result.failureOrNull, isA<OtpLockedFailure>());
    });

    test('requesting a new code unlocks entry', () async {
      for (var i = 0; i < AuthPolicy.maxOtpAttempts; i++) {
        await repository.verifyOtp(phone, wrongCode);
      }

      await repository.requestOtp(phone, AuthIntent.register);
      final result = await repository.verifyOtp(phone, rightCode);

      expect(result.isSuccess, isTrue);
    });

    test('tracks attempts per phone number', () async {
      await repository.verifyOtp(phone, wrongCode);
      await repository.verifyOtp(phone, wrongCode);

      final result = await repository.verifyOtp(otherPhone, wrongCode);

      expect(result.failureOrNull, const InvalidOtpFailure(attemptsLeft: 2));
    });

    test('a correct code resets the attempt counter', () async {
      await repository.verifyOtp(phone, wrongCode);
      await repository.verifyOtp(phone, rightCode);

      final result = await repository.verifyOtp(phone, wrongCode);

      expect(result.failureOrNull, const InvalidOtpFailure(attemptsLeft: 2));
    });
  });

  group('register', () {
    test('stores the user and starts a session at the current time', () async {
      final result = await repository.register(details);

      expect(result.valueOrNull, AuthSession(phone: phone, startedAt: now));
      expect((await sessions.read()).valueOrNull?.phone, phone);
    });

    test('makes the profile readable with the same values', () async {
      await repository.register(details);

      final profile = (await repository.profileOf(phone)).valueOrNull;

      expect(profile?.name, details.name);
      expect(profile?.birthDate, details.birthDate);
      expect(profile?.createdAt, now);
    });

    test('keeps a null last name as null', () async {
      const single = RegistrationDetails(
        phone: otherPhone,
        name: PersonName(firstName: 'Hania'),
        birthDate: BirthDate(year: 1995, month: 2, day: 28),
      );

      await repository.register(single);

      final profile = (await repository.profileOf(otherPhone)).valueOrNull;
      expect(profile?.name.lastName, isNull);
    });
  });

  group('profileOf', () {
    test('fails with NotFoundFailure for an unknown number', () async {
      final result = await repository.profileOf(phone);

      expect(result.failureOrNull, isA<NotFoundFailure>());
    });
  });

  group('session', () {
    test('currentSession reflects register and logOut', () async {
      expect((await repository.currentSession()).valueOrNull, isNull);

      await repository.register(details);
      expect((await repository.currentSession()).valueOrNull, isNotNull);

      await repository.logOut();
      expect((await repository.currentSession()).valueOrNull, isNull);
    });
  });

  group('latency', () {
    test('waits the configured time before answering', () async {
      const latency = Duration(milliseconds: 40);
      final slow = FakeAuthRepository(
        users: UserLocalDataSource(database),
        sessions: sessions,
        latency: latency,
      );
      final stopwatch = Stopwatch()..start();

      await slow.requestOtp(phone, AuthIntent.register);

      expect(stopwatch.elapsed, greaterThanOrEqualTo(latency));
    });

    test('defaults to about one second', () {
      expect(FakeAuthRepository.defaultLatency, const Duration(seconds: 1));
    });
  });
}
