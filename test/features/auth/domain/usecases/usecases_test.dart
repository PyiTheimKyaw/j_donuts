import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:j_donuts/features/auth/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository;

void main() {
  late _MockAuthRepository repository;

  const phone = PhoneNumber('9254135592');
  const code = OtpCode('123456');
  final session = AuthSession(phone: phone, startedAt: DateTime(2026, 11, 8));
  const details = RegistrationDetails(
    phone: phone,
    name: PersonName(firstName: 'Ye Min', lastName: 'Phyoe Win'),
    birthDate: BirthDate(year: 1980, month: 5, day: 1),
  );

  setUpAll(() {
    registerFallbackValue(phone);
    registerFallbackValue(code);
    registerFallbackValue(AuthIntent.register);
    registerFallbackValue(details);
  });

  setUp(() => repository = _MockAuthRepository());

  group('RequestOtp', () {
    test('passes phone and intent to the repository', () async {
      when(() => repository.requestOtp(any(), any()))
          .thenAnswer((_) async => const Result.success(null));

      final result = await RequestOtp(repository)(phone, AuthIntent.logIn);

      expect(result.isSuccess, isTrue);
      verify(() => repository.requestOtp(phone, AuthIntent.logIn)).called(1);
    });

    test('surfaces NotRegisteredFailure unchanged', () async {
      when(
        () => repository.requestOtp(any(), any()),
      ).thenAnswer((_) async => const Result.failure(NotRegisteredFailure()));

      final result = await RequestOtp(repository)(phone, AuthIntent.logIn);

      expect(result.failureOrNull, isA<NotRegisteredFailure>());
    });
  });

  group('VerifyOtp', () {
    test(
      'returns ReturningUser with a session for an existing number',
      () async {
        when(() => repository.verifyOtp(any(), any()))
            .thenAnswer((_) async => Result.success(ReturningUser(session)));

        final result = await VerifyOtp(repository)(phone, code);

        expect(result.valueOrNull, isA<ReturningUser>());
        expect((result.valueOrNull! as ReturningUser).session, session);
      },
    );

    test('returns NewUser for an unknown number', () async {
      when(() => repository.verifyOtp(any(), any()))
          .thenAnswer((_) async => const Result.success(NewUser(phone)));

      final result = await VerifyOtp(repository)(phone, code);

      expect(result.valueOrNull, isA<NewUser>());
    });

    test('surfaces InvalidOtpFailure with attempts left', () async {
      when(() => repository.verifyOtp(any(), any())).thenAnswer(
        (_) async => const Result.failure(InvalidOtpFailure(attemptsLeft: 2)),
      );

      final result = await VerifyOtp(repository)(phone, code);

      expect(result.failureOrNull, const InvalidOtpFailure(attemptsLeft: 2));
    });
  });

  group('RegisterUser', () {
    test('passes the details through and returns the new session', () async {
      when(() => repository.register(any()))
          .thenAnswer((_) async => Result.success(session));

      final result = await RegisterUser(repository)(details);

      expect(result.valueOrNull, session);
      verify(() => repository.register(details)).called(1);
    });
  });

  group('RestoreSession', () {
    test('returns null when nobody is signed in', () async {
      when(repository.currentSession)
          .thenAnswer((_) async => const Result.success(null));

      final result = await RestoreSession(repository)();

      expect(result, const Success<AuthSession?>(null));
    });

    test('returns the stored session', () async {
      when(repository.currentSession)
          .thenAnswer((_) async => Result.success(session));

      final result = await RestoreSession(repository)();

      expect(result.valueOrNull, session);
    });
  });

  group('GetProfile', () {
    test('loads the profile for a phone number', () async {
      final profile = UserProfile(
        phone: phone,
        name: details.name,
        birthDate: details.birthDate,
        createdAt: DateTime(2026, 11, 8),
      );
      when(() => repository.profileOf(any()))
          .thenAnswer((_) async => Result.success(profile));

      final result = await GetProfile(repository)(phone);

      expect(result.valueOrNull, profile);
    });
  });

  group('LogOut', () {
    test('clears the session through the repository', () async {
      when(repository.logOut)
          .thenAnswer((_) async => const Result.success(null));

      final result = await LogOut(repository)();

      expect(result.isSuccess, isTrue);
      verify(repository.logOut).called(1);
    });
  });
}
