import 'package:core/core.dart';
import 'package:domain/repositories/user/user_repository.dart';
import 'package:domain/repositories/user/user_repository_impl.dart';
import 'package:domain/use_cases/user/delete_user.dart';
import 'package:domain/use_cases/user/get_user.dart';
import 'package:domain/use_cases/user/save_user.dart';
import 'package:remote/remote.dart';

class DomainDependencyInjection {
  static void init() {
    RemoteDependencyInjection.init();

    // Repositories

    getIt.registerFactory<UserRepository>(
      () => UserRepositoryImpl(remoteDatasource: getIt()),
    );

    // Use cases

    getIt.registerFactory<GetUser>(() => GetUser(userRepository: getIt()));

    getIt.registerFactory<SaveUser>(() => SaveUser(userRepository: getIt()));

    getIt.registerFactory<DeleteUser>(
      () => DeleteUser(userRepository: getIt()),
    );
  }
}
