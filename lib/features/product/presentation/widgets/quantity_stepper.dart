import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// The number slides in from the direction of the change (up when it grows,
/// down when it shrinks), so the motion itself tells the user what happened.
class QuantityStepper extends StatefulWidget {
  const QuantityStepper({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
    super.key,
  });

  final int value;

  /// `null` disables the button, e.g. at the minimum quantity.
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  static const double buttonSize = 32;
  static const double _valueWidth = 44;

  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  int _direction = 1;

  @override
  void didUpdateWidget(covariant QuantityStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _direction = widget.value > oldWidget.value ? 1 : -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.surface, width: 3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RoundButton(
            key: const Key('quantity-decrement'),
            icon: Icons.remove_rounded,
            semanticLabel: l10n.decreaseQuantity,
            onPressed: widget.onDecrement,
          ),
          SizedBox(
            width: QuantityStepper._valueWidth,
            child: Semantics(
              label: l10n.quantity,
              value: '${widget.value}',
              liveRegion: true,
              child: _AnimatedValue(value: widget.value, direction: _direction),
            ),
          ),
          _RoundButton(
            key: const Key('quantity-increment'),
            icon: Icons.add_rounded,
            semanticLabel: l10n.increaseQuantity,
            onPressed: widget.onIncrement,
          ),
        ],
      ),
    );
  }
}

class _AnimatedValue extends StatelessWidget {
  const _AnimatedValue({required this.value, required this.direction});

  final int value;
  final int direction;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedSwitcher(
        duration: AppMotion.scaled(context, AppDurations.medium),
        switchInCurve: AppCurves.standard,
        switchOutCurve: AppCurves.standard,
        transitionBuilder: (child, animation) {
          final entering = child.key == ValueKey(value);
          final from = Offset(0, entering ? direction * 0.8 : -direction * 0.8);
          return SlideTransition(
            position: Tween(begin: from, end: Offset.zero).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Text(
          '$value',
          key: ValueKey(value),
          textAlign: TextAlign.center,
          style: AppTypography.headline,
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;

    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onPressed,
        radius: AppSizes.minTapTarget / 2,
        child: SizedBox.square(
          dimension: AppSizes.minTapTarget,
          child: Center(
            child: AnimatedContainer(
              duration: AppMotion.scaled(context, AppDurations.fast),
              width: QuantityStepper.buttonSize,
              height: QuantityStepper.buttonSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: enabled ? AppColors.primary : AppColors.disabledFill,
              ),
              child: Icon(icon, color: AppColors.onPrimary, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
