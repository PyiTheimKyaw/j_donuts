import 'package:flutter/widgets.dart';
import 'package:j_donuts/core/storage/key_value_store.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_locale.g.dart';

/// `null` means "follow the device language"; only an explicit choice is
/// stored, so a user who never touches the toggle keeps getting their system
/// language even if they change it later.
@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  static const String storageKey = 'app.locale';

  @override
  Future<Locale?> build() async {
    final code = await ref.watch(keyValueStoreProvider).read(storageKey);
    return _supported(code);
  }

  Future<void> select(Locale locale) async {
    state = AsyncData(locale);
    await ref
        .read(keyValueStoreProvider)
        .write(storageKey, locale.languageCode);
  }

  /// A code stored by a build that supported more languages is ignored
  /// rather than forcing an unsupported locale on the app.
  static Locale? _supported(String? code) {
    for (final locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == code) return locale;
    }
    return null;
  }
}
