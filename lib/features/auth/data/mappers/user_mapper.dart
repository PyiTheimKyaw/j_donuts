import 'package:drift/drift.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';

abstract final class UserMapper {
  static const String _dateSeparator = '-';

  static UserProfile toDomain(UserRow row) => UserProfile(
    phone: PhoneNumber(row.phone),
    name: PersonName(firstName: row.firstName, lastName: row.lastName),
    birthDate: parseBirthDate(row.birthDate),
    createdAt: row.createdAt,
  );

  static UsersCompanion toCompanion(
    RegistrationDetails details, {
    required DateTime createdAt,
  }) => UsersCompanion.insert(
    phone: details.phone.national,
    firstName: details.name.firstName,
    lastName: Value(details.name.lastName),
    birthDate: formatBirthDate(details.birthDate),
    createdAt: createdAt,
  );

  static String formatBirthDate(BirthDate date) => [
    date.year.toString().padLeft(4, '0'),
    date.month.toString().padLeft(2, '0'),
    date.day.toString().padLeft(2, '0'),
  ].join(_dateSeparator);

  static BirthDate parseBirthDate(String text) {
    final parts = text.split(_dateSeparator).map(int.parse).toList();
    return BirthDate(year: parts[0], month: parts[1], day: parts[2]);
  }
}
