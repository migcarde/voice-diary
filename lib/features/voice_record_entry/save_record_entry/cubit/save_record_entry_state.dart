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
  });

  final SaveRecordEntryStatus status;
  final SaveRecordEntryViewModel? viewModel;

  SaveRecordEntryState copyWith({
    SaveRecordEntryStatus? status,
    SaveRecordEntryViewModel? viewModel,
  }) {
    return SaveRecordEntryState(
      status: status ?? this.status,
      viewModel: viewModel ?? this.viewModel,
    );
  }

  @override
  List<Object?> get props => [
        status,
        viewModel,
      ];
}
