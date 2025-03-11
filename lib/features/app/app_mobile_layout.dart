import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/app_router.dart';

class AppMobileLayout extends StatelessWidget {
  const AppMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.mainTheme(),
      routerConfig: AppRouter.router,
    );
  }
}
