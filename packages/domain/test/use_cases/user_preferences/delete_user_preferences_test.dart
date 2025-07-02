import 'package:core/core.dart';
import 'package:domain/base/base_use_case.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository.dart';
import 'package:domain/use_cases/user_preferences/delete_user_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class MockUserPreferencesRepository extends Mock
    implements UserPreferencesRepository {}

void main() {
  late MockUserPreferencesRepository userPreferencesRepository;
  late DeleteUserPreferences deleteUserPreferences;

  setUp(() {
    userPreferencesRepository = MockUserPreferencesRepository();
    deleteUserPreferences = DeleteUserPreferences(
      userPreferencesRepository: userPreferencesRepository,
    );
  });
  group('DeleteUserPreferences', () {
    test('Success', () async {
      // Given
      when(() => userPreferencesRepository.deleteUserPreferences())
          .thenAnswer((_) async => Result.success(null));

      // When
      final result = await deleteUserPreferences(NoParams());

      // Then
      expect(result, isA<Success>());
      verify(
        () => userPreferencesRepository.deleteUserPreferences(),
      ).called(1);
    });

    test('Failure', () async {
      // Given
      when(() => userPreferencesRepository.deleteUserPreferences())
          .thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await deleteUserPreferences(NoParams());

      // Then
      expect(result, isA<Failure>());
      verify(
        () => userPreferencesRepository.deleteUserPreferences(),
      ).called(1);
    });
  });
}
