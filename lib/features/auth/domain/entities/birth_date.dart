import 'package:equatable/equatable.dart';

/// A calendar date of birth, free of time zone concerns.
///
/// Construct through `BirthDateValidator.validate`, which guarantees the
/// components form a real date.
final class BirthDate extends Equatable {
  const BirthDate({required this.year, required this.month, required this.day});

  /// Rebuilds a [BirthDate] from a date stored as `DateTime`.
  factory BirthDate.fromDateTime(DateTime date) =>
      BirthDate(year: date.year, month: date.month, day: date.day);

  final int year;
  final int month;
  final int day;

  /// Midnight, local time, on the birth date.
  DateTime toDateTime() => DateTime(year, month, day);

  /// Completed years of age on [date].
  int ageOn(DateTime date) {
    var age = date.year - year;
    final birthdayPassed =
        date.month > month || (date.month == month && date.day >= day);
    if (!birthdayPassed) age -= 1;
    return age;
  }

  @override
  List<Object?> get props => [year, month, day];

  @override
  String toString() => '$year-$month-$day';
}
