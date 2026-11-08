import 'package:equatable/equatable.dart';

/// Calendar date without a time zone. Validity is `BirthDateValidator`'s job.
final class BirthDate extends Equatable {
  const BirthDate({required this.year, required this.month, required this.day});

  factory BirthDate.fromDateTime(DateTime date) =>
      BirthDate(year: date.year, month: date.month, day: date.day);

  final int year;
  final int month;
  final int day;

  DateTime toDateTime() => DateTime(year, month, day);

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
