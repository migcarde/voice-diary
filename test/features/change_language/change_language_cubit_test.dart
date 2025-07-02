import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/user_preferences/models/save_user_preferences_entity.dart';
import 'package:domain/repositories/user_preferences/models/user_preferences_entity.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';
import 'package:voice_diary/features/home/settings/change_language/cubit/change_language_cubit.dart';

class MockGetUserPreferences extends Mock implements GetUserPreferences {}

class MockSaveUserPreferences extends Mock implements SaveUserPreferences {}

void main() {
  late MockGetUserPreferences getUserPreferences;
  late MockSaveUserPreferences saveUserPreferences;
  late ChangeLanguageCubit changeLanguageCubit;

  setUp(() {
    getUserPreferences = MockGetUserPreferences();
    saveUserPreferences = MockSaveUserPreferences();
    changeLanguageCubit = ChangeLanguageCubit(
      getUserPreferences: getUserPreferences,
      saveUserPreferences: saveUserPreferences,
    );
  });

  group('Init', () {
    blocTest<ChangeLanguageCubit, ChangeLanguageState>(
      'emits [initial] with current locale when is called successfully',
      build: () => changeLanguageCubit,
      act: (bloc) => changeLanguageCubit.init(),
      setUp: () {
        when(() => getUserPreferences(NoParams())).thenAnswer(
          (_) async => Result.success(
            UserPreferencesEntity(
              id: 1,
              selectedLocale: 'en',
            ),
          ),
        );
      },
      expect: () => const <ChangeLanguageState>[
        ChangeLanguageState(
          selectedLocale: Locale('en'),
        ),
      ],
    );
  });

  group('Change language', () {
    blocTest<ChangeLanguageCubit, ChangeLanguageState>(
      'change selected locale on called',
      build: () => changeLanguageCubit,
      act: (bloc) => changeLanguageCubit.changeLanguage(Locale('en')),
      expect: () => const <ChangeLanguageState>[
        ChangeLanguageState(
          selectedLocale: Locale('en'),
        ),
      ],
    );
  });

  group('Save language', () {
    blocTest<ChangeLanguageCubit, ChangeLanguageState>(
      'emits [loading, success, initial] with current locale when is called successfully',
      build: () => changeLanguageCubit,
      act: (bloc) => changeLanguageCubit.saveLanguage(),
      setUp: () {
        when(() => saveUserPreferences(
                SaveUserPreferencesEntity(selectedLocale: 'en')))
            .thenAnswer((_) async => Result.success(null));
      },
      seed: () => const ChangeLanguageState(
        selectedLocale: Locale('en'),
      ),
      expect: () => const <ChangeLanguageState>[
        ChangeLanguageState(
          status: ChangeLanguageStatus.loading,
          selectedLocale: Locale('en'),
        ),
        ChangeLanguageState(
          status: ChangeLanguageStatus.success,
          selectedLocale: Locale('en'),
        ),
        ChangeLanguageState(
          status: ChangeLanguageStatus.initial,
          selectedLocale: Locale('en'),
        ),
      ],
    );

    blocTest<ChangeLanguageCubit, ChangeLanguageState>(
      'emits [loading, error, initial] with current locale when throws an exception',
      build: () => changeLanguageCubit,
      act: (bloc) => changeLanguageCubit.saveLanguage(),
      setUp: () {
        when(() => saveUserPreferences(
                SaveUserPreferencesEntity(selectedLocale: 'en')))
            .thenAnswer((_) async => Result.failure(Exception()));
      },
      seed: () => const ChangeLanguageState(
        selectedLocale: Locale('en'),
      ),
      expect: () => const <ChangeLanguageState>[
        ChangeLanguageState(
          status: ChangeLanguageStatus.loading,
          selectedLocale: Locale('en'),
        ),
        ChangeLanguageState(
          status: ChangeLanguageStatus.error,
          selectedLocale: Locale('en'),
        ),
        ChangeLanguageState(
          status: ChangeLanguageStatus.initial,
          selectedLocale: Locale('en'),
        ),
      ],
    );
  });
}
