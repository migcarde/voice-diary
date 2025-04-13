part of 'change_language_cubit.dart';

enum ChangeLanguageStatus {
  initial,
  error,
  success,
  loading;

  bool get isLoading => this == ChangeLanguageStatus.loading;
  bool get isSuccess => this == ChangeLanguageStatus.success;
  bool get isError => this == ChangeLanguageStatus.error;
}

class ChangeLanguageState extends Equatable {
  const ChangeLanguageState({
    this.status = ChangeLanguageStatus.initial,
    this.selectedLocale,
  });

  final ChangeLanguageStatus status;
  final Locale? selectedLocale;

  @override
  List<Object?> get props => [
        status,
        selectedLocale,
      ];

  ChangeLanguageState copyWith({
    ChangeLanguageStatus? status,
    Locale? selectedLocale,
  }) {
    return ChangeLanguageState(
      status: status ?? this.status,
      selectedLocale: selectedLocale ?? this.selectedLocale,
    );
  }
}
