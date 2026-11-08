import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/domain/entities/birth_date.dart';
import 'package:j_donuts/features/auth/domain/validators/birth_date_validator.dart';

void main() {
  final today = DateTime(2026, 11, 8);

  Result<BirthDate> validate({int? year, int? month, int? day}) =>
      BirthDateValidator.validate(
        year: year,
        month: month,
        day: day,
        today: today,
      );

  group('BirthDateValidator.validate', () {
    test('accepts a real past date for an adult', () {
      expect(
        validate(year: 1980, month: 5, day: 1),
        const Success(BirthDate(year: 1980, month: 5, day: 1)),
      );
    });

    test('rejects a missing component as incomplete', () {
      expect(_ruleOf(validate(month: 5, day: 1)), _incomplete);
      expect(_ruleOf(validate(year: 1980, day: 1)), _incomplete);
      expect(_ruleOf(validate(year: 1980, month: 5)), _incomplete);
    });

    test('rejects 31 April', () {
      expect(_ruleOf(validate(year: 1990, month: 4, day: 31)), _notADate);
    });

    test('rejects 29 February in a common year', () {
      expect(_ruleOf(validate(year: 2003, month: 2, day: 29)), _notADate);
    });

    test('accepts 29 February in a leap year', () {
      expect(validate(year: 2004, month: 2, day: 29).isSuccess, isTrue);
    });

    test('rejects 29 February 1900 (divisible by 100, not by 400)', () {
      expect(_ruleOf(validate(year: 1900, month: 2, day: 29)), _notADate);
    });

    test('accepts 29 February 2000 (divisible by 400)', () {
      expect(validate(year: 2000, month: 2, day: 29).isSuccess, isTrue);
    });

    test('rejects month 0, month 13 and day 0', () {
      expect(_ruleOf(validate(year: 1990, month: 0, day: 1)), _notADate);
      expect(_ruleOf(validate(year: 1990, month: 13, day: 1)), _notADate);
      expect(_ruleOf(validate(year: 1990, month: 1, day: 0)), _notADate);
    });

    test('rejects a date in the future', () {
      expect(_ruleOf(validate(year: 2026, month: 11, day: 9)), _inFuture);
      expect(_ruleOf(validate(year: 2027, month: 1, day: 1)), _inFuture);
    });

    test('accepts someone who turns the minimum age today', () {
      final year = today.year - AuthPolicy.minimumAgeYears;

      expect(validate(year: year, month: 11, day: 8).isSuccess, isTrue);
    });

    test('rejects someone who turns the minimum age tomorrow', () {
      final year = today.year - AuthPolicy.minimumAgeYears;

      expect(_ruleOf(validate(year: year, month: 11, day: 9)), _tooYoung);
    });

    test('rejects a baby born yesterday as too young, not as future', () {
      expect(_ruleOf(validate(year: 2026, month: 11, day: 7)), _tooYoung);
    });

    test('reports the calendar error before the age error', () {
      expect(_ruleOf(validate(year: 2020, month: 2, day: 30)), _notADate);
    });
  });

  group('BirthDateValidator.daysInMonth', () {
    test('knows 30- and 31-day months', () {
      expect(BirthDateValidator.daysInMonth(year: 2026, month: 1), 31);
      expect(BirthDateValidator.daysInMonth(year: 2026, month: 4), 30);
      expect(BirthDateValidator.daysInMonth(year: 2026, month: 12), 31);
    });

    test('knows February in leap and common years', () {
      expect(BirthDateValidator.daysInMonth(year: 2024, month: 2), 29);
      expect(BirthDateValidator.daysInMonth(year: 2025, month: 2), 28);
    });
  });

  group('BirthDateValidator.isLeapYear', () {
    test('follows the Gregorian rule', () {
      expect(BirthDateValidator.isLeapYear(2024), isTrue);
      expect(BirthDateValidator.isLeapYear(2000), isTrue);
      expect(BirthDateValidator.isLeapYear(1900), isFalse);
      expect(BirthDateValidator.isLeapYear(2023), isFalse);
    });
  });

  group('BirthDate.ageOn', () {
    const birth = BirthDate(year: 2000, month: 6, day: 15);

    test('counts a completed year only once the birthday has passed', () {
      expect(birth.ageOn(DateTime(2026, 6, 14)), 25);
      expect(birth.ageOn(DateTime(2026, 6, 15)), 26);
      expect(birth.ageOn(DateTime(2026, 6, 16)), 26);
    });

    test('round-trips through DateTime', () {
      expect(BirthDate.fromDateTime(birth.toDateTime()), birth);
    });
  });
}

const BirthDateValidationError _incomplete =
    BirthDateValidationError.incomplete;
const BirthDateValidationError _notADate =
    BirthDateValidationError.notACalendarDate;
const BirthDateValidationError _inFuture = BirthDateValidationError.inFuture;
const BirthDateValidationError _tooYoung = BirthDateValidationError.tooYoung;

Enum? _ruleOf(Result<Object?> result) =>
    (result.failureOrNull as ValidationFailure?)?.rule;
