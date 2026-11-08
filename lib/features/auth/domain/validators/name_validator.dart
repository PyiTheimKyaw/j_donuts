import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';

enum NameValidationError { required, tooLong, invalidCharacters }

/// `\p{M}` is required because Myanmar vowel signs and medials are combining
/// marks, not letters. Digits in any script are excluded by omitting `\p{N}`.
abstract final class NameValidator {
  static final RegExp _allowed = RegExp(
    r'^[\p{L}\p{M}\p{Zs}]+$',
    unicode: true,
  );

  static Result<String> validateFirst(String raw) {
    final name = raw.trim();
    if (name.isEmpty) {
      return const Result.failure(
        ValidationFailure(NameValidationError.required),
      );
    }
    return _validateCharacters(name).map((_) => name);
  }

  /// Empty input is a valid absent last name.
  static Result<String?> validateLast(String? raw) {
    final name = raw?.trim() ?? '';
    if (name.isEmpty) return const Result.success(null);
    return _validateCharacters(name).map((_) => name);
  }

  static Result<void> _validateCharacters(String name) {
    if (name.runes.length > AuthPolicy.maxNameLength) {
      return const Result.failure(
        ValidationFailure(NameValidationError.tooLong),
      );
    }
    if (!_allowed.hasMatch(name)) {
      return const Result.failure(
        ValidationFailure(NameValidationError.invalidCharacters),
      );
    }
    return const Result.success(null);
  }
}
