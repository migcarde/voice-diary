import 'package:go_router/go_router.dart';
import 'package:voice_diary/features/home/home_page.dart';
import 'package:voice_diary/features/login/login_page.dart';
import 'package:voice_diary/features/register/register_page.dart';
import 'package:voice_diary/routing/routes.dart';

class AppRouter {
  static GoRouter router({
    required bool isAuthenticated,
  }) =>
      GoRouter(
        initialLocation: isAuthenticated ? Routes.home : Routes.login,
        routes: [
          GoRoute(
            path: Routes.login,
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: Routes.register,
            builder: (context, state) => RegisterPage(),
          ),
          GoRoute(
            path: Routes.home,
            builder: (context, state) => HomePage(),
          ),
        ],
      );
}
