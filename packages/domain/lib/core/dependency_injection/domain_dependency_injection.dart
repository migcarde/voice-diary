import 'package:core/core.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:domain/repositories/record/record_repository_impl.dart';
import 'package:domain/repositories/user/user_repository.dart';
import 'package:domain/repositories/user/user_repository_impl.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository_impl.dart';
import 'package:domain/use_cases/use_cases.dart';
import 'package:local/local/core/dependency_injection/local_dependency_injection.dart';
import 'package:remote/remote.dart';

class DomainDependencyInjection {
  static Future<void> init() async {
    RemoteDependencyInjection.init();
    await LocalDependencyInjection.init();

    // Repositories

    getIt.registerFactory<UserRepository>(
      () => UserRepositoryImpl(remoteDatasource: getIt()),
    );

    getIt.registerFactory<RecordRepository>(
      () => RecordRepositoryImpl(
        localDatasource: getIt(),
      ),
    );

    getIt.registerFactory<UserPreferencesRepository>(
      () => UserPreferencesRepositoryImpl(
        localDatasource: getIt(),
      ),
    );

    // Use cases

    getIt.registerFactory<GetUser>(
      () => GetUser(
        userRepository: getIt(),
      ),
    );

    getIt.registerFactory<SaveUser>(
      () => SaveUser(
        userRepository: getIt(),
      ),
    );

    getIt.registerFactory<DeleteUser>(
      () => DeleteUser(userRepository: getIt()),
    );

    getIt.registerFactory<GetAllRecords>(
      () => GetAllRecords(
        recordRepository: getIt(),
      ),
    );

    getIt.registerFactory<SaveRecord>(
      () => SaveRecord(
        recordRepository: getIt(),
      ),
    );

    getIt.registerFactory<DeleteRecord>(
      () => DeleteRecord(
        recordRepository: getIt(),
      ),
    );

    getIt.registerFactory<GetUserPreferences>(
      () => GetUserPreferences(
        userPreferencesRepository: getIt(),
      ),
    );

    getIt.registerFactory(
      () => SaveUserPreferences(
        userPreferencesRepository: getIt(),
      ),
    );

    getIt.registerFactory(
      () => DeleteUserPreferences(
        userPreferencesRepository: getIt(),
      ),
    );
  }
}
