import 'package:flutter/widgets.dart';
import 'package:j_donuts/core/formatting/number_format.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// `3,200 MMK` in English, `၃,၂၀၀ ကျပ်` in Burmese: grouping and digits come
/// from the locale, the currency word from the ARB file.
String formatMmk(BuildContext context, int amount) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return AppLocalizations.of(context)
      .mmkAmount(formatGrouped(amount, locale: locale));
}
