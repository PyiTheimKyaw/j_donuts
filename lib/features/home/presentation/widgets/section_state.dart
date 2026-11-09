import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Renders one Home section's loading, error, empty and data states, cross-
/// fading between them so a section never pops in.
///
/// Data wins over a later error: a refresh that fails after content loaded
/// keeps showing the content rather than replacing it with an error.
class SectionState<T> extends StatelessWidget {
  const SectionState({
    required this.value,
    required this.skeleton,
    required this.builder,
    required this.onRetry,
    this.isEmpty,
    this.height,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget skeleton;
  final Widget Function(T data) builder;
  final VoidCallback onRetry;
  final bool Function(T data)? isEmpty;

  /// Fixed height keeps the page from jumping when the state changes.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final Widget child = switch (value) {
      AsyncValue(hasValue: true, :final T value)
          when isEmpty?.call(value) ?? false =>
        const _SectionMessage(key: ValueKey('empty'), isError: false),
      AsyncValue(hasValue: true, :final T value) => KeyedSubtree(
        key: const ValueKey('data'),
        child: builder(value),
      ),
      AsyncError() => _SectionMessage(
        key: const ValueKey('error'),
        isError: true,
        onRetry: onRetry,
      ),
      _ => KeyedSubtree(key: const ValueKey('loading'), child: skeleton),
    };

    final switcher = AnimatedSwitcher(
      duration: AppMotion.scaled(context, AppDurations.medium),
      child: child,
    );
    return height == null
        ? switcher
        : SizedBox(height: height, child: switcher);
  }
}

class _SectionMessage extends StatelessWidget {
  const _SectionMessage({required this.isError, this.onRetry, super.key});

  final bool isError;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isError ? Icons.cloud_off_rounded : Icons.inbox_outlined,
            color: AppColors.inkTertiary,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            isError ? l10n.sectionError : l10n.sectionEmpty,
            style: AppTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: Text(l10n.retry)),
        ],
      ),
    );
  }
}
