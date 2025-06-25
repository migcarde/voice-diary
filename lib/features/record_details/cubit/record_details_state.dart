part of 'record_details_cubit.dart';

class RecordDetailsState extends Equatable {
  final RecordDetailsViewModel? recordDetailsViewModel;

  const RecordDetailsState({
    this.recordDetailsViewModel,
  });

  @override
  List<Object?> get props => [
        recordDetailsViewModel,
      ];

  RecordDetailsState copyWith({
    RecordDetailsViewModel? recordDetailsViewModel,
  }) =>
      RecordDetailsState(
        recordDetailsViewModel:
            recordDetailsViewModel ?? this.recordDetailsViewModel,
      );
}
