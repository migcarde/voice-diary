import 'package:domain/repositories/user_preferences/models/save_user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/models/user_preferences_entity.dart';
import 'package:result/result.dart';

abstract class UserPreferencesRepository {
  Future<Result<void>> saveUserPreferences(
      SaveUserPreferencesEntity userPreferences);
  Future<Result<void>> deleteUserPreferences();
  Future<Result<UserPreferencesEntity?>> getUserPreferences();
}
