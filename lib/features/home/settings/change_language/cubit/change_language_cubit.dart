import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/extensions/string_extensions.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/user_preferences/models/save_user_preferences_entity.dart';
import 'package:flutter/material.dart';
import 'package:voice_diary/l10n/app_localizations.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit({
    required this.getUserPreferences,
    required this.saveUserPreferences,
  }) : super(ChangeLanguageState());

  final GetUserPreferences getUserPreferences;
  final SaveUserPreferences saveUserPreferences;

  Future<void> init() async {
    final result = await getUserPreferences(NoParams());

    result.ifSuccess(
      (userPreferences) {
        emit(
          state.copyWith(
            selectedLocale: userPreferences?.selectedLocale
                .getLocale(AppLocalizations.supportedLocales),
          ),
        );
      },
    );
  }

  void changeLanguage(Locale locale) => emit(
        state.copyWith(
          selectedLocale: locale,
        ),
      );

  Future<void> saveLanguage() async {
    emit(
      state.copyWith(
        status: ChangeLanguageStatus.loading,
      ),
    );

    final result = await saveUserPreferences(
      SaveUserPreferencesEntity(
        selectedLocale: state.selectedLocale.toString(),
      ),
    );

    result.when(
      (_) => emit(
        state.copyWith(
          status: ChangeLanguageStatus.success,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: ChangeLanguageStatus.error,
        ),
      ),
    );

    emit(
      state.copyWith(
        status: ChangeLanguageStatus.initial,
      ),
    );
  }
}
