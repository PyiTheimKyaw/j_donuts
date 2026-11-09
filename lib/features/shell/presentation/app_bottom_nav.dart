import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';

class AppNavDestination {
  const AppNavDestination({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// The selected slot widens to the pill's width and the others share the rest,
/// so the pill never covers a neighbour's icon. Pill position and slot widths
/// animate together, which reads as the pill sliding.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<AppNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const double barHeight = 72;
  static const double pillHeight = 44;
  static const double pillWidthInSlots = 1.7;
  static const double iconSize = 24;

  /// The bar floats inside the screen edges over a pink band that fills the
  /// bottom of the screen, as in the design.
  static const double sideMargin = AppSpacing.lg;
  static const double pinkBandFraction = 0.45;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return SizedBox(
      height: barHeight + bottomInset,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: barHeight * pinkBandFraction + bottomInset,
            child: const ColoredBox(
              key: Key('nav-pink-band'),
              color: AppColors.accent,
            ),
          ),
          Positioned.fill(
            left: sideMargin,
            right: sideMargin,
            child: Container(
              key: const Key('nav-bar-surface'),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppRadii.xl),
                ),
              ),
              padding: EdgeInsets.only(bottom: bottomInset),
              child: LayoutBuilder(builder: _buildBar),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, BoxConstraints constraints) {
    final innerWidth = constraints.maxWidth - AppSpacing.sm * 2;
    final evenSlot = innerWidth / destinations.length;
    final pillWidth = evenSlot * pillWidthInSlots;
    final otherSlot = (innerWidth - pillWidth) / (destinations.length - 1);
    final duration = AppMotion.scaled(context, AppDurations.slow);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: duration,
            curve: AppCurves.emphasized,
            left: otherSlot * selectedIndex,
            top: (barHeight - pillHeight) / 2,
            width: pillWidth,
            height: pillHeight,
            child: _Pill(
              destination: destinations[selectedIndex],
              duration: duration,
            ),
          ),
          _SlotRow(
            destinations: destinations,
            selectedIndex: selectedIndex,
            onSelected: onSelected,
            selectedWidth: pillWidth,
            otherWidth: otherSlot,
            duration: duration,
          ),
        ],
      ),
    );
  }
}

/// Slots resize in step with the pill so labels never sit under it mid-slide.
class _SlotRow extends StatelessWidget {
  const _SlotRow({
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    required this.selectedWidth,
    required this.otherWidth,
    required this.duration,
  });

  final List<AppNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final double selectedWidth;
  final double otherWidth;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final (index, destination) in destinations.indexed)
          AnimatedContainer(
            duration: duration,
            curve: AppCurves.emphasized,
            width: index == selectedIndex ? selectedWidth : otherWidth,
            child: _Slot(
              destination: destination,
              isSelected: index == selectedIndex,
              onTap: () => onSelected(index),
            ),
          ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.destination, required this.duration});

  final AppNavDestination destination;
  final Duration duration;

  static const double _borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.onPrimary, width: _borderWidth),
      ),
      child: AnimatedSwitcher(
        duration: duration,
        child: FittedBox(
          key: ValueKey(destination.label),
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  destination.icon,
                  color: AppColors.onPrimary,
                  size: AppBottomNav.iconSize,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  destination.label,
                  style: AppTypography.label.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Slot extends StatelessWidget {
  const _Slot({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final AppNavDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: destination.label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: AppSizes.minTapTarget / 2,
        child: Center(
          child: AnimatedOpacity(
            opacity: isSelected ? 0 : 1,
            duration: AppMotion.scaled(context, AppDurations.fast),
            child: Icon(
              destination.icon,
              color: AppColors.onPrimary,
              size: AppBottomNav.iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
