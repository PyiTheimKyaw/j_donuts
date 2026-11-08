import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';

/// Reasons a name is rejected.
enum NameValidationError { required, tooLong, invalidCharacters }

/// Validates first and last names.
///
/// Allowed: letters from any script, their combining marks (Myanmar vowel
/// signs and medials are marks, not letters) and spaces. Digits in any
/// script, punctuation and symbols are rejected. Length is counted in
/// Unicode code points after trimming, up to [AuthPolicy.maxNameLength].
abstract final class NameValidator {
  static final RegExp _allowed = RegExp(
    r'^[\p{L}\p{M}\p{Zs}]+$',
    unicode: true,
  );

  /// First name is required.
  static Result<String> validateFirst(String raw) {
    final name = raw.trim();
    if (name.isEmpty) {
      return const Result.failure(
        ValidationFailure(NameValidationError.required),
      );
    }
    return _validateCharacters(name).map((_) => name);
  }

  /// Last name is optional; an empty input yields `null`.
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
