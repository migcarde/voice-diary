part of 'app_bloc.dart';

enum AppStatus {
  connected,
  disconnected;

  bool get isConnected => this == AppStatus.connected;
}

final class AppState extends Equatable {
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
}
