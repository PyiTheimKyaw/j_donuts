import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/features/auth/presentation/widgets/progress_ring.dart';

import '../../../helpers/pump_app.dart';

void main() {
  Finder ringPainter() => find.descendant(
    of: find.byType(ProgressRing),
    matching: find.byKey(const ValueKey('ring')),
  );

  group('ProgressRing', () {
    testWidgets('paints at full size for a partial step', (tester) async {
      await tester.pumpScreen(
        const Scaffold(body: ProgressRing(step: 1, totalSteps: 4)),
      );

      expect(
        tester.getSize(ringPainter()),
        const Size.square(AppSizes.progressRing),
      );
    });

    testWidgets('shows a check instead of the ring when complete', (
      tester,
    ) async {
      await tester.pumpScreen(
        const Scaffold(body: ProgressRing(step: 4, totalSteps: 4)),
      );

      expect(ringPainter(), findsNothing);
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });

    testWidgets('announces the step for screen readers', (tester) async {
      await tester.pumpScreen(
        const Scaffold(body: ProgressRing(step: 2, totalSteps: 4)),
      );

      expect(
        find.bySemanticsLabel(tester.l10n.progressStep(2, 4)),
        findsOneWidget,
      );
    });
  });
}
