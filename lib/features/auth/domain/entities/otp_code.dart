import 'package:equatable/equatable.dart';

/// A complete one-time code as typed by the user.
///
/// Construct through `OtpValidator.validate`.
final class OtpCode extends Equatable {
  const OtpCode(this.value);

  final String value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'OtpCode(******)';
}
