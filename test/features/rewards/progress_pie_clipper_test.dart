import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/challenge_art.dart';

void main() {
  const tile = Size(120, 120);

  group('ProgressPieClipper', () {
    test('reveals the whole tile when the challenge is complete', () {
      final clip = const ProgressPieClipper(fraction: 1).getClip(tile);

      expect(clip.contains(const Offset(10, 110)), isTrue);
      expect(clip.contains(const Offset(110, 10)), isTrue);
    });

    test('reveals only the first quarter at 1/4', () {
      final clip = const ProgressPieClipper(fraction: 0.25).getClip(tile);

      expect(clip.contains(const Offset(90, 30)), isTrue, reason: 'top right');
      expect(
        clip.contains(const Offset(30, 90)),
        isFalse,
        reason: 'bottom left',
      );
    });

    test('reveals nothing at zero', () {
      final clip = const ProgressPieClipper(fraction: 0).getClip(tile);

      expect(clip.contains(const Offset(90, 30)), isFalse);
    });
  });
}
