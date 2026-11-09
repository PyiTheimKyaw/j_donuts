import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/domain/validators/name_validator.dart';

void main() {
  group('NameValidator.validateFirst', () {
    test('accepts a Latin name and returns it trimmed', () {
      expect(NameValidator.validateFirst('  Ye Min '), const Success('Ye Min'));
    });

    test('accepts a Myanmar-script name with vowel signs and medials', () {
      // Includes combining marks (U+103B, U+1031), not just letters.
      expect(NameValidator.validateFirst('ကျော်ကျော်').isSuccess, isTrue);
      expect(NameValidator.validateFirst('မြတ် နိုး').isSuccess, isTrue);
    });

    test('accepts accented and non-Latin letters', () {
      expect(NameValidator.validateFirst('Zoë').isSuccess, isTrue);
      expect(NameValidator.validateFirst('李').isSuccess, isTrue);
    });

    test('rejects an empty or whitespace-only name as required', () {
      expect(_ruleOf(NameValidator.validateFirst('')), _required);
      expect(_ruleOf(NameValidator.validateFirst('   ')), _required);
    });

    test('rejects ASCII digits', () {
      expect(_ruleOf(NameValidator.validateFirst('Ye Min 2')), _invalidChars);
    });

    test('rejects Myanmar digits', () {
      expect(_ruleOf(NameValidator.validateFirst('ကျော် ၁')), _invalidChars);
    });

    test('rejects punctuation and symbols', () {
      expect(_ruleOf(NameValidator.validateFirst('Ye-Min')), _invalidChars);
      expect(_ruleOf(NameValidator.validateFirst("O'Brien")), _invalidChars);
      expect(_ruleOf(NameValidator.validateFirst('Ye@Min')), _invalidChars);
    });

    test('accepts exactly the maximum length', () {
      final name = 'a' * AuthPolicy.maxNameLength;

      expect(NameValidator.validateFirst(name).isSuccess, isTrue);
    });

    test('rejects one character over the maximum length', () {
      final name = 'a' * (AuthPolicy.maxNameLength + 1);

      expect(_ruleOf(NameValidator.validateFirst(name)), _tooLong);
    });

    test('measures length after trimming', () {
      final name = '  ${'a' * AuthPolicy.maxNameLength}  ';

      expect(NameValidator.validateFirst(name).isSuccess, isTrue);
    });
  });

  group('NameValidator.validateLast', () {
    test('treats an empty last name as absent', () {
      expect(NameValidator.validateLast(''), const Success<String?>(null));
      expect(NameValidator.validateLast(null), const Success<String?>(null));
      expect(NameValidator.validateLast('   '), const Success<String?>(null));
    });

    test('accepts and trims a provided last name', () {
      expect(
        NameValidator.validateLast(' Phyoe Win '),
        const Success<String?>('Phyoe Win'),
      );
    });

    test('applies the same character rules as the first name', () {
      expect(_ruleOf(NameValidator.validateLast('Win 1')), _invalidChars);
    });

    test('applies the same length rule as the first name', () {
      final name = 'b' * (AuthPolicy.maxNameLength + 1);

      expect(_ruleOf(NameValidator.validateLast(name)), _tooLong);
    });
  });
}

const NameValidationError _required = NameValidationError.required;
const NameValidationError _tooLong = NameValidationError.tooLong;
const NameValidationError _invalidChars = NameValidationError.invalidCharacters;

Enum? _ruleOf(Result<Object?> result) =>
    (result.failureOrNull as ValidationFailure?)?.rule;
