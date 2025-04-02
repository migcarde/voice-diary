import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voice_diary/core/dependency_injection/app_dependency_injection.dart';
import 'package:voice_diary/features/app/app_page.dart';
import 'package:voice_diary/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppDependencyInjection.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage();
  }
}
