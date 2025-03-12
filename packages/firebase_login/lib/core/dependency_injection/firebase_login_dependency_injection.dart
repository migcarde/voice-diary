import 'package:core/services/get_it_service.dart';
import 'package:firebase_login/firebase_login_service.dart';
import 'package:firebase_login/firebase_login_service_impl.dart';

class FirebaseLoginDependencyInjection {
  static void init() {
    getIt.registerFactory<FirebaseLoginService>(
      () => FirebaseLoginServiceImpl(),
    );
  }
}
