import 'package:equatable/equatable.dart';

/// A validated Myanmar mobile number.
///
/// Construct through `PhoneValidator.validate`; the constructor trusts its
/// input so that repositories can rebuild one from storage.
final class PhoneNumber extends Equatable {
  const PhoneNumber(this.national);

  /// Country calling code for Myanmar, including the plus sign.
  static const String countryCode = '+95';

  /// Digits after the country code with no leading zero, e.g. `9254135592`.
  final String national;

  /// Full international form, e.g. `+959254135592`.
  String get e164 => '$countryCode$national';

  /// Local dialling form with the leading zero, e.g. `09254135592`.
  String get local => '0$national';

  @override
  List<Object?> get props => [national];

  @override
  String toString() => e164;
}
