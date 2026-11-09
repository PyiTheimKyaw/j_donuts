import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/widgets/app_button.dart';
import 'package:j_donuts/core/widgets/app_text_field.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_controller.dart';
import 'package:j_donuts/features/auth/presentation/validation_messages.dart';
import 'package:j_donuts/features/auth/presentation/widgets/auth_step_form.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class PhoneScreen extends ConsumerStatefulWidget {
  const PhoneScreen({super.key});

  static const int step = 1;
  static const int _maxInputLength = 16;
  static final List<TextInputFormatter> _inputFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-+]')),
    LengthLimitingTextInputFormatter(_maxInputLength),
  ];

  @override
  ConsumerState<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends ConsumerState<PhoneScreen> {
  late final TextEditingController _controller = TextEditingController(
    text: ref.read(authFlowControllerProvider).phoneInput,
  );
  final FocusNode _focusNode = FocusNode();
  bool _touched = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus && _controller.text.isNotEmpty) {
      setState(() => _touched = true);
    }
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    _focusNode.unfocus();
    final advanced = await ref
        .read(authFlowControllerProvider.notifier)
        .submitPhone();
    if (advanced && mounted) await context.push(AppRoutes.otp);
  }

  AppTextField _phoneField({
    required String? errorText,
    required bool canSubmit,
  }) {
    return AppTextField(
      key: const Key('phone-field'),
      controller: _controller,
      focusNode: _focusNode,
      autofocus: true,
      hintText: AppLocalizations.of(context).phoneHint,
      errorText: errorText,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.telephoneNumberNational],
      inputFormatters: PhoneScreen._inputFormatters,
      leading: const _CountryCode(),
      onChanged: ref.read(authFlowControllerProvider.notifier).phoneChanged,
      onSubmitted: (_) => canSubmit ? _submit() : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(authFlowControllerProvider);
    final flow = ref.read(authFlowControllerProvider.notifier);
    final isInvalid = state.phone == null && _controller.text.isNotEmpty;
    final formatError = _touched && isInvalid ? l10n.phoneInvalid : null;
    final notRegistered = state.error is NotRegisteredFailure;
    final otherError = notRegistered ? null : state.error;

    return AuthStepForm(
      step: PhoneScreen.step,
      title: l10n.phoneTitle,
      fields: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _phoneField(
              errorText: formatError ?? otherError?.localized(l10n),
              canSubmit: state.phone != null,
            ),
            _NotRegisteredNotice(
              visible: notRegistered,
              onRegister: flow.switchToRegister,
            ),
          ],
        ),
      ],
      continueButton: AppButton(
        key: const Key('phone-continue'),
        label: l10n.continueLabel,
        isLoading: state.isSubmitting,
        onPressed: state.phone == null ? null : _submit,
      ),
    );
  }
}

class _CountryCode extends StatelessWidget {
  const _CountryCode();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).phoneCountryCode,
      style: AppTypography.fieldInput.copyWith(color: AppColors.inkTertiary),
    );
  }
}

class _NotRegisteredNotice extends StatelessWidget {
  const _NotRegisteredNotice({required this.visible, required this.onRegister});

  final bool visible;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AnimatedSize(
      duration: AppMotion.scaled(context, AppDurations.medium),
      curve: AppCurves.standard,
      alignment: Alignment.topLeft,
      child: visible
          ? Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    l10n.phoneNotRegistered,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                  InkWell(
                    key: const Key('register-link'),
                    onTap: onRegister,
                    child: Text(
                      l10n.registerLink,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(width: double.infinity),
    );
  }
}
