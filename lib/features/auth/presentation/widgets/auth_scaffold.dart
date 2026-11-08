import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/features/auth/presentation/widgets/legal_footer.dart';
import 'package:j_donuts/features/auth/presentation/widgets/progress_ring.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Scrolls only when the keyboard leaves too little room; otherwise [bottom]
/// stays pinned to the foot of the screen.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.body,
    this.bottom,
    this.step,
    this.totalSteps = 4,
    this.showBack = true,
    this.showFooter = true,
    super.key,
  });

  final Widget body;
  final Widget? bottom;
  final int? step;
  final int totalSteps;
  final bool showBack;
  final bool showFooter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.authBackground),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.gutter,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _TopBar(
                          showBack: showBack,
                          step: step,
                          totalSteps: totalSteps,
                        ),
                        Expanded(child: body),
                        if (bottom != null) ...[
                          const SizedBox(height: AppSpacing.xl),
                          bottom!,
                        ],
                        if (showFooter) ...[
                          const SizedBox(height: AppSpacing.xl),
                          const LegalFooter(),
                        ],
                        const SizedBox(height: AppSpacing.lg),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.showBack,
    required this.step,
    required this.totalSteps,
  });

  final bool showBack;
  final int? step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      height: AppSizes.iconButton + AppSpacing.lg * 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showBack)
            _BackButton(label: l10n.back)
          else
            const SizedBox(width: AppSizes.iconButton),
          if (step != null)
            ProgressRing(step: step!, totalSteps: totalSteps)
          else
            const SizedBox(width: AppSizes.progressRing),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.md),
        onTap: () => context.pop(),
        child: SizedBox.square(
          dimension: AppSizes.iconButton,
          child: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.ink,
            semanticLabel: label,
          ),
        ),
      ),
    );
  }
}
