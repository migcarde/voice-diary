import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
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
  }) : super(const RegisterState());

  final FirebaseLoginService firebaseLoginService;

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
    // TODO: Save user to database
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
