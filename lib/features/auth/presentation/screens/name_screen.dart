import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/core/widgets/app_button.dart';
import 'package:j_donuts/core/widgets/app_text_field.dart';
import 'package:j_donuts/features/auth/domain/validators/validators.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_controller.dart';
import 'package:j_donuts/features/auth/presentation/validation_messages.dart';
import 'package:j_donuts/features/auth/presentation/widgets/auth_step_form.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});

  static const int step = 3;

  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  late final TextEditingController _firstController = TextEditingController(
    text: ref.read(authFlowControllerProvider).firstName,
  );
  late final TextEditingController _lastController = TextEditingController(
    text: ref.read(authFlowControllerProvider).lastName,
  );
  final FocusNode _firstFocus = FocusNode();
  final FocusNode _lastFocus = FocusNode();
  bool _firstTouched = false;

  AuthFlowController get _flow => ref.read(authFlowControllerProvider.notifier);

  @override
  void initState() {
    super.initState();
    _firstFocus.addListener(_onFirstFocusChanged);
  }

  void _onFirstFocusChanged() {
    if (!_firstFocus.hasFocus) setState(() => _firstTouched = true);
  }

  @override
  void dispose() {
    _firstFocus
      ..removeListener(_onFirstFocusChanged)
      ..dispose();
    _lastFocus.dispose();
    _firstController.dispose();
    _lastController.dispose();
    super.dispose();
  }

  void _continue() {
    FocusScope.of(context).unfocus();
    unawaited(context.push(AppRoutes.dateOfBirth));
  }

  /// "Required" waits for the field to lose focus so an untouched form is not
  /// red on arrival; every other rule shows as soon as it is broken.
  String? _errorFor(Result<Object?> result, {required bool touched}) {
    final failure = result.failureOrNull;
    if (failure is! ValidationFailure) return null;
    if (failure.rule == NameValidationError.required && !touched) return null;
    return failure.localized(AppLocalizations.of(context));
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authFlowControllerProvider);
    final l10n = AppLocalizations.of(context);

    return AuthStepForm(
      step: NameScreen.step,
      title: l10n.nameTitle,
      fields: [
        AppTextField(
          key: const Key('first-name-field'),
          controller: _firstController,
          focusNode: _firstFocus,
          autofocus: true,
          hintText: l10n.firstName,
          errorText: _errorFor(_flow.firstNameResult, touched: _firstTouched),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.givenName],
          onChanged: _flow.firstNameChanged,
          onSubmitted: (_) => _lastFocus.requestFocus(),
        ),
        AppTextField(
          key: const Key('last-name-field'),
          controller: _lastController,
          focusNode: _lastFocus,
          hintText: l10n.lastName,
          errorText: _errorFor(_flow.lastNameResult, touched: true),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.familyName],
          onChanged: _flow.lastNameChanged,
          onSubmitted: (_) => _flow.isNameValid ? _continue() : null,
        ),
      ],
      continueButton: AppButton(
        key: const Key('name-continue'),
        label: l10n.continueLabel,
        onPressed: _flow.isNameValid ? _continue : null,
      ),
    );
  }
}
