import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:firebase_login/firebase_login.dart';
import 'package:flutter/material.dart';
import 'package:voice_diary/l10n/app_localizations.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.firebaseLoginService,
  }) : super(const LoginState());

  final FirebaseLoginService firebaseLoginService;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: LoginStatus.loading,
      ),
    );

    final result = await firebaseLoginService.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.when(
      (user) async {
        emit(
          state.copyWith(
            status: LoginStatus.connected,
          ),
        );
      },
      (failure) => _onError(failure),
    );
  }

  void _onError(Object error) => emit(
        state.copyWith(
          status: LoginStatus.disconnected,
          error: (error is FirebaseAuthErrors)
              ? LoginError.fromFirebaseAuthError(error)
              : LoginError.unknown,
        ),
      );
}
