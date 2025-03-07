import 'package:core/services/get_it_service.dart';
import 'package:domain/domain.dart';
import 'package:firebase_login/core/dependency_injection/firebase_login_dependency_injection.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';
import 'package:voice_diary/features/register/cubit/register_cubit.dart';

class AppDependencyInjection {
  static void init() {
    FirebaseLoginDependencyInjection.init();
    DomainDependencyInjection.init();

    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(
        firebaseLoginService: getIt(),
      ),
    );

    getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(
        firebaseLoginService: getIt(),
        saveUser: getIt(),
      ),
    );
  }
}
