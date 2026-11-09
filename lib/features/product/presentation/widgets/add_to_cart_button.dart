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

  static const double _dividerHeight = 18;

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
    final l10n = AppLocalizations.of(context);
    final duration = AppMotion.scaled(context, AppDurations.medium);

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
            child: AnimatedSwitcher(
              duration: duration,
              child: _confirming
                  ? Row(
                      key: const ValueKey('added'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_rounded),
                        const SizedBox(width: AppSpacing.sm),
                        Text(l10n.addedShort.toUpperCase()),
                      ],
                    )
                  : Row(
                      key: const ValueKey('add'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.addToCart.toUpperCase()),
                        Container(
                          width: 1,
                          height: AddToCartButton._dividerHeight,
                          margin: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                          ),
                          color: AppColors.onPrimary,
                        ),
                        AnimatedSwitcher(
                          duration: duration,
                          child: Text(
                            widget.totalLabel,
                            key: ValueKey(widget.totalLabel),
                            style: AppTypography.button,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
