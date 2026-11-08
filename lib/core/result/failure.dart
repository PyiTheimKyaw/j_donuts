import 'package:equatable/equatable.dart';

/// Base class for every typed failure the domain and data layers can return.
///
/// Failures are values, not exceptions: repositories catch low-level errors
/// and surface one of these so the presentation layer can render a precise
/// message without a `try` block.
sealed class Failure extends Equatable {
  const Failure({this.message});

  /// Optional developer-facing detail; never shown directly to users.
  final String? message;

  @override
  List<Object?> get props => [message];
}

/// Input did not satisfy a domain rule.
///
/// [rule] is one of the per-field validation enums (for example
/// `PhoneValidationError.invalidFormat`), so the UI can map it to a
/// localised string with an exhaustive `switch`.
final class ValidationFailure extends Failure {
  const ValidationFailure(this.rule, {super.message});

  final Enum rule;

  /// Stable machine-readable identifier, handy for logs and tests.
  String get code => rule.name;

  @override
  List<Object?> get props => [rule, message];
}

/// The phone number has no account.
final class NotRegisteredFailure extends Failure {
  const NotRegisteredFailure({super.message});
}

/// The one-time code did not match.
final class InvalidOtpFailure extends Failure {
  const InvalidOtpFailure({required this.attemptsLeft, super.message});

  final int attemptsLeft;

  @override
  List<Object?> get props => [attemptsLeft, message];
}

/// Too many wrong codes; entry is locked until a new code is requested.
final class OtpLockedFailure extends Failure {
  const OtpLockedFailure({super.message});
}

/// The requested record does not exist locally.
final class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});
}

/// Reading from or writing to local storage failed.
final class StorageFailure extends Failure {
  const StorageFailure({super.message});
}

/// A remote call failed or the device is offline.
final class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}

/// Anything that does not fit a more specific category.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message});
}
