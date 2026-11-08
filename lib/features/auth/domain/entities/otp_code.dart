import 'package:equatable/equatable.dart';

final class OtpCode extends Equatable {
  const OtpCode(this.value);

  final String value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'OtpCode(******)';
}
