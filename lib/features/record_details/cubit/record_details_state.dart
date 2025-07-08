part of 'record_details_cubit.dart';

enum RecordDetailsStatus {
  initial,
  success,
  failure,
  loading;

  bool get isSuccess => this == RecordDetailsStatus.success;
  bool get isFailure => this == RecordDetailsStatus.failure;
  bool get isLoading => this == RecordDetailsStatus.loading;
}

class RecordDetailsState extends Equatable {
  final RecordDetailsViewModel? recordDetailsViewModel;
  final RecordDetailsStatus status;

  const RecordDetailsState({
    this.recordDetailsViewModel,
    this.status = RecordDetailsStatus.initial,
  });

  @override
  List<Object?> get props => [
        recordDetailsViewModel,
        status,
      ];

  RecordDetailsState copyWith({
    RecordDetailsViewModel? recordDetailsViewModel,
    RecordDetailsStatus? status,
  }) =>
      RecordDetailsState(
        recordDetailsViewModel:
            recordDetailsViewModel ?? this.recordDetailsViewModel,
        status: status ?? this.status,
      );
}
