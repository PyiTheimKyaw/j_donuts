import 'package:drift/drift.dart';

@DataClassName('UserRow')
class Users extends Table {
  /// National digits, no leading zero.
  TextColumn get phone => text()();

  TextColumn get firstName => text()();

  TextColumn get lastName => text().nullable()();

  /// `yyyy-MM-dd`; a timestamp would shift across time zones.
  TextColumn get birthDate => text()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {phone};
}
