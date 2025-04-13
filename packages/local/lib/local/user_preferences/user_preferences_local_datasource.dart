import 'package:local/local/user_preferences/models/user_preferences_local_entity.dart';

abstract class UserPreferencesLocalDatasource {
  Future<void> saveUserPreferences(UserPreferencesLocalEntity userPreferences);
  Future<void> deleteUserPreferences();
  Future<UserPreferencesLocalEntity?> getUserPreferences();
}
