import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/domain/entities/otp_code.dart';

enum OtpValidationError { incomplete, notDigits }

/// Shape only; whether the code is correct is the repository's concern.
abstract final class OtpValidator {
  static final RegExp _digitsOnly = RegExp(r'^\d+$');

  static Result<OtpCode> validate(String raw) {
    final code = raw.trim();
    if (code.isNotEmpty && !_digitsOnly.hasMatch(code)) {
      return const Result.failure(
        ValidationFailure(OtpValidationError.notDigits),
      );
    }
    if (code.length != AuthPolicy.otpLength) {
      return const Result.failure(
        ValidationFailure(OtpValidationError.incomplete),
      );
    }
    return Result.success(OtpCode(code));
  }
}
