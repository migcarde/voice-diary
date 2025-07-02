part of 'records_cubit.dart';

enum RecordsStatus {
  loading,
  error,
  data,
  empty;

  bool get isLoading => this == RecordsStatus.loading;
}

class RecordsState extends Equatable {
  const RecordsState({
    this.status = RecordsStatus.loading,
    this.records = const [],
    this.tags = const {},
    this.filteredRecords = const [],
  });

  final RecordsStatus status;
  final List<RecordViewModel> records;
  final Set<String> tags;
  final List<RecordViewModel> filteredRecords;

  @override
  List<Object?> get props => [
        status,
        records,
        tags,
        filteredRecords,
      ];

  RecordsState copyWith({
    RecordsStatus? status,
    List<RecordViewModel>? records,
    Set<String>? tags,
    List<RecordViewModel>? filteredRecords,
  }) =>
      RecordsState(
        status: status ?? this.status,
        records: records ?? this.records,
        tags: tags ?? this.tags,
        filteredRecords: filteredRecords ?? this.filteredRecords,
      );
}
