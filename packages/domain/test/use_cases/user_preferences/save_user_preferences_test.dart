import 'package:core/core.dart';
import 'package:domain/repositories/user_preferences/models/save_user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository.dart';
import 'package:domain/use_cases/user_preferences/save_user_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class MockUserPreferencesRepository extends Mock
    implements UserPreferencesRepository {}

void main() {
  late MockUserPreferencesRepository userPreferencesRepository;
  late SaveUserPreferences saveUserPreferences;

  setUp(() {
    userPreferencesRepository = MockUserPreferencesRepository();
    saveUserPreferences = SaveUserPreferences(
      userPreferencesRepository: userPreferencesRepository,
    );
  });

  group('Save user preferences', () {
    test('Success', () async {
      // Given
      final userPreferencesEntity = SaveUserPreferencesEntity(
        selectedLocale: 'en',
      );

      when(() => userPreferencesRepository.saveUserPreferences(
          userPreferencesEntity)).thenAnswer((_) async => Result.success(null));

      // When
      final result = await saveUserPreferences(userPreferencesEntity);

      // Then
      expect(result, isA<Success>());
      verify(() => userPreferencesRepository
          .saveUserPreferences(userPreferencesEntity)).called(1);
    });

    test('Failure', () async {
      // Given
      final userPreferencesEntity = SaveUserPreferencesEntity(
        selectedLocale: 'en',
      );

      when(() => userPreferencesRepository
              .saveUserPreferences(userPreferencesEntity))
          .thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await saveUserPreferences(userPreferencesEntity);

      // Then
      expect(result, isA<Failure>());
      verify(() => userPreferencesRepository
          .saveUserPreferences(userPreferencesEntity)).called(1);
    });
  });
}
