part of 'reauthentication_cubit.dart';

enum ReauthenticationStatus {
  initial,
  loading,
  success;

  bool get isLoading => this == ReauthenticationStatus.loading;
  bool get isSuccess => this == ReauthenticationStatus.success;
}

class ReauthenticationState extends Equatable {
  const ReauthenticationState({
    this.status = ReauthenticationStatus.initial,
    this.error = LoginError.none,
    this.emailNotValid = false,
  });

  final ReauthenticationStatus status;
  final LoginError error;
  final bool emailNotValid;

  @override
  List<Object?> get props => [
        status,
        error,
        emailNotValid,
      ];

  ReauthenticationState copyWith({
    ReauthenticationStatus? status,
    LoginError? error,
    bool? emailNotValid,
  }) =>
      ReauthenticationState(
        status: status ?? this.status,
        error: error ?? this.error,
        emailNotValid: emailNotValid ?? this.emailNotValid,
      );
}
