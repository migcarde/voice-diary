import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/user/models/user_entity.dart';
import 'package:domain/repositories/user_preferences/models/save_user_preferences_entity.dart';
import 'package:firebase_login/firebase_login_service.dart';
import 'package:firebase_login/models/firebase_auth_errors.dart';
import 'package:firebase_login/models/firebase_user.dart';
import 'package:flutter/widgets.dart';
import 'package:voice_diary/extensions/string_extensions.dart';
import 'package:voice_diary/l10n/app_localizations.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.firebaseLoginService,
    required this.saveUser,
    required this.saveUserPreferences,
  }) : super(const RegisterState());

  final FirebaseLoginService firebaseLoginService;
  final SaveUser saveUser;
  final SaveUserPreferences saveUserPreferences;

  Future<void> register({
    required String email,
    required String password,
    required String repeatPassword,
  }) async {
    List<RegisterError> errors = [
      if (!email.isValidEmail) RegisterError.emailNotValid,
      if (!password.isStrongPassword) RegisterError.passwordMustBeStronger,
      if (password != repeatPassword) RegisterError.passwordNotMatch,
    ];

    if (errors.isNotEmpty) {
      emit(
        state.copyWith(
          status: RegisterStatus.initial,
          errors: errors,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: RegisterStatus.loading,
          errors: [],
        ),
      );

      final result = await firebaseLoginService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      result.when(
        (user) => _onSuccess(user),
        (failure) => _onError(failure),
      );
    }
  }

  Future<void> _onSuccess(FirebaseUser user) async {
    final result = await saveUser(
      UserEntity(
        uid: user.uid,
        email: user.email,
        locale: Platform.localeName,
      ),
    );

    saveUserPreferences(
      SaveUserPreferencesEntity(
        selectedLocale: Platform.localeName,
      ),
    );

    result.when(
      (_) => emit(
        state.copyWith(
          status: RegisterStatus.success,
        ),
      ),
      (e) => _onError(e),
    );
  }

  void _onError(Object failure) {
    if (failure is FirebaseAuthErrors) {
      final registerError = RegisterError.fromFirebaseAuthError(failure);

      emit(
        state.copyWith(
          status: registerError.isEmailAlreayInUse
              ? RegisterStatus.initial
              : RegisterStatus.error,
          errors: [registerError],
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: RegisterStatus.error,
          errors: [RegisterError.unknown],
        ),
      );
    }
  }
}
