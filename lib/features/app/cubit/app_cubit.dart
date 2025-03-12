import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:firebase_login/firebase_login_service.dart';
import 'package:voice_diary/features/app/models/user_view_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required this.firebaseLoginService,
  }) : super(AppState());

  final FirebaseLoginService firebaseLoginService;

  Future<void> init() async {
    firebaseLoginService.listenChanges().listen((user) {
      if (user == null) {
        emit(state.logout());
      } else {
        emit(
          state.copyWith(
            status: AppStatus.connected,
            user: UserViewModel(
              uid: user.uid,
              email: user.email ?? '',
            ),
          ),
        );
      }
    });
  }
}
