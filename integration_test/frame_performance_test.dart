import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:j_donuts/app/app.dart';
import 'package:j_donuts/features/auth/auth_providers.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/home/presentation/screens/home_screen.dart';
import 'package:j_donuts/features/rewards/presentation/screens/rewards_screen.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

import 'integration_overrides.dart';

const RegistrationDetails _member = RegistrationDetails(
  phone: PhoneNumber('9254135592'),
  name: PersonName(firstName: 'Hania', lastName: ''),
  birthDate: BirthDate(year: 1980, month: 5, day: 1),
);

/// Timings only mean something in profile mode on a real phone:
///
/// ```sh
/// flutter drive --profile --driver=test_driver/perf_driver.dart \
///   --target=integration_test/frame_performance_test.dart -d DEVICE_ID
/// ```
///
/// The member is registered through the repository rather than the UI, so
/// the measured frames are only the screens under test, not keyboard input.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Home scrolling and the Rewards entrance', (tester) async {
    final container = ProviderContainer(overrides: integrationOverrides());
    addTearDown(container.dispose);
    await container.read(authRepositoryProvider).register(_member);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const JDonutsApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
    final l10n = AppLocalizations.of(tester.element(find.byType(HomeScreen)));

    final homeScroll = find
        .descendant(
          of: find.byType(HomeScreen),
          matching: find.byType(Scrollable),
        )
        .first;
    await binding.watchPerformance(() async {
      for (var pass = 0; pass < 3; pass++) {
        await tester.fling(homeScroll, const Offset(0, -800), 2000);
        await tester.pumpAndSettle();
        await tester.fling(homeScroll, const Offset(0, 800), 2000);
        await tester.pumpAndSettle();
      }
    }, reportKey: 'home_scroll');

    // Rewards never settles (Earn pulses), so frames are produced by the
    // engine's own vsync rather than by explicit pumps.
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    await binding.watchPerformance(() async {
      for (var pass = 0; pass < 3; pass++) {
        await tester.tap(find.bySemanticsLabel(l10n.tabReward).last);
        await tester.pump(const Duration(seconds: 3));
        expect(find.byType(RewardsScreen), findsOneWidget);
        await tester.tap(find.bySemanticsLabel(l10n.tabHome).last);
        await tester.pump(const Duration(seconds: 1));
      }
    }, reportKey: 'rewards_entrance');
  });
}
