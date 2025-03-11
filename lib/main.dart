import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/firebase_login.dart';
import 'package:flutter/material.dart';
import 'package:voice_diary/core/dependency_injection/app_dependency_injection.dart';
import 'package:voice_diary/features/app/app_page.dart';
import 'package:voice_diary/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppDependencyInjection.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    getIt<FirebaseLoginService>().listenChanges().listen((user) {
      final hasUser = user != null;

      if (isLoggedIn != hasUser) {
        setState(() {
          isLoggedIn = hasUser;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPage();
  }
}
