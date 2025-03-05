import 'package:core/services/get_it_service.dart';
import 'package:firebase_login/core/dependency_injection/firebase_login_dependency_injection.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';

class AppDependencyInjection {
  static void init() {
    FirebaseLoginDependencyInjection.init();

    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(
        firebaseLoginService: getIt(),
      ),
    );
  }
}
