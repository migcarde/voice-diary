import 'package:local/local/core/object_box.dart';
import 'package:local/local/user_preferences/models/user_preferences_local_entity.dart';
import 'package:local/local/user_preferences/user_preferences_local_datasource.dart';

class UserPreferencesLocalDatasourceImpl
    implements UserPreferencesLocalDatasource {
  const UserPreferencesLocalDatasourceImpl({
    required this.localDatasource,
  });

  final ObjectBox localDatasource;

  @override
  Future<void> deleteUserPreferences() async =>
      await localDatasource.removeAll();

  @override
  Future<UserPreferencesLocalEntity?> getUserPreferences() async {
    final userPreferences =
        await localDatasource.getAll<UserPreferencesLocalEntity>();

    if (userPreferences.isNotEmpty) {
      return userPreferences.first;
    }
    return null;
  }

  @override
  Future<void> saveUserPreferences(
      UserPreferencesLocalEntity userPreferences) async {
    final data = await localDatasource.getAll<UserPreferencesLocalEntity>();

    if (data.isNotEmpty) {
      await localDatasource.removeAll<UserPreferencesLocalEntity>();
    }
    await localDatasource.save<UserPreferencesLocalEntity>(userPreferences);
  }
}
