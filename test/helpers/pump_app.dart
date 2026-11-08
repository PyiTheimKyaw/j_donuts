import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app/app.dart';
import 'package:j_donuts/app/theme/app_theme.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

import 'test_overrides.dart';

/// Phone-sized logical viewport instead of the 800x600 test default.
const Size phoneViewport = Size(390, 844);

extension PumpApp on WidgetTester {
  void usePhoneViewport() {
    view.physicalSize = phoneViewport;
    view.devicePixelRatio = 1;
    addTearDown(view.resetPhysicalSize);
    addTearDown(view.resetDevicePixelRatio);
  }

  Future<void> pumpApp({List<Override>? overrides}) async {
    usePhoneViewport();
    await pumpWidget(
      ProviderScope(
        overrides: overrides ?? testOverrides(),
        child: const JDonutsApp(),
      ),
    );
    await pumpAndSettle();
  }

  Future<void> pumpScreen(
    Widget child, {
    List<Override>? overrides,
    bool settle = true,
  }) async {
    usePhoneViewport();
    await pumpWidget(
      ProviderScope(
        overrides: overrides ?? testOverrides(),
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: child,
        ),
      ),
    );
    if (settle) {
      await pumpAndSettle();
    } else {
      await pump();
    }
  }

  AppLocalizations get l10n =>
      AppLocalizations.of(element(find.byType(Scaffold).first));
}
