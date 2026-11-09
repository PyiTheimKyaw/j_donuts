import 'package:equatable/equatable.dart';
import 'package:j_donuts/features/auth/domain/entities/birth_date.dart';
import 'package:j_donuts/features/auth/domain/entities/person_name.dart';
import 'package:j_donuts/features/auth/domain/entities/phone_number.dart';

final class RegistrationDetails extends Equatable {
  const RegistrationDetails({
    required this.phone,
    required this.name,
    required this.birthDate,
  });

  final PhoneNumber phone;
  final PersonName name;
  final BirthDate birthDate;

  @override
  List<Object?> get props => [phone, name, birthDate];
}

final class UserProfile extends Equatable {
  const UserProfile({
    required this.phone,
    required this.name,
    required this.birthDate,
    required this.createdAt,
  });

  final PhoneNumber phone;
  final PersonName name;
  final BirthDate birthDate;
  final DateTime createdAt;

  @override
  List<Object?> get props => [phone, name, birthDate, createdAt];
}
