import 'package:domain/repositories/user_preferences/models/save_user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/models/user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository.dart';
import 'package:local/local/user_preferences/user_preferences_local_datasource.dart';
import 'package:result/result.dart';

class UserPreferencesRepositoryImpl implements UserPreferencesRepository {
  const UserPreferencesRepositoryImpl({
    required this.localDatasource,
  });

  final UserPreferencesLocalDatasource localDatasource;

  @override
  Future<Result<void>> deleteUserPreferences() async {
    try {
      await localDatasource.deleteUserPreferences();

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserPreferencesEntity?>> getUserPreferences() async {
    try {
      final result = await localDatasource.getUserPreferences();

      return Result.success(result?.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> saveUserPreferences(
      SaveUserPreferencesEntity userPreferences) async {
    try {
      await localDatasource.saveUserPreferences(userPreferences.localEntity);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
