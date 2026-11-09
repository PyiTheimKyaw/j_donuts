import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Visual only, per the brief: it presses but triggers nothing. When the
/// challenge is complete it breathes gently to draw the eye; the pulse is
/// skipped under Reduce Motion since it is pure decoration.
class EarnButton extends StatefulWidget {
  const EarnButton({required this.isActive, super.key});

  final bool isActive;

  static const double width = 88;
  static const double height = 44;

  @override
  State<EarnButton> createState() => _EarnButtonState();
}

class _EarnButtonState extends State<EarnButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: AppDurations.attentionPulse,
  );
  bool _pressed = false;

  static const double _pulseScale = 0.06;
  static const double _glowBlur = 14;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncPulse();
  }

  @override
  void didUpdateWidget(covariant EarnButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncPulse();
  }

  void _syncPulse() {
    final shouldPulse = widget.isActive && !AppMotion.reduceMotion(context);
    if (shouldPulse && !_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    } else if (!shouldPulse) {
      _pulse
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Semantics(
      button: true,
      enabled: widget.isActive,
      label: l10n.earn,
      excludeSemantics: true,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) {
            final breathe = 1 + _pulseScale * _pulse.value;
            final pressScale = _pressed ? AppMotionScales.pressed : 1.0;
            return Transform.scale(scale: breathe * pressScale, child: child);
          },
          child: _Face(isActive: widget.isActive, label: l10n.earn),
        ),
      ),
    );
  }
}

class _Face extends StatelessWidget {
  const _Face({required this.isActive, required this.label});

  final bool isActive;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.scaled(context, AppDurations.medium),
      width: EarnButton.width,
      height: EarnButton.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.disabledFill,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.45),
                  blurRadius: _EarnButtonState._glowBlur,
                ),
              ]
            : null,
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.button.copyWith(
          color: isActive ? AppColors.onPrimary : AppColors.surface,
        ),
      ),
    );
  }
}
