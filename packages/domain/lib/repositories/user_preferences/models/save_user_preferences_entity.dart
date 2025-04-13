import 'package:core/core.dart';
import 'package:local/local/user_preferences/models/user_preferences_local_entity.dart';

class SaveUserPreferencesEntity extends Equatable {
  const SaveUserPreferencesEntity({
    required this.selectedLocale,
  });

  final String selectedLocale;

  @override
  List<Object?> get props => [
        selectedLocale,
      ];

  UserPreferencesLocalEntity get localEntity => UserPreferencesLocalEntity(
        selectedLocale: selectedLocale,
      );
}
