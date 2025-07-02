import 'package:domain/domain.dart';
import 'package:domain/repositories/user_preferences/models/save_user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository.dart';
import 'package:result/result.dart';

class SaveUserPreferences
    implements BaseUseCase<void, SaveUserPreferencesEntity> {
  const SaveUserPreferences({
    required this.userPreferencesRepository,
  });

  final UserPreferencesRepository userPreferencesRepository;

  @override
  Future<Result<void>> call(SaveUserPreferencesEntity params) async =>
      userPreferencesRepository.saveUserPreferences(params);
}
