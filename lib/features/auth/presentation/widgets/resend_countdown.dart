import 'dart:async';

import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/formatting/duration_format.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Owns its timer so the countdown survives rebuilds of the OTP screen and is
/// cancelled with the widget, never leaking past the route.
class ResendCountdown extends StatefulWidget {
  const ResendCountdown({
    required this.onResend,
    this.enabled = true,
    this.cooldown = AuthPolicy.otpResendCooldown,
    super.key,
  });

  /// Returns whether a new code was sent; the timer restarts only then.
  final Future<bool> Function() onResend;
  final bool enabled;
  final Duration cooldown;

  @override
  State<ResendCountdown> createState() => _ResendCountdownState();
}

class _ResendCountdownState extends State<ResendCountdown> {
  static const Duration _tick = Duration(seconds: 1);

  late Duration _remaining;
  Timer? _timer;
  bool _isResending = false;

  bool get _canResend => _remaining == Duration.zero;

  @override
  void initState() {
    super.initState();
    _restart();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _restart() {
    _timer?.cancel();
    _remaining = widget.cooldown;
    _timer = Timer.periodic(_tick, _onTick);
  }

  void _onTick(Timer timer) {
    final next = _remaining - _tick;
    if (next <= Duration.zero) timer.cancel();
    setState(() => _remaining = next.isNegative ? Duration.zero : next);
  }

  Future<void> _resend() async {
    setState(() => _isResending = true);
    final sent = await widget.onResend();
    if (!mounted) return;
    setState(() {
      _isResending = false;
      if (sent) _restart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.otpDidntReceive, style: AppTypography.body),
        AnimatedSwitcher(
          duration: AppMotion.scaled(context, AppDurations.medium),
          child: _canResend
              ? _ResendButton(
                  key: const ValueKey('resend'),
                  label: l10n.otpResend,
                  onPressed: widget.enabled && !_isResending ? _resend : null,
                )
              : _CountdownText(
                  key: const ValueKey('countdown'),
                  remaining: _remaining,
                  l10n: l10n,
                ),
        ),
      ],
    );
  }
}

class _CountdownText extends StatelessWidget {
  const _CountdownText({
    required this.remaining,
    required this.l10n,
    super.key,
  });

  final Duration remaining;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTypography.body,
        children: [
          TextSpan(text: l10n.otpResendIn),
          TextSpan(
            text: formatMinutesSeconds(remaining),
            style: const TextStyle(
              color: AppColors.accent,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          TextSpan(text: l10n.otpResendUnit),
        ],
      ),
    );
  }
}

class _ResendButton extends StatelessWidget {
  const _ResendButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('otp-resend'),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accent,
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, AppSizes.minTapTarget),
        alignment: Alignment.centerLeft,
      ),
      child: Text(
        label,
        style: AppTypography.body.copyWith(
          color: onPressed == null ? AppColors.disabledInk : AppColors.accent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
