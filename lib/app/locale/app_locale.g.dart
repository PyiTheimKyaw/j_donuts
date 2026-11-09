// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_locale.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `null` means "follow the device language"; only an explicit choice is
/// stored, so a user who never touches the toggle keeps getting their system
/// language even if they change it later.

@ProviderFor(AppLocale)
final appLocaleProvider = AppLocaleProvider._();

/// `null` means "follow the device language"; only an explicit choice is
/// stored, so a user who never touches the toggle keeps getting their system
/// language even if they change it later.
final class AppLocaleProvider
    extends $AsyncNotifierProvider<AppLocale, Locale?> {
  /// `null` means "follow the device language"; only an explicit choice is
  /// stored, so a user who never touches the toggle keeps getting their system
  /// language even if they change it later.
  AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  AppLocale create() => AppLocale();
}

String _$appLocaleHash() => r'942bee1a104f71ddfe90896ded307926d2b22e7d';

/// `null` means "follow the device language"; only an explicit choice is
/// stored, so a user who never touches the toggle keeps getting their system
/// language even if they change it later.

abstract class _$AppLocale extends $AsyncNotifier<Locale?> {
  FutureOr<Locale?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Locale?>, Locale?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Locale?>, Locale?>,
              AsyncValue<Locale?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
