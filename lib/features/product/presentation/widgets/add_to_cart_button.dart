import 'dart:async';

import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// No cart exists yet, so the feedback is purely visual: the button scales on
/// press, then briefly morphs into a confirmation before returning.
class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    required this.totalLabel,
    required this.onAdded,
    super.key,
  });

  /// Already formatted (`3,200 MMK`); it cross-fades whenever it changes.
  final String totalLabel;
  final VoidCallback onAdded;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _pressed = false;
  bool _confirming = false;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  void _add() {
    widget.onAdded();
    setState(() => _confirming = true);
    _resetTimer?.cancel();
    _resetTimer = Timer(AppDurations.confirmationHold, () {
      if (mounted) setState(() => _confirming = false);
    });
  }

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _setPressed(true),
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? AppMotionScales.pressed : 1,
        duration: AppMotion.scaled(context, AppDurations.fast),
        child: FilledButton(
          key: const Key('add-to-cart'),
          onPressed: _add,
          style: FilledButton.styleFrom(
            backgroundColor: _confirming ? AppColors.success : null,
          ),
          // Large totals and the longer Burmese label must shrink to fit
          // rather than overflow the button.
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: _SwitchingLabel(
              confirming: _confirming,
              totalLabel: widget.totalLabel,
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchingLabel extends StatelessWidget {
  const _SwitchingLabel({required this.confirming, required this.totalLabel});

  final bool confirming;
  final String totalLabel;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.scaled(context, AppDurations.medium);

    return AnimatedSwitcher(
      duration: duration,
      child: confirming
          ? const _AddedLabel(key: ValueKey('added'))
          : _AddLabel(
              key: const ValueKey('add'),
              totalLabel: totalLabel,
              duration: duration,
            ),
    );
  }
}

class _AddedLabel extends StatelessWidget {
  const _AddedLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_rounded),
        const SizedBox(width: AppSpacing.sm),
        Text(AppLocalizations.of(context).addedShort.toUpperCase()),
      ],
    );
  }
}

class _AddLabel extends StatelessWidget {
  const _AddLabel({
    required this.totalLabel,
    required this.duration,
    super.key,
  });

  final String totalLabel;
  final Duration duration;

  static const double _dividerWidth = 1;
  static const double _dividerHeight = 18;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(AppLocalizations.of(context).addToCart.toUpperCase()),
        Container(
          width: _dividerWidth,
          height: _dividerHeight,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          color: AppColors.onPrimary,
        ),
        AnimatedSwitcher(
          duration: duration,
          child: Text(
            totalLabel,
            key: ValueKey(totalLabel),
            style: AppTypography.button,
          ),
        ),
      ],
    );
  }
}
