import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/widgets/app_button.dart';
import 'package:j_donuts/core/widgets/app_text_field.dart';
import 'package:j_donuts/features/auth/domain/validators/validators.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_controller.dart';
import 'package:j_donuts/features/auth/presentation/flow/auth_flow_state.dart';
import 'package:j_donuts/features/auth/presentation/validation_messages.dart';
import 'package:j_donuts/features/auth/presentation/widgets/auth_step_form.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// On success the started session triggers the router's redirect to Welcome,
/// so this screen never navigates forward itself.
class DateOfBirthScreen extends ConsumerStatefulWidget {
  const DateOfBirthScreen({super.key});

  static const int step = 4;
  static const int dayDigits = 2;
  static const int yearDigits = 4;

  @override
  ConsumerState<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends ConsumerState<DateOfBirthScreen> {
  late final AuthFlowState _initial = ref.read(authFlowControllerProvider);
  late final TextEditingController _monthController = TextEditingController();
  late final TextEditingController _dayController = TextEditingController(
    text: _initial.birthDay?.toString() ?? '',
  );
  late final TextEditingController _yearController = TextEditingController(
    text: _initial.birthYear?.toString() ?? '',
  );

  AuthFlowController get _flow => ref.read(authFlowControllerProvider.notifier);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final month = ref.read(authFlowControllerProvider).birthMonth;
    if (month != null) _monthController.text = _monthName(month);
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  String _monthName(int month) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.MMMM(locale).format(DateTime(DateTime.now().year, month));
  }

  Future<void> _pickMonth() async {
    final picked = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => _MonthSheet(
        monthName: _monthName,
        selected: ref.read(authFlowControllerProvider).birthMonth,
      ),
    );
    if (picked == null || !mounted) return;
    _monthController.text = _monthName(picked);
    _flow.birthMonthChanged(picked);
  }

  /// A partial year such as `198` is a real (ancient) calendar year, so the
  /// year only counts once all four digits are typed.
  void _onYearChanged(String value) => _flow.birthYearChanged(
    value.length == DateOfBirthScreen.yearDigits ? int.tryParse(value) : null,
  );

  /// Incomplete input stays silent: Continue is disabled, but nothing turns
  /// red until there is a full date to judge.
  String? _errorMessage() {
    final failure = _flow.birthDateResult.failureOrNull;
    if (failure is! ValidationFailure) return null;
    if (failure.rule == BirthDateValidationError.incomplete) return null;
    return failure.localized(AppLocalizations.of(context));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authFlowControllerProvider);
    final l10n = AppLocalizations.of(context);
    final error = _errorMessage();
    final highlightField = error == null ? null : '';

    return AuthStepForm(
      step: DateOfBirthScreen.step,
      title: l10n.dobTitle,
      fields: [
        _MonthField(
          controller: _monthController,
          onTap: _pickMonth,
          errorText: highlightField,
        ),
        _digitsField(
          key: const Key('dob-day-field'),
          controller: _dayController,
          hintText: l10n.dobDay,
          maxDigits: DateOfBirthScreen.dayDigits,
          errorText: highlightField,
          onChanged: (value) => _flow.birthDayChanged(int.tryParse(value)),
        ),
        _digitsField(
          key: const Key('dob-year-field'),
          controller: _yearController,
          hintText: l10n.dobYear,
          maxDigits: DateOfBirthScreen.yearDigits,
          errorText: error ?? state.error?.localized(l10n),
          onChanged: _onYearChanged,
          isLast: true,
        ),
      ],
      continueButton: AppButton(
        key: const Key('dob-continue'),
        label: l10n.continueLabel,
        isLoading: state.isSubmitting,
        onPressed: _flow.birthDateResult.isSuccess
            ? _flow.completeRegistration
            : null,
      ),
    );
  }

  /// Day and year share one error highlight; only the year carries the
  /// message so it appears once, under the whole date.
  AppTextField _digitsField({
    required Key key,
    required TextEditingController controller,
    required String hintText,
    required int maxDigits,
    required String? errorText,
    required ValueChanged<String> onChanged,
    bool isLast = false,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      errorText: errorText,
      keyboardType: TextInputType.number,
      textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
      autofillHints: isLast ? const [AutofillHints.birthdayYear] : null,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxDigits),
      ],
      onChanged: onChanged,
    );
  }
}

/// Read-only: the month comes from a sheet so it is always a valid month and
/// shows in the user's language.
class _MonthField extends StatelessWidget {
  const _MonthField({
    required this.controller,
    required this.onTap,
    required this.errorText,
  });

  final TextEditingController controller;
  final VoidCallback onTap;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      key: const Key('dob-month-field'),
      controller: controller,
      hintText: AppLocalizations.of(context).dobMonth,
      readOnly: true,
      onTap: onTap,
      errorText: errorText,
      trailing: const Icon(
        Icons.expand_more_rounded,
        color: AppColors.inkTertiary,
      ),
    );
  }
}

class _MonthSheet extends StatelessWidget {
  const _MonthSheet({required this.monthName, required this.selected});

  final String Function(int month) monthName;
  final int? selected;

  static const int _monthsInYear = 12;
  static const double _maxHeightFraction = 0.7;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final maxHeight = MediaQuery.sizeOf(context).height * _maxHeightFraction;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
            child: Text(l10n.dobChooseMonth, style: AppTypography.title),
          ),
          const SizedBox(height: AppSpacing.sm),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _monthsInYear,
              itemBuilder: (context, index) {
                final month = index + 1;
                final isSelected = month == selected;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.gutter,
                  ),
                  title: Text(monthName(month), style: AppTypography.body),
                  trailing: isSelected
                      ? const Icon(Icons.check_rounded, color: AppColors.accent)
                      : null,
                  onTap: () => Navigator.of(context).pop(month),
                );
              },
            ),
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}
