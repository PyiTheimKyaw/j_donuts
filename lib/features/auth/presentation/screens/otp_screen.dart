import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/core/widgets/shake_transition.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_controller.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_state.dart';
import 'package:j_donuts/features/auth/presentation/validation_messages.dart';
import 'package:j_donuts/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:j_donuts/features/auth/presentation/widgets/otp_input.dart';
import 'package:j_donuts/features/auth/presentation/widgets/resend_countdown.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Returning users need no navigation here: a started session makes the
/// router redirect them to Home.
class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  static const int step = 2;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int _shakeCount = 0;

  AuthFlowController get _flow => ref.read(authFlowControllerProvider.notifier);

  @override
  void dispose() {
    _codeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _verify(String code) async {
    final outcome = await _flow.verifyOtp(code);
    if (!mounted) return;
    if (outcome is NewUser) unawaited(context.push(AppRoutes.name));
  }

  void _onFailureChanged(Failure? previous, Failure? next) {
    if (next is! InvalidOtpFailure && next is! OtpLockedFailure) return;
    _codeController.clear();
    setState(() => _shakeCount++);
    if (next is InvalidOtpFailure) _refocusWhenEnabled();
  }

  /// The field is still disabled from the in-flight request in this frame,
  /// and a disabled field drops focus requests.
  void _refocusWhenEnabled() => WidgetsBinding.instance.addPostFrameCallback(
    (_) => mounted ? _focusNode.requestFocus() : null,
  );

  Future<bool> _resend() async {
    final sent = await _flow.resendOtp();
    if (!mounted || !sent) return sent;
    _codeController.clear();
    _refocusWhenEnabled();
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.otpResent)));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Failure?>(
      authFlowControllerProvider.select((state) => state.error),
      _onFailureChanged,
    );
    final state = ref.watch(authFlowControllerProvider);
    final l10n = AppLocalizations.of(context);

    return AuthScaffold(
      step: OtpScreen.step,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EntranceAnimation(
            child: Text(l10n.otpTitle, style: AppTypography.headline),
          ),
          const SizedBox(height: AppSpacing.sm),
          EntranceAnimation(
            index: 1,
            child: Text(
              l10n.otpSubtitle(state.phone?.e164 ?? ''),
              style: AppTypography.body,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          EntranceAnimation(
            index: 2,
            child: ShakeTransition(
              trigger: _shakeCount,
              child: OtpInput(
                key: const Key('otp-input'),
                controller: _codeController,
                focusNode: _focusNode,
                enabled: !state.isOtpLocked && !state.isSubmitting,
                hasError: state.error != null,
                onCompleted: _verify,
              ),
            ),
          ),
          _OtpFeedback(state: state),
          const SizedBox(height: AppSpacing.xl),
          EntranceAnimation(
            index: 3,
            child: ResendCountdown(
              onResend: _resend,
              enabled: !state.isSubmitting,
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpFeedback extends StatelessWidget {
  const _OtpFeedback({required this.state});

  final AuthFlowState state;

  static const double _spinnerSize = 20;
  static const double _spinnerStroke = 2;

  @override
  Widget build(BuildContext context) {
    final message = _message(AppLocalizations.of(context));
    final Widget content;
    if (state.isSubmitting) {
      content = const SizedBox.square(
        key: ValueKey('verifying'),
        dimension: _spinnerSize,
        child: CircularProgressIndicator(
          strokeWidth: _spinnerStroke,
          color: AppColors.primary,
        ),
      );
    } else if (message != null) {
      content = Text(
        message,
        key: ValueKey(message),
        style: AppTypography.bodySmall.copyWith(color: AppColors.error),
      );
    } else {
      content = const SizedBox.shrink(key: ValueKey('idle'));
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: AnimatedSize(
        duration: AppMotion.scaled(context, AppDurations.medium),
        alignment: Alignment.topLeft,
        child: AnimatedSwitcher(
          duration: AppMotion.scaled(context, AppDurations.fast),
          layoutBuilder: (current, previous) => Stack(
            alignment: Alignment.topLeft,
            children: [...previous, ?current],
          ),
          child: content,
        ),
      ),
    );
  }

  String? _message(AppLocalizations l10n) => switch (state.error) {
    null => null,
    OtpLockedFailure() => l10n.otpLocked,
    InvalidOtpFailure(:final attemptsLeft) =>
      '${l10n.otpInvalid} ${l10n.otpAttemptsLeft(attemptsLeft)}',
    final Failure failure => failure.localized(l10n),
  };
}
