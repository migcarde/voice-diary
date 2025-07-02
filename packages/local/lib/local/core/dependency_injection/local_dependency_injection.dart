import 'package:core/services/get_it_service.dart';
import 'package:local/local.dart';
import 'package:local/local/core/object_box.dart';
import 'package:local/local/core/object_box_impl.dart';
import 'package:local/local/record/record_local_datasource_impl.dart';
import 'package:local/local/user_preferences/user_preferences_local_datasource_impl.dart';

class LocalDependencyInjection {
  static Future<void> init() async {
    getIt.registerLazySingleton<ObjectBox>(
      () => ObjectBoxImpl(),
    );

    getIt.registerLazySingleton<RecordLocalDatasource>(
      () => RecordLocalDatasourceImpl(
        localDatasource: getIt(),
      ),
    );

    getIt.registerLazySingleton<UserPreferencesLocalDatasource>(
      () => UserPreferencesLocalDatasourceImpl(
        localDatasource: getIt(),
      ),
    );

    await getIt<ObjectBox>().init();
  }
}
