import 'package:core/core.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
// ignore: must_be_immutable
class UserPreferencesLocalEntity extends Equatable {
  UserPreferencesLocalEntity({
    this.id = 0,
    required this.selectedLocale,
  });

  @Id()
  int id;
  final String selectedLocale;

  @override
  List<Object?> get props => [
        id,
        selectedLocale,
      ];
}
