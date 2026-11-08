import 'package:equatable/equatable.dart';

/// Failures are values, not exceptions, so callers branch on them without
/// try/catch and nothing is swallowed on the way up.
sealed class Failure extends Equatable {
  const Failure({this.message});

  /// Developer-facing detail; never rendered to users.
  final String? message;

  @override
  List<Object?> get props => [message];
}

/// [rule] is a per-field enum so presentation maps it with an exhaustive
/// switch rather than string codes.
final class ValidationFailure extends Failure {
  const ValidationFailure(this.rule, {super.message});

  final Enum rule;

  String get code => rule.name;

  @override
  List<Object?> get props => [rule, message];
}

final class NotRegisteredFailure extends Failure {
  const NotRegisteredFailure({super.message});
}

final class InvalidOtpFailure extends Failure {
  const InvalidOtpFailure({required this.attemptsLeft, super.message});

  final int attemptsLeft;

  @override
  List<Object?> get props => [attemptsLeft, message];
}

final class OtpLockedFailure extends Failure {
  const OtpLockedFailure({super.message});
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});
}

final class StorageFailure extends Failure {
  const StorageFailure({super.message});
}

final class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message});
}
