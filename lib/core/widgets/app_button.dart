import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';

/// Taps are swallowed while [isLoading] so a double tap never sends two
/// requests.
class AppButton extends StatefulWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expand = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expand;

  static const double spinnerSize = 22;
  static const double spinnerStroke = 2.5;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null && !widget.isLoading;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final scale = _pressed && _enabled ? AppMotionScales.pressed : 1.0;

    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.label,
      child: Listener(
        onPointerDown: (_) => _setPressed(true),
        onPointerUp: (_) => _setPressed(false),
        onPointerCancel: (_) => _setPressed(false),
        child: AnimatedScale(
          scale: scale,
          duration: AppMotion.scaled(context, AppDurations.fast),
          curve: AppCurves.standard,
          child: FilledButton(
            onPressed: widget.isLoading ? _ignore : widget.onPressed,
            style: widget.expand
                ? null
                : FilledButton.styleFrom(minimumSize: Size.zero),
            child: _LabelOrSpinner(
              label: widget.label,
              isLoading: widget.isLoading,
            ),
          ),
        ),
      ),
    );
  }

  static void _ignore() {}
}

class _LabelOrSpinner extends StatelessWidget {
  const _LabelOrSpinner({required this.label, required this.isLoading});

  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppMotion.scaled(context, AppDurations.medium),
      switchInCurve: AppCurves.standard,
      switchOutCurve: AppCurves.standard,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
      child: isLoading
          ? const SizedBox(
              key: ValueKey('spinner'),
              width: AppButton.spinnerSize,
              height: AppButton.spinnerSize,
              child: CircularProgressIndicator(
                strokeWidth: AppButton.spinnerStroke,
                color: AppColors.onPrimary,
              ),
            )
          : Padding(
              key: const ValueKey('label'),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Text(label.toUpperCase(), textAlign: TextAlign.center),
            ),
    );
  }
}
