import 'package:core/core.dart';
import 'package:domain/repositories/user_preferences/models/save_user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/models/user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/user_preferences_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local/local.dart';
import 'package:result/result.dart';

class MockUserPreferencesLocalDatasource extends Mock
    implements UserPreferencesLocalDatasource {}

void main() {
  late MockUserPreferencesLocalDatasource userPreferencesLocalDatasource;
  late UserPreferencesRepositoryImpl userPreferencesRepository;

  setUp(() {
    userPreferencesLocalDatasource = MockUserPreferencesLocalDatasource();
    userPreferencesRepository = UserPreferencesRepositoryImpl(
      localDatasource: userPreferencesLocalDatasource,
    );
  });

  group('Save user preferences', () {
    test('Success', () async {
      // Given
      final userPreferencesEntity = SaveUserPreferencesEntity(
        selectedLocale: 'en',
      );

      final userPreferencesLocalEntity =
          UserPreferencesLocalEntity(selectedLocale: 'en');

      when(() => userPreferencesLocalDatasource.saveUserPreferences(
          userPreferencesLocalEntity)).thenAnswer((_) async {});

      // When
      final result = await userPreferencesRepository
          .saveUserPreferences(userPreferencesEntity);

      // Then
      expect(result, isA<Success>());
      verify(() => userPreferencesLocalDatasource
          .saveUserPreferences(userPreferencesLocalEntity)).called(1);
    });

    test('Failure', () async {
      // Given
      final userPreferencesEntity = SaveUserPreferencesEntity(
        selectedLocale: 'en',
      );

      final userPreferencesLocalEntity =
          UserPreferencesLocalEntity(selectedLocale: 'en');

      when(() => userPreferencesLocalDatasource.saveUserPreferences(
          userPreferencesLocalEntity)).thenThrow(Exception());

      // When
      final result = await userPreferencesRepository
          .saveUserPreferences(userPreferencesEntity);

      // Then
      expect(result, isA<Failure>());
      verify(() => userPreferencesLocalDatasource
          .saveUserPreferences(userPreferencesLocalEntity)).called(1);
    });

    test('should delete user preferences', () async {
      // Given
      when(() => userPreferencesLocalDatasource.deleteUserPreferences())
          .thenAnswer((_) async {});

      // When
      final result = await userPreferencesRepository.deleteUserPreferences();

      // Then
      expect(result, isA<Success>());
      verify(() => userPreferencesLocalDatasource.deleteUserPreferences())
          .called(1);
    });
  });

  group('Delete user preferences', () {
    test('Success', () async {
      // Given
      when(() => userPreferencesLocalDatasource.deleteUserPreferences())
          .thenAnswer((_) async {});

      // When
      final result = await userPreferencesRepository.deleteUserPreferences();

      // Then
      expect(result, isA<Success>());
      verify(() => userPreferencesLocalDatasource.deleteUserPreferences())
          .called(1);
    });

    test('Failure', () async {
      // Given
      when(() => userPreferencesLocalDatasource.deleteUserPreferences())
          .thenThrow(Exception());

      // When
      final result = await userPreferencesRepository.deleteUserPreferences();

      // Then
      expect(result, isA<Failure>());
      verify(() => userPreferencesLocalDatasource.deleteUserPreferences())
          .called(1);
    });
  });

  group('Get user preferences', () {
    test('Success', () async {
      // Given
      final userPreferencesEntity = UserPreferencesEntity(
        id: 1,
        selectedLocale: 'en',
      );

      final userPreferencesLocalEntity = UserPreferencesLocalEntity(
        id: 1,
        selectedLocale: 'en',
      );

      when(() => userPreferencesLocalDatasource.getUserPreferences())
          .thenAnswer((_) async => userPreferencesLocalEntity);

      // When
      final result = await userPreferencesRepository.getUserPreferences();

      // Then
      expect((result as Success).data, userPreferencesEntity);
      verify(() => userPreferencesLocalDatasource.getUserPreferences())
          .called(1);
    });

    test('Failure', () async {
      // Given
      when(() => userPreferencesLocalDatasource.getUserPreferences())
          .thenThrow(Exception());

      // When
      final result = await userPreferencesRepository.getUserPreferences();

      // Then
      expect(result, isA<Failure>());
      verify(() => userPreferencesLocalDatasource.getUserPreferences())
          .called(1);
    });
  });
}
