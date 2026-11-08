import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';

void main() {
  group('PersonName.full', () {
    test('joins first and last name with a space', () {
      const name = PersonName(firstName: 'Ye Min', lastName: 'Phyoe Win');

      expect(name.full, 'Ye Min Phyoe Win');
    });

    test('is just the first name when there is no last name', () {
      expect(const PersonName(firstName: 'Hania').full, 'Hania');
      expect(const PersonName(firstName: 'Hania', lastName: '').full, 'Hania');
    });
  });

  group('OtpVerification', () {
    test('distinguishes returning users from new users exhaustively', () {
      final session = AuthSession(
        phone: const PhoneNumber('9254135592'),
        startedAt: DateTime(2026, 11, 8),
      );
      final outcomes = <OtpVerification>[
        ReturningUser(session),
        const NewUser(PhoneNumber('9111111111')),
      ];

      final labels = outcomes.map(
        (outcome) => switch (outcome) {
          ReturningUser() => 'home',
          NewUser() => 'name',
        },
      );

      expect(labels, ['home', 'name']);
    });
  });

  group('RegistrationDetails', () {
    test('is equal by value', () {
      const a = RegistrationDetails(
        phone: PhoneNumber('9254135592'),
        name: PersonName(firstName: 'Ye Min'),
        birthDate: BirthDate(year: 1980, month: 5, day: 1),
      );
      const b = RegistrationDetails(
        phone: PhoneNumber('9254135592'),
        name: PersonName(firstName: 'Ye Min'),
        birthDate: BirthDate(year: 1980, month: 5, day: 1),
      );

      expect(a, b);
    });
  });
}
