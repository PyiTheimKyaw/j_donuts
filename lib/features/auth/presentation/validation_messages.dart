import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/auth/domain/auth_policy.dart';
import 'package:j_donuts/features/auth/domain/validators/validators.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

extension ValidationFailureMessage on ValidationFailure {
  String localized(AppLocalizations l10n) => switch (rule) {
    PhoneValidationError.empty ||
    PhoneValidationError.invalidFormat => l10n.phoneInvalid,
    OtpValidationError.incomplete ||
    OtpValidationError.notDigits => l10n.otpInvalid,
    NameValidationError.required => l10n.nameRequired,
    NameValidationError.tooLong => l10n.nameTooLong(AuthPolicy.maxNameLength),
    NameValidationError.invalidCharacters => l10n.nameInvalidCharacters,
    BirthDateValidationError.incomplete ||
    BirthDateValidationError.notACalendarDate => l10n.dobInvalidDate,
    BirthDateValidationError.inFuture => l10n.dobInFuture,
    BirthDateValidationError.tooYoung => l10n.dobTooYoung(
      AuthPolicy.minimumAgeYears,
    ),
    _ => l10n.errorGeneric,
  };
}

extension FailureMessage on Failure {
  String localized(AppLocalizations l10n) => switch (this) {
    final ValidationFailure failure => failure.localized(l10n),
    NotRegisteredFailure() => l10n.phoneNotRegistered,
    InvalidOtpFailure() => l10n.otpInvalid,
    OtpLockedFailure() => l10n.otpLocked,
    NotFoundFailure() => l10n.productNotFound,
    NetworkFailure() => l10n.refreshFailed,
    StorageFailure() || UnexpectedFailure() => l10n.errorGeneric,
  };
}
