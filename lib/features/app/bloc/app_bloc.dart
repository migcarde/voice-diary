import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:firebase_login/firebase_login_service.dart';
import 'package:flutter/rendering.dart';
import 'package:voice_diary/features/app/models/user_view_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.firebaseLoginService,
  }) : super(AppState()) {
    on<AppUserSubscriptionRequested>(_onUserSubscriptionRequested);
    on<AppLogout>(_onLogout);
  }

  final FirebaseLoginService firebaseLoginService;

  Future<void> _onUserSubscriptionRequested(
    AppUserSubscriptionRequested event,
    Emitter<AppState> emit,
  ) async =>
      emit.onEach(
        firebaseLoginService.listenChanges(),
        onData: (user) => AppState(
          status: user != null ? AppStatus.connected : AppStatus.disconnected,
          user: user != null
              ? UserViewModel(
                  uid: user.uid,
                  email: user.email ?? '',
                )
              : null,
        ),
      );

  void _onLogout(
    AppLogout event,
    Emitter<AppState> emit,
  ) =>
      firebaseLoginService.logout();
}
