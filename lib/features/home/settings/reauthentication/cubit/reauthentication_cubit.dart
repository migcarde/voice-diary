import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:firebase_login/firebase_login.dart';
import 'package:voice_diary/extensions/string_extensions.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';

part 'reauthentication_state.dart';

class ReauthenticationCubit extends Cubit<ReauthenticationState> {
  ReauthenticationCubit({
    required this.firebaseLoginService,
  }) : super(const ReauthenticationState());

  final FirebaseLoginService firebaseLoginService;

  Future<void> reauthenticate({
    required String email,
    required String password,
  }) async {
    if (email.isValidEmail) {
      emit(
        state.copyWith(
          status: ReauthenticationStatus.loading,
        ),
      );

      final result = await firebaseLoginService.reauthenticate(
        email: email,
        password: password,
      );

      result.when(
        (success) => emit(
          state.copyWith(
            status: ReauthenticationStatus.success,
          ),
        ),
        (failure) => emit(
          state.copyWith(
            status: ReauthenticationStatus.initial,
            error: (failure is FirebaseAuthErrors)
                ? LoginError.fromFirebaseAuthError(failure)
                : LoginError.unknown,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          emailNotValid: true,
        ),
      );
    }
  }
}
