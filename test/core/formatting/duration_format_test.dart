import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/formatting/duration_format.dart';

void main() {
  group('formatMinutesSeconds', () {
    test('formats the full resend cooldown as 5:00', () {
      expect(formatMinutesSeconds(const Duration(minutes: 5)), '5:00');
    });

    test('zero-pads seconds', () {
      expect(
        formatMinutesSeconds(const Duration(minutes: 4, seconds: 8)),
        '4:08',
      );
    });

    test('shows minutes as 0 under a minute', () {
      expect(formatMinutesSeconds(const Duration(seconds: 59)), '0:59');
    });

    test('drops sub-second precision instead of rounding up', () {
      expect(
        formatMinutesSeconds(const Duration(seconds: 1, milliseconds: 999)),
        '0:01',
      );
    });

    test('clamps negative durations to 0:00', () {
      expect(formatMinutesSeconds(const Duration(seconds: -3)), '0:00');
    });
  });
}
