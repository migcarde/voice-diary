import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/routing/routes.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: Paths.home,
    routes: Routes.list,
    redirect: (context, state) {
      final status = context.read<AppCubit>().state.status;

      if (!status.isConnected && state.fullPath != Paths.register) {
        return Paths.login;
      } else if (status.isConnected &&
          (state.fullPath == Paths.register || state.fullPath == Paths.login)) {
        return Paths.home;
      } else {
        return null;
      }
    },
  );
}
