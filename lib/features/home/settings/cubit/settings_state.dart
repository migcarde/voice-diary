part of 'settings_cubit.dart';

enum SettingsStatus {
  inital,
  loading,
  deleteUserSucces,
  deleteUserFailure,
  logoutSuccess,
}

class SettingsState extends Equatable {
  const SettingsState({
    this.status = SettingsStatus.inital,
  });

  final SettingsStatus status;

  @override
  List<Object?> get props => [
        status,
      ];

  SettingsState copyWith({
    SettingsStatus? status,
  }) =>
      SettingsState(
        status: status ?? this.status,
      );
}
