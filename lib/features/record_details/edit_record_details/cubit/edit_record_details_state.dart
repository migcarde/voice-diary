part of 'edit_record_details_cubit.dart';

enum EditRecordDetailsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == EditRecordDetailsStatus.loading;
  bool get isSuccess => this == EditRecordDetailsStatus.success;
  bool get isFailure => this == EditRecordDetailsStatus.failure;
}

enum EditRecordDetailsFormError {
  titleRequired,
  transcriptionRequired;

  bool get isTitleRequired => this == EditRecordDetailsFormError.titleRequired;
  bool get isTranscriptionRequired =>
      this == EditRecordDetailsFormError.transcriptionRequired;
}

class EditRecordDetailsState extends Equatable {
  const EditRecordDetailsState({
    this.status = EditRecordDetailsStatus.initial,
    this.editRecordDetailsViewModel,
    this.formErrors = const [],
  });

  final EditRecordDetailsStatus status;
  final EditRecordDetailsViewModel? editRecordDetailsViewModel;
  final List<EditRecordDetailsFormError> formErrors;

  EditRecordDetailsState copyWith({
    EditRecordDetailsStatus? status,
    EditRecordDetailsViewModel? editRecordDetailsViewModel,
    List<EditRecordDetailsFormError>? formErrors,
  }) {
    return EditRecordDetailsState(
      status: status ?? this.status,
      editRecordDetailsViewModel:
          editRecordDetailsViewModel ?? this.editRecordDetailsViewModel,
      formErrors: formErrors ?? this.formErrors,
    );
  }

  @override
  List<Object?> get props => [
        status,
        editRecordDetailsViewModel,
        formErrors,
      ];

  bool get hasTitleRequiredError =>
      formErrors.contains(EditRecordDetailsFormError.titleRequired);
  bool get hasTranscriptionRequiredError =>
      formErrors.contains(EditRecordDetailsFormError.transcriptionRequired);
}
