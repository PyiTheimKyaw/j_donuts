import 'package:j_donuts/core/result/failure.dart';
import 'package:meta/meta.dart';

/// Outcome of an operation that can fail with a typed [Failure].
///
/// Pattern-match with a `switch` or use the helpers below:
///
/// ```dart
/// switch (result) {
///   case Success(:final value): ...
///   case Error(:final failure): ...
/// }
/// ```
sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(Failure failure) = Error<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Error<T>;

  /// The value when successful, otherwise `null`.
  T? get valueOrNull => switch (this) {
    Success(:final value) => value,
    Error() => null,
  };

  /// The failure when unsuccessful, otherwise `null`.
  Failure? get failureOrNull => switch (this) {
    Success() => null,
    Error(:final failure) => failure,
  };

  /// Transforms the value, leaving a failure untouched.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Success(:final value) => Success(transform(value)),
    Error(:final failure) => Error(failure),
  };

  /// Chains another fallible step after a success.
  Result<R> flatMap<R>(Result<R> Function(T value) next) => switch (this) {
    Success(:final value) => next(value),
    Error(:final failure) => Error(failure),
  };

  /// Reduces both branches to a single value.
  R fold<R>(
    R Function(Failure failure) onFailure,
    R Function(T value) onSuccess,
  ) => switch (this) {
    Success(:final value) => onSuccess(value),
    Error(:final failure) => onFailure(failure),
  };
}

@immutable
final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;

  @override
  bool operator ==(Object other) => other is Success<T> && other.value == value;

  @override
  int get hashCode => Object.hash(Success, value);

  @override
  String toString() => 'Success($value)';
}

@immutable
final class Error<T> extends Result<T> {
  const Error(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) =>
      other is Error<T> && other.failure == failure;

  @override
  int get hashCode => Object.hash(Error, failure);

  @override
  String toString() => 'Error($failure)';
}

/// Convenience alias for operations that succeed with no payload.
typedef UnitResult = Result<void>;

/// Shorthand for an async [Result].
typedef FutureResult<T> = Future<Result<T>>;
