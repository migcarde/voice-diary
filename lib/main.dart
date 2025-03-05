import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/core/dependency_injection/app_dependency_injection.dart';
import 'package:voice_diary/firebase_options.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppDependencyInjection.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.mainTheme(),
      routerConfig: AppRouter.router(),
    );
  }
}
