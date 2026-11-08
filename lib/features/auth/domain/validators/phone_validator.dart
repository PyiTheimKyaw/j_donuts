import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/phone_number.dart';

/// Reasons a phone number is rejected.
enum PhoneValidationError { empty, invalidFormat }

/// Validates the digits a user types after the `+95` prefix.
///
/// Spaces, dashes and one leading zero are stripped; the remainder must be a
/// `9` followed by 7 to 9 digits. `09254135592` becomes `+959254135592`.
abstract final class PhoneValidator {
  static final RegExp _separators = RegExp(r'[\s\-]');
  static final RegExp _nationalFormat = RegExp(r'^9\d{7,9}$');
  static final RegExp _partialFormat = RegExp(r'^9\d{0,9}$');

  /// International prefixes a user might paste along with the number.
  static final RegExp _countryPrefix = RegExp(r'^(\+95|0095|95)(?=0?9)');

  /// Returns the canonical [PhoneNumber], or a [ValidationFailure] whose
  /// `rule` is a [PhoneValidationError].
  static Result<PhoneNumber> validate(String raw) {
    final national = normalise(raw);
    if (national.isEmpty) {
      return const Result.failure(
        ValidationFailure(PhoneValidationError.empty),
      );
    }
    if (!_nationalFormat.hasMatch(national)) {
      return const Result.failure(
        ValidationFailure(PhoneValidationError.invalidFormat),
      );
    }
    return Result.success(PhoneNumber(national));
  }

  /// Strips separators, an optional pasted country prefix and one leading
  /// zero. Does not check the result; see [validate].
  static String normalise(String raw) {
    var digits = raw.replaceAll(_separators, '');
    digits = digits.replaceFirst(_countryPrefix, '');
    if (digits.startsWith('0')) digits = digits.substring(1);
    return digits;
  }

  /// True when [raw] can still become valid with more typing, so the UI can
  /// hold back the error message until the field loses focus.
  static bool isPartial(String raw) {
    final national = normalise(raw);
    return national.isEmpty || _partialFormat.hasMatch(national);
  }
}
