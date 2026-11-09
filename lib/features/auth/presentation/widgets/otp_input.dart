import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Six boxes rendered over one transparent text field. A single field keeps
/// paste, SMS autofill and backspace native; per-box fields would need focus
/// juggling for each of those and still break autofill on iOS.
class OtpInput extends StatefulWidget {
  const OtpInput({
    required this.controller,
    required this.focusNode,
    required this.onCompleted,
    this.enabled = true,
    this.hasError = false,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onCompleted;
  final bool enabled;
  final bool hasError;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  static const int _length = AuthPolicy.otpLength;

  /// Every state is overridden because the app theme fills inputs white and
  /// draws a focus border; any one left to the theme shows through the boxes.
  static const InputDecoration _invisibleDecoration = InputDecoration(
    isCollapsed: true,
    filled: true,
    fillColor: Colors.transparent,
    contentPadding: EdgeInsets.zero,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
  );

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
    widget.focusNode.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    widget.focusNode.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  void _onChanged(String value) {
    if (value.length == _length) widget.onCompleted(value);
  }

  int get _activeIndex {
    final filled = widget.controller.text.length;
    return filled < _length ? filled : _length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.controller.text;
    final focused = widget.focusNode.hasFocus && widget.enabled;

    return Semantics(
      label: AppLocalizations.of(context).otpCodeLabel,
      child: SizedBox(
        height: AppSizes.otpBoxHeight,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < _length; i++)
                  _OtpBox(
                    digit: i < text.length ? text[i] : null,
                    isActive: focused && i == _activeIndex,
                    hasError: widget.hasError,
                  ),
              ],
            ),
            Positioned.fill(child: _buildHiddenField()),
          ],
        ),
      ),
    );
  }

  Widget _buildHiddenField() {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      autofocus: true,
      showCursor: false,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.oneTimeCode],
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(_length),
      ],
      style: const TextStyle(color: Colors.transparent),
      decoration: _invisibleDecoration,
      onChanged: _onChanged,
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.digit,
    required this.isActive,
    required this.hasError,
  });

  final String? digit;
  final bool isActive;
  final bool hasError;

  static const double _borderWidth = 1.5;

  Color get _borderColor {
    if (hasError) return AppColors.error;
    if (isActive) return AppColors.primary;
    return AppColors.surface;
  }

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.scaled(context, AppDurations.fast);

    return AnimatedContainer(
      duration: duration,
      curve: AppCurves.standard,
      width: AppSizes.otpBox,
      height: AppSizes.otpBoxHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: _borderColor, width: _borderWidth),
      ),
      child: AnimatedSwitcher(
        duration: duration,
        switchInCurve: AppCurves.overshoot,
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: Text(
          digit ?? '',
          key: ValueKey(digit),
          style: AppTypography.title,
        ),
      ),
    );
  }
}
