import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/phone_number.dart';

enum PhoneValidationError { empty, invalidFormat }

/// Input is the part typed after `+95`. Exactly one leading zero is stripped
/// so `009...` stays invalid; a pasted country prefix is tolerated.
abstract final class PhoneValidator {
  static final RegExp _separators = RegExp(r'[\s\-]');
  static final RegExp _nationalFormat = RegExp(r'^9\d{7,9}$');
  static final RegExp _partialFormat = RegExp(r'^9\d{0,9}$');

  static final RegExp _countryPrefix = RegExp(r'^(\+95|0095|95)(?=0?9)');

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

  static String normalise(String raw) {
    var digits = raw.replaceAll(_separators, '');
    digits = digits.replaceFirst(_countryPrefix, '');
    if (digits.startsWith('0')) digits = digits.substring(1);
    return digits;
  }

  /// Lets the UI defer the error message until focus is lost.
  static bool isPartial(String raw) {
    final national = normalise(raw);
    return national.isEmpty || _partialFormat.hasMatch(national);
  }
}
