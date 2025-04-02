import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:firebase_login/firebase_login_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required this.firebaseLoginService,
    required this.deleteUser,
  }) : super(SettingsState());

  final FirebaseLoginService firebaseLoginService;
  final DeleteUser deleteUser;

  Future<void> removeUser() async {
    emit(
      state.copyWith(
        status: SettingsStatus.loading,
      ),
    );
    final uid = firebaseLoginService.uid;

    await deleteUser(uid);
    final result = await firebaseLoginService.deleteAccount();

    result.when(
      (success) => emit(
        state.copyWith(
          status: SettingsStatus.deleteUserSucces,
        ),
      ),
      (failure) => emit(
        state.copyWith(
          status: SettingsStatus.deleteUserFailure,
        ),
      ),
    );
  }
}
