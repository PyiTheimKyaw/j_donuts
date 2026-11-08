import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/domain/entities/birth_date.dart';

/// Reasons a date of birth is rejected.
enum BirthDateValidationError {
  /// One or more of month, day, year is missing.
  incomplete,

  /// The components do not form a real calendar date (31 April, 29 Feb 2023).
  notACalendarDate,

  /// The date is after today.
  inFuture,

  /// The person is younger than [AuthPolicy.minimumAgeYears].
  tooYoung,
}

/// Validates a date of birth entered as separate month, day and year.
abstract final class BirthDateValidator {
  static const int _firstMonth = 1;
  static const int _lastMonth = 12;
  static const int _firstDay = 1;

  /// [today] is injected so the rule is deterministic in tests.
  static Result<BirthDate> validate({
    required int? year,
    required int? month,
    required int? day,
    required DateTime today,
  }) {
    if (year == null || month == null || day == null) {
      return const Result.failure(
        ValidationFailure(BirthDateValidationError.incomplete),
      );
    }
    if (!isCalendarDate(year: year, month: month, day: day)) {
      return const Result.failure(
        ValidationFailure(BirthDateValidationError.notACalendarDate),
      );
    }
    final birthDate = BirthDate(year: year, month: month, day: day);
    final todayDate = DateTime(today.year, today.month, today.day);
    if (birthDate.toDateTime().isAfter(todayDate)) {
      return const Result.failure(
        ValidationFailure(BirthDateValidationError.inFuture),
      );
    }
    if (birthDate.ageOn(todayDate) < AuthPolicy.minimumAgeYears) {
      return const Result.failure(
        ValidationFailure(BirthDateValidationError.tooYoung),
      );
    }
    return Result.success(birthDate);
  }

  /// True when the components describe a day that exists, honouring
  /// month lengths and leap years.
  static bool isCalendarDate({
    required int year,
    required int month,
    required int day,
  }) {
    if (month < _firstMonth || month > _lastMonth) return false;
    if (day < _firstDay || day > daysInMonth(year: year, month: month)) {
      return false;
    }
    return true;
  }

  /// Number of days in [month] of [year].
  static int daysInMonth({required int year, required int month}) {
    // Day 0 of the next month is the last day of this month.
    return DateTime(year, month + 1, 0).day;
  }

  static bool isLeapYear(int year) =>
      (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
}
