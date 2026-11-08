import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/otp_code.dart';
import 'package:j_donuts/features/auth/domain/validators/otp_validator.dart';

void main() {
  group('OtpValidator.validate', () {
    test('accepts exactly six digits', () {
      expect(OtpValidator.validate('123456'), const Success(OtpCode('123456')));
    });

    test('trims surrounding whitespace from a pasted code', () {
      expect(OtpValidator.validate(' 123456 ').isSuccess, isTrue);
    });

    test('rejects fewer than six digits as incomplete', () {
      expect(_ruleOf(OtpValidator.validate('12345')), _incomplete);
      expect(_ruleOf(OtpValidator.validate('')), _incomplete);
    });

    test('rejects more than six digits as incomplete', () {
      expect(_ruleOf(OtpValidator.validate('1234567')), _incomplete);
    });

    test('rejects letters and symbols', () {
      expect(_ruleOf(OtpValidator.validate('12a456')), _notDigits);
      expect(_ruleOf(OtpValidator.validate('12-456')), _notDigits);
    });

    test('does not leak the code when printed', () {
      expect(const OtpCode('123456').toString(), isNot(contains('123456')));
    });
  });
}

const OtpValidationError _incomplete = OtpValidationError.incomplete;
const OtpValidationError _notDigits = OtpValidationError.notDigits;

Enum? _ruleOf(Result<Object?> result) =>
    (result.failureOrNull as ValidationFailure?)?.rule;
