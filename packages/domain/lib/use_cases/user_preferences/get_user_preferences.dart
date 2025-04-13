import 'package:domain/domain.dart';
import 'package:domain/repositories/user_preferences/models/user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository.dart';
import 'package:result/result.dart';

class GetUserPreferences implements BaseUseCase<UserPreferencesEntity?, void> {
  const GetUserPreferences({
    required this.userPreferencesRepository,
  });

  final UserPreferencesRepository userPreferencesRepository;

  @override
  Future<Result<UserPreferencesEntity?>> call(void params) async =>
      userPreferencesRepository.getUserPreferences();
}
