import 'package:equatable/equatable.dart';

/// The constructor trusts its input so rows can be rehydrated from storage;
/// user input goes through `PhoneValidator`.
final class PhoneNumber extends Equatable {
  const PhoneNumber(this.national);

  static const String countryCode = '+95';

  final String national;

  String get e164 => '$countryCode$national';

  String get local => '0$national';

  @override
  List<Object?> get props => [national];

  @override
  String toString() => e164;
}
