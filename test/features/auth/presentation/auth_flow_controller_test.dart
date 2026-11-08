import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_controller.dart';

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
}
