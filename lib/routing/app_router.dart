import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_diary/features/app/bloc/app_bloc.dart';
import 'package:voice_diary/features/home/home_page.dart';
import 'package:voice_diary/features/login/login_page.dart';
import 'package:voice_diary/features/register/register_page.dart';
import 'package:voice_diary/routing/routes.dart';

class AppRouter {
  static GoRouter get router => GoRouter(
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
        redirect: (context, state) {
          final isConnected = context.read<AppBloc>().state.status.isConnected;
          final isLoginPage = state.matchedLocation == Routes.login;
          if (!isConnected) {
            return Routes.login;
          } else if (isConnected && isLoginPage) {
            return Routes.home;
          }

          return null;
        },
      );
}
