import 'package:equatable/equatable.dart';

/// [lastName] is optional because many Myanmar names have no family name.
final class PersonName extends Equatable {
  const PersonName({required this.firstName, this.lastName});

  final String firstName;
  final String? lastName;

  String get full {
    final last = lastName;
    if (last == null || last.isEmpty) return firstName;
    return '$firstName $last';
  }

  @override
  List<Object?> get props => [firstName, lastName];
}
