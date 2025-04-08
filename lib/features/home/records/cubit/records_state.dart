part of 'records_cubit.dart';

enum RecordsStatus {
  loading,
  error,
  data,
  empty,
}

class RecordsState extends Equatable {
  const RecordsState({
    this.status = RecordsStatus.loading,
    this.records = const [],
  });

  final RecordsStatus status;
  final List<RecordViewModel> records;

  @override
  List<Object?> get props => [
        status,
        records,
      ];

  RecordsState copyWith({
    RecordsStatus? status,
    List<RecordViewModel>? records,
  }) =>
      RecordsState(
        status: status ?? this.status,
        records: records ?? this.records,
      );
}
