import 'package:domain/domain.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository.dart';
import 'package:result/result.dart';

class DeleteUserPreferences implements BaseUseCase<void, void> {
  const DeleteUserPreferences({
    required this.userPreferencesRepository,
  });

  final UserPreferencesRepository userPreferencesRepository;

  @override
  Future<Result<void>> call(void params) async =>
      userPreferencesRepository.deleteUserPreferences();
}
