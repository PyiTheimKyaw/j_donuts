import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/features/rewards/presentation/screens/rewards_screen.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/challenge_card.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/donut_ring_painters.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/earn_button.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/points_ring.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/signed_in_app.dart';

void main() {
  /// The Earn pulse repeats for as long as a challenge is complete, so the
  /// screen never settles; pump past every entrance instead.
  Future<void> openRewards(WidgetTester tester) async {
    await tester.pumpSignedInApp();
    await tester.tap(find.bySemanticsLabel(tester.l10n.tabReward).last);
    await tester.pump();
    await tester.pump(AppDurations.countUp + AppDurations.emphasis);
    await tester.pump(AppDurations.slow);
  }

  String ringTotal(WidgetTester tester) =>
      tester.widget<Text>(find.byKey(const Key('points-ring-total'))).data!;

  group('Rewards header', () {
    testWidgets('counts the total up to the member points', (tester) async {
      await tester.pumpSignedInApp();
      await tester.tap(find.bySemanticsLabel(tester.l10n.tabReward).last);
      await tester.pump();
      await tester.pump(AppDurations.countUp ~/ 4);

      final midway = ringTotal(tester);
      await tester.pump(AppDurations.countUp);

      expect(midway, isNot('680,000'));
      expect(ringTotal(tester), '680,000');
      expect(find.byType(RewardsScreen), findsOneWidget);
    });

    testWidgets('ladder shows where the member is and what is next', (
      tester,
    ) async {
      await openRewards(tester);

      expect(find.text(tester.l10n.tierYouAreHere), findsOneWidget);
      expect(
        find.text(tester.l10n.tierRemaining('500', tester.l10n.tierGold)),
        findsOneWidget,
      );
      expect(find.text(tester.l10n.tierSoon), findsOneWidget);
    });

    testWidgets('shows the rewards badge with the count from data', (
      tester,
    ) async {
      await openRewards(tester);

      expect(find.byKey(const Key('rewards-badge')), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(const Key('rewards-badge')),
          matching: find.text('3'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('the ring stops at the member tier progress', (tester) async {
      await openRewards(tester);

      final ring = tester.widget<PointsRing>(find.byType(PointsRing));
      expect(ring.progress, closeTo(1200 / 1700, 1e-9));
    });
  });

  group('Rewards challenges', () {
    testWidgets('Eat more earn more lists the earn challenges', (tester) async {
      await openRewards(tester);

      expect(find.byType(ChallengeCard), findsNWidgets(3));
      expect(find.text('4/4'), findsOneWidget);
      expect(find.text('9/12'), findsOneWidget);
    });

    testWidgets('only a completed challenge has an active Earn button', (
      tester,
    ) async {
      await openRewards(tester);

      final buttons = tester.widgetList<EarnButton>(find.byType(EarnButton));
      expect(buttons.where((b) => b.isActive), hasLength(1));
    });

    testWidgets('the Gift tab swaps the list', (tester) async {
      await openRewards(tester);

      await tester.tap(find.text(tester.l10n.gift));
      await tester.pump();
      await tester.pump(AppDurations.slow + AppDurations.entrance);

      expect(find.text('Birthday donut on us'), findsOneWidget);
      expect(find.text('Drink 12 cups americano'), findsNothing);
    });
  });

  test('only the caps and the reveal change with progress', () {
    const caps = IcingCapsPainter(progress: 0.5);
    const reveal = SweepRevealClipper(progress: 0.5);

    expect(caps.shouldRepaint(const IcingCapsPainter(progress: 0.5)), isFalse);
    expect(caps.shouldRepaint(const IcingCapsPainter(progress: 0.6)), isTrue);
    expect(
      reveal.shouldReclip(const SweepRevealClipper(progress: 0.6)),
      isTrue,
    );
    expect(
      const IcingRingPainter().shouldRepaint(const IcingRingPainter()),
      isFalse,
      reason: 'the shaded donut is painted once and cached',
    );
  });

  test('the reveal shows the whole donut once complete', () {
    const tile = Size(200, 200);
    final full = const SweepRevealClipper(progress: 1).getClip(tile);
    final none = const SweepRevealClipper(progress: 0).getClip(tile);

    expect(full.contains(const Offset(20, 180)), isTrue);
    expect(none.contains(const Offset(150, 40)), isFalse);
  });
}
