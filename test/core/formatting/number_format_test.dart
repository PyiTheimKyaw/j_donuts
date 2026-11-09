import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/formatting/number_format.dart';

void main() {
  group('formatGrouped', () {
    test('adds thousands separators', () {
      expect(formatGrouped(3200, locale: 'en'), '3,200');
      expect(formatGrouped(680000, locale: 'en'), '680,000');
    });

    test('leaves small numbers alone', () {
      expect(formatGrouped(500, locale: 'en'), '500');
      expect(formatGrouped(0, locale: 'en'), '0');
    });
  });
}
