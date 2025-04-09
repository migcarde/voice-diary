import 'package:core/core.dart';
import 'package:local/local/user_preferences/models/user_preferences_local_entity.dart';

class UserPreferencesEntity extends Equatable {
  const UserPreferencesEntity({
    required this.id,
    required this.selectedLocale,
  });

  final int id;
  final String selectedLocale;

  @override
  List<Object?> get props => [
        id,
        selectedLocale,
      ];
}

extension UserPreferencesLocalEntityExtensions on UserPreferencesLocalEntity {
  UserPreferencesEntity get entity => UserPreferencesEntity(
        id: id,
        selectedLocale: selectedLocale,
      );
}
