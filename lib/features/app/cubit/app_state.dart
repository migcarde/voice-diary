part of 'app_cubit.dart';

enum AppStatus {
  connected,
  disconnected;

  bool get isConnected => this == AppStatus.connected;
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.disconnected,
    this.user,
  });

  final AppStatus status;
  final UserViewModel? user;

  @override
  List<Object?> get props => [
        status,
        user,
      ];

  AppState copyWith({
    AppStatus? status,
    UserViewModel? user,
  }) =>
      AppState(
        status: status ?? this.status,
        user: user ?? this.user,
      );

  AppState logout() => AppState(
        status: AppStatus.disconnected,
        user: null,
      );
}
