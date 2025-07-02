import 'package:core/core.dart';
import 'package:domain/base/base.dart';
import 'package:domain/repositories/user_preferences/models/user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository.dart';
import 'package:domain/use_cases/user_preferences/get_user_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class MockUserPreferencesRepository extends Mock
    implements UserPreferencesRepository {}

void main() {
  late MockUserPreferencesRepository userPreferencesRepository;
  late GetUserPreferences getUserPreferences;

  setUp(() {
    userPreferencesRepository = MockUserPreferencesRepository();
    getUserPreferences = GetUserPreferences(
        userPreferencesRepository: userPreferencesRepository);
  });

  group('GetUserPreferences', () {
    test('Success', () async {
      // Given
      final userPreferencesEntity = UserPreferencesEntity(
        id: 1,
        selectedLocale: 'en',
      );
      when(() => userPreferencesRepository.getUserPreferences())
          .thenAnswer((_) async => Result.success(userPreferencesEntity));

      // When
      final result = await getUserPreferences(NoParams());

      // Then
      expect((result as Success).data, userPreferencesEntity);
      verify(
        () => userPreferencesRepository.getUserPreferences(),
      ).called(1);
    });

    test('Failure', () async {
      // Given
      when(() => userPreferencesRepository.getUserPreferences())
          .thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await getUserPreferences(NoParams());

      // Then
      expect(result, isA<Failure>());
      verify(
        () => userPreferencesRepository.getUserPreferences(),
      ).called(1);
    });
  });
}
