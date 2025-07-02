import 'package:core/core.dart';
import 'package:remote/remote/user/user_remote_datasource.dart';
import 'package:remote/remote/user/user_remote_datasource_impl.dart';

class RemoteDependencyInjection {
  static void init() {
    getIt.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(),
    );
  }
}
