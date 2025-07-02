part of 'save_record_entry_cubit.dart';

enum SaveRecordEntryStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == SaveRecordEntryStatus.loading;
  bool get isSuccess => this == SaveRecordEntryStatus.success;
}

class SaveRecordEntryState extends Equatable {
  const SaveRecordEntryState({
    this.status = SaveRecordEntryStatus.initial,
    this.viewModel,
    this.titleRequiredError = false,
  });

  final SaveRecordEntryStatus status;
  final SaveRecordEntryViewModel? viewModel;
  final bool titleRequiredError;

  SaveRecordEntryState copyWith({
    SaveRecordEntryStatus? status,
    SaveRecordEntryViewModel? viewModel,
    bool? titleRequiredError,
  }) {
    return SaveRecordEntryState(
      status: status ?? this.status,
      viewModel: viewModel ?? this.viewModel,
      titleRequiredError: titleRequiredError ?? this.titleRequiredError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        viewModel,
        titleRequiredError,
      ];
}
