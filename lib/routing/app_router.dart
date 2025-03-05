import 'package:go_router/go_router.dart';
import 'package:voice_diary/features/login/login_page.dart';
import 'package:voice_diary/routing/routes.dart';

class AppRouter {
  static GoRouter router() => GoRouter(
        initialLocation: Routes.login,
        routes: [
          GoRoute(
            path: Routes.login,
            builder: (context, state) => LoginPage(),
          ),
        ],
      );
}
