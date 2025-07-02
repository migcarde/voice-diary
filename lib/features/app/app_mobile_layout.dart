import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/app_router.dart';

class AppMobileLayout extends StatelessWidget {
  const AppMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) => AppRouter.router.refresh(),
      buildWhen: (previous, current) =>
          previous.selectedLocale != current.selectedLocale,
      builder: (context, state) => MaterialApp.router(
        locale: state.selectedLocale ?? Locale(Platform.localeName),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: AppTheme.mainTheme(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
