import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Two pills of different widths with one indicator that slides and resizes
/// between them, measured from the labels rather than assuming equal halves.
class RewardTabs extends StatefulWidget {
  const RewardTabs({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final ChallengeTab selected;
  final ValueChanged<ChallengeTab> onSelected;

  static const double height = 44;

  @override
  State<RewardTabs> createState() => _RewardTabsState();
}

class _RewardTabsState extends State<RewardTabs> {
  final Map<ChallengeTab, GlobalKey> _labelKeys = {
    for (final tab in ChallengeTab.values) tab: GlobalKey(),
  };
  final GlobalKey _rowKey = GlobalKey();
  Rect? _indicator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  @override
  void didUpdateWidget(covariant RewardTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    final row = _rowKey.currentContext?.findRenderObject() as RenderBox?;
    final label =
        _labelKeys[widget.selected]?.currentContext?.findRenderObject()
            as RenderBox?;
    if (!mounted || row == null || label == null) return;
    final topLeft = label.localToGlobal(Offset.zero, ancestor: row);
    final rect = topLeft & label.size;
    if (rect != _indicator) setState(() => _indicator = rect);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final indicator = _indicator;
    final duration = AppMotion.scaled(context, AppDurations.slow);

    // Scales down rather than overflowing on narrow phones or large text; the
    // indicator is measured inside the same scaled box, so it stays aligned.
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        height: RewardTabs.height,
        child: Stack(
          key: _rowKey,
          children: [
            if (indicator != null)
              AnimatedPositioned.fromRect(
                rect: indicator,
                duration: duration,
                curve: AppCurves.emphasized,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadii.pill),
                    ),
                  ),
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final tab in ChallengeTab.values) ...[
                  if (tab != ChallengeTab.values.first)
                    const SizedBox(width: AppSpacing.sm),
                  _TabLabel(
                    key: _labelKeys[tab],
                    label: switch (tab) {
                      ChallengeTab.earn => l10n.eatMoreEarnMore,
                      ChallengeTab.gift => l10n.gift,
                    },
                    isSelected: tab == widget.selected,
                    onTap: () => widget.onSelected(tab),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static const double _borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.scaled(context, AppDurations.medium);

    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: duration,
          height: RewardTabs.height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            color: isSelected ? Colors.transparent : AppColors.surface,
            border: Border.all(
              color: isSelected ? Colors.transparent : AppColors.divider,
              width: _borderWidth,
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: duration,
            style: AppTypography.subtitle.copyWith(
              color: isSelected ? AppColors.onPrimary : AppColors.inkSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
