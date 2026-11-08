import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:j_donuts/app/router/app_router.dart';
import 'package:j_donuts/app/theme/app_theme.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Root widget: theme, localisation and router.
class JDonutsApp extends ConsumerWidget {
  const JDonutsApp({super.key});

  /// Largest text scale the layouts are verified against.
  static const double maxTextScale = 1.3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: _clampTextScale,
    );
  }

  Widget _clampTextScale(BuildContext context, Widget? child) {
    final media = MediaQuery.of(context);
    final clamped = media.textScaler.clamp(maxScaleFactor: maxTextScale);
    return MediaQuery(
      data: media.copyWith(textScaler: clamped),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
