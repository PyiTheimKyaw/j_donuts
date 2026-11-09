import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/data/mappers/user_mapper.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';

void main() {
  group('UserMapper birth date', () {
    test('formats as zero-padded yyyy-MM-dd', () {
      const date = BirthDate(year: 1980, month: 5, day: 1);

      expect(UserMapper.formatBirthDate(date), '1980-05-01');
    });

    test('parses back to the same value', () {
      const date = BirthDate(year: 2004, month: 2, day: 29);

      expect(UserMapper.parseBirthDate(UserMapper.formatBirthDate(date)), date);
    });
  });
}
