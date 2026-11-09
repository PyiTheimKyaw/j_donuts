import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';

/// Owns its border so focus and error colours can animate; a plain
/// `InputDecoration` border snaps between states.
class AppTextField extends StatefulWidget {
  const AppTextField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.errorText,
    this.leading,
    this.trailing,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;

  /// An empty string marks the field invalid without repeating a message
  /// that a sibling field already shows.
  final String? errorText;
  final Widget? leading;
  final Widget? trailing;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  static const double borderWidth = 1.5;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _ownedFocusNode = FocusNode();

  FocusNode get _focusNode => widget.focusNode ?? _ownedFocusNode;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _ownedFocusNode).removeListener(_onFocusChanged);
      _focusNode.addListener(_onFocusChanged);
    }
  }

  void _onFocusChanged() => setState(() {});

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _ownedFocusNode.dispose();
    super.dispose();
  }

  Color get _borderColor {
    if (widget.errorText != null) return AppColors.error;
    if (_focusNode.hasFocus) return AppColors.primary;
    return AppColors.surface;
  }

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.scaled(context, AppDurations.fast);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: duration,
          curve: AppCurves.standard,
          height: AppSizes.fieldHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(
              color: _borderColor,
              width: AppTextField.borderWidth,
            ),
          ),
          child: Row(
            children: [
              if (widget.leading != null) ...[
                widget.leading!,
                const SizedBox(width: AppSpacing.lg),
              ],
              Expanded(child: _buildInput()),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
        _AnimatedErrorText(text: widget.errorText),
      ],
    );
  }

  Widget _buildInput() {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      showCursor: !widget.readOnly,
      autofocus: widget.autofocus,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      textCapitalization: widget.textCapitalization,
      style: AppTypography.fieldInput,
      cursorColor: AppColors.primary,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        filled: false,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class _AnimatedErrorText extends StatelessWidget {
  const _AnimatedErrorText({required this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.scaled(context, AppDurations.medium);

    return AnimatedSize(
      duration: duration,
      curve: AppCurves.standard,
      alignment: Alignment.topLeft,
      child: AnimatedSwitcher(
        duration: duration,
        child: text == null || text!.isEmpty
            ? const SizedBox(width: double.infinity)
            : Padding(
                key: ValueKey(text),
                padding: const EdgeInsets.only(
                  top: AppSpacing.sm,
                  left: AppSpacing.xs,
                ),
                child: Text(
                  text!,
                  style: AppTypography.caption.copyWith(color: AppColors.error),
                ),
              ),
      ),
    );
  }
}
