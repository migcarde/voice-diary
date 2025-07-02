part of 'app_cubit.dart';

enum AppStatus {
  connected,
  disconnected;

  bool get isConnected => this == AppStatus.connected;
}

class AppState extends Equatable {
  const AppState(
      {this.status = AppStatus.disconnected, this.user, this.selectedLocale});

  final AppStatus status;
  final UserViewModel? user;
  final Locale? selectedLocale;

  @override
  List<Object?> get props => [
        status,
        user,
        selectedLocale,
      ];

  AppState copyWith({
    AppStatus? status,
    UserViewModel? user,
    Locale? selectedLocale,
  }) =>
      AppState(
        status: status ?? this.status,
        user: user ?? this.user,
        selectedLocale: selectedLocale ?? this.selectedLocale,
      );

  AppState logout() => AppState(
        status: AppStatus.disconnected,
        user: null,
        selectedLocale: null,
      );
}
