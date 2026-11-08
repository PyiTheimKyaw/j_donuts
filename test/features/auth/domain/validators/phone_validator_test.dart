import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/entities/phone_number.dart';
import 'package:j_donuts/features/auth/domain/validators/phone_validator.dart';

void main() {
  group('PhoneValidator.validate', () {
    test('accepts 09254135592 and normalises it to +959254135592', () {
      final result = PhoneValidator.validate('09254135592');

      expect(result, const Success(PhoneNumber('9254135592')));
      expect(result.valueOrNull?.e164, '+959254135592');
    });

    test('strips spaces and dashes before checking', () {
      final result = PhoneValidator.validate('09 254-135 592');

      expect(result.valueOrNull?.e164, '+959254135592');
    });

    test('strips only one leading zero', () {
      expect(PhoneValidator.validate('009254135592').isFailure, isTrue);
    });

    test('accepts a number typed without the leading zero', () {
      expect(PhoneValidator.validate('9254135592').isSuccess, isTrue);
    });

    test('accepts a pasted international number', () {
      expect(PhoneValidator.validate('+95 9 254 135 592').isSuccess, isTrue);
      expect(PhoneValidator.validate('+9509254135592').isSuccess, isTrue);
    });

    test('accepts 9 followed by 7, 8 and 9 digits', () {
      expect(PhoneValidator.validate('091234567').isSuccess, isTrue); // 9+7
      expect(PhoneValidator.validate('0912345678').isSuccess, isTrue); // 9+8
      expect(PhoneValidator.validate('09123456789').isSuccess, isTrue); // 9+9
    });

    test('rejects 9 followed by 6 or 10 digits', () {
      expect(_ruleOf(PhoneValidator.validate('09123456')), _invalidFormat);
      expect(_ruleOf(PhoneValidator.validate('091234567890')), _invalidFormat);
    });

    test('rejects a number that does not start with 9', () {
      expect(_ruleOf(PhoneValidator.validate('0812345678')), _invalidFormat);
    });

    test('rejects letters and punctuation', () {
      expect(_ruleOf(PhoneValidator.validate('09abc135592')), _invalidFormat);
      expect(
        _ruleOf(PhoneValidator.validate('09.254.135.592')),
        _invalidFormat,
      );
    });

    test('reports empty input as its own error', () {
      expect(_ruleOf(PhoneValidator.validate('')), PhoneValidationError.empty);
      expect(
        _ruleOf(PhoneValidator.validate(' - ')),
        PhoneValidationError.empty,
      );
    });
  });

  group('PhoneValidator.isPartial', () {
    test('treats a prefix of a valid number as still being typed', () {
      expect(PhoneValidator.isPartial(''), isTrue);
      expect(PhoneValidator.isPartial('0'), isTrue);
      expect(PhoneValidator.isPartial('09'), isTrue);
      expect(PhoneValidator.isPartial('0925'), isTrue);
    });

    test('flags input that can never become valid', () {
      expect(PhoneValidator.isPartial('08'), isFalse);
      expect(PhoneValidator.isPartial('09a'), isFalse);
      expect(PhoneValidator.isPartial('091234567890'), isFalse);
    });
  });

  group('PhoneNumber', () {
    test('exposes e164 and local forms', () {
      const phone = PhoneNumber('9254135592');

      expect(phone.e164, '+959254135592');
      expect(phone.local, '09254135592');
      expect(phone.toString(), '+959254135592');
    });

    test('is equal by value', () {
      expect(const PhoneNumber('9254135592'), const PhoneNumber('9254135592'));
    });
  });
}

const PhoneValidationError _invalidFormat = PhoneValidationError.invalidFormat;

Enum? _ruleOf(Result<Object?> result) =>
    (result.failureOrNull as ValidationFailure?)?.rule;
