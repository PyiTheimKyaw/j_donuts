import 'package:equatable/equatable.dart';

/// A member's name. Many Myanmar names have no family name, so [lastName]
/// is optional.
final class PersonName extends Equatable {
  const PersonName({required this.firstName, this.lastName});

  final String firstName;
  final String? lastName;

  /// First and last name joined with a space, or just the first name.
  String get full {
    final last = lastName;
    if (last == null || last.isEmpty) return firstName;
    return '$firstName $last';
  }

  @override
  List<Object?> get props => [firstName, lastName];
}
