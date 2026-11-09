import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/time/clock.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_controller.dart';
import 'package:j_donuts/features/auth/presentation/session/session_controller.dart';
import 'package:j_donuts/features/auth/presentation/session/welcome_pending.dart';

import '../../../helpers/test_overrides.dart';

void main() {
  late ProviderContainer container;

  AuthFlowController controller() =>
      container.read(authFlowControllerProvider.notifier);

  setUp(() => container = ProviderContainer(overrides: testOverrides()));
  tearDown(() => container.dispose());

  group('AuthFlowController', () {
    test('keeps the intent set before any screen listens', () async {
      controller().start(AuthIntent.logIn);
      await container.pump();

      expect(
        container.read(authFlowControllerProvider).intent,
        AuthIntent.logIn,
      );
    });

    test('start clears input left over from a previous flow', () {
      controller()
        ..start(AuthIntent.register)
        ..phoneChanged('09254135592')
        ..start(AuthIntent.logIn);

      final state = container.read(authFlowControllerProvider);
      expect(state.phoneInput, isEmpty);
      expect(state.phone, isNull);
    });

    test('a valid number is parsed as it is typed', () {
      controller().phoneChanged('09 254-135 592');

      expect(
        container.read(authFlowControllerProvider).phone,
        const PhoneNumber('9254135592'),
      );
    });

    test(
      'logging in with an unknown number reports NotRegisteredFailure',
      () async {
        controller()
          ..start(AuthIntent.logIn)
          ..phoneChanged('09254135592');

        final advanced = await controller().submitPhone();

        expect(advanced, isFalse);
        expect(
          container.read(authFlowControllerProvider).error,
          isA<NotRegisteredFailure>(),
        );
      },
    );

    test('a second submit while one is in flight is ignored', () async {
      controller().phoneChanged('09254135592');

      final first = controller().submitPhone();
      final second = await controller().submitPhone();

      expect(second, isFalse);
      expect(await first, isTrue);
    });

    test('switchToRegister clears the not-registered error', () async {
      controller()
        ..start(AuthIntent.logIn)
        ..phoneChanged('09254135592');
      await controller().submitPhone();

      controller().switchToRegister();

      final state = container.read(authFlowControllerProvider);
      expect(state.intent, AuthIntent.register);
      expect(state.error, isNull);
      expect(state.phone, isNotNull);
    });
  });

  group('AuthFlowController OTP', () {
    Future<void> reachOtp() async {
      controller().phoneChanged('09254135592');
      await controller().submitPhone();
    }

    test('a wrong code reports attempts left without locking', () async {
      await reachOtp();

      final outcome = await controller().verifyOtp('000000');

      final state = container.read(authFlowControllerProvider);
      expect(outcome, isNull);
      expect(state.error, const InvalidOtpFailure(attemptsLeft: 2));
      expect(state.isOtpLocked, isFalse);
    });

    test('the third wrong code locks and further codes are ignored', () async {
      await reachOtp();
      for (var i = 0; i < 3; i++) {
        await controller().verifyOtp('000000');
      }

      final outcome = await controller().verifyOtp('123456');

      expect(container.read(authFlowControllerProvider).isOtpLocked, isTrue);
      expect(outcome, isNull);
    });

    test('resending lifts the lock', () async {
      await reachOtp();
      for (var i = 0; i < 3; i++) {
        await controller().verifyOtp('000000');
      }

      final sent = await controller().resendOtp();

      final state = container.read(authFlowControllerProvider);
      expect(sent, isTrue);
      expect(state.isOtpLocked, isFalse);
      expect(state.error, isNull);
    });

    test('an incomplete code is not sent', () async {
      await reachOtp();

      expect(await controller().verifyOtp('123'), isNull);
      expect(container.read(authFlowControllerProvider).error, isNull);
    });

    test('a new number yields NewUser and no session', () async {
      await reachOtp();

      final outcome = await controller().verifyOtp('123456');

      expect(outcome, isA<NewUser>());
      expect(await container.read(sessionControllerProvider.future), isNull);
    });
  });

  group('AuthFlowController registration', () {
    Future<void> fillValidDetails() async {
      controller()
        ..start(AuthIntent.register)
        ..phoneChanged('09254135592')
        ..firstNameChanged('Ye Min')
        ..lastNameChanged('')
        ..birthMonthChanged(5)
        ..birthDayChanged(1)
        ..birthYearChanged(1980);
    }

    test('signs in and marks Welcome as pending', () async {
      await fillValidDetails();

      final registered = await controller().completeRegistration();

      expect(registered, isTrue);
      expect(container.read(welcomePendingProvider), isTrue);
      expect(
        (await container.read(sessionControllerProvider.future))?.phone,
        const PhoneNumber('9254135592'),
      );
    });

    test('refuses to submit an invalid date', () async {
      await fillValidDetails();
      controller().birthDayChanged(31);
      controller().birthMonthChanged(4);

      expect(await controller().completeRegistration(), isFalse);
      expect(container.read(welcomePendingProvider), isFalse);
    });

    test('starting a new flow clears a pending Welcome', () async {
      await fillValidDetails();
      await controller().completeRegistration();

      controller().start(AuthIntent.logIn);

      expect(container.read(welcomePendingProvider), isFalse);
    });

    test('judges age against the injected clock', () {
      final local = ProviderContainer(
        overrides: [
          ...testOverrides(),
          clockProvider.overrideWithValue(() => DateTime(2026, 11, 8)),
        ],
      );
      addTearDown(local.dispose);
      local.read(authFlowControllerProvider.notifier)
        ..birthMonthChanged(11)
        ..birthDayChanged(9)
        ..birthYearChanged(2013);

      expect(
        local
            .read(authFlowControllerProvider.notifier)
            .birthDateResult
            .isFailure,
        isTrue,
      );
    });
  });
}
