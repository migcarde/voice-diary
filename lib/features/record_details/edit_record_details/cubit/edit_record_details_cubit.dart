import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:voice_diary/features/record_details/edit_record_details/models/edit_record_details_view_model.dart';

part 'edit_record_details_state.dart';

class EditRecordDetailsCubit extends Cubit<EditRecordDetailsState> {
  EditRecordDetailsCubit({
    required this.updateRecord,
  }) : super(const EditRecordDetailsState());

  final UpdateRecord updateRecord;

  void init(EditRecordDetailsViewModel viewModel) => emit(
        state.copyWith(
          editRecordDetailsViewModel: viewModel,
        ),
      );

  void editTitle(String title) {
    final editRecordDetailsViewModel =
        state.editRecordDetailsViewModel?.copyWith(
      title: title,
    );
    emit(
      state.copyWith(
        editRecordDetailsViewModel: editRecordDetailsViewModel,
      ),
    );
  }

  void addTag(String tag) {
    final List<String> tags = <String>[];
    tags.addAll(
      [
        ...state.editRecordDetailsViewModel?.tags ?? [],
        tag,
      ],
    );

    final editRecordDetailsViewModel =
        state.editRecordDetailsViewModel?.copyWith(
      tags: tags,
    );

    emit(
      state.copyWith(
        editRecordDetailsViewModel: editRecordDetailsViewModel,
      ),
    );
  }

  void removeTag(String tag) {
    final List<String> tags = <String>[];
    tags
      ..addAll(state.editRecordDetailsViewModel?.tags ?? [])
      ..remove(tag);

    final editRecordDetailsViewModel =
        state.editRecordDetailsViewModel?.copyWith(
      tags: tags,
    );

    emit(
      state.copyWith(
        editRecordDetailsViewModel: editRecordDetailsViewModel,
      ),
    );
  }

  void editTranscription(String transcription) {
    final editRecordDetailsViewModel =
        state.editRecordDetailsViewModel?.copyWith(
      transcription: transcription,
    );

    emit(
      state.copyWith(
        editRecordDetailsViewModel: editRecordDetailsViewModel,
      ),
    );
  }

  Future<void> saveRecord({
    required String title,
    required String text,
  }) async {
    emit(
      state.copyWith(
        status: EditRecordDetailsStatus.loading,
        formErrors: [
          if (title.isEmpty) EditRecordDetailsFormError.titleRequired,
          if (text.isEmpty) EditRecordDetailsFormError.transcriptionRequired,
        ],
      ),
    );

    if (state.editRecordDetailsViewModel != null && state.formErrors.isEmpty) {
      final editedRecord = state.editRecordDetailsViewModel!.copyWith(
        title: title,
        transcription: text,
      );
      emit(
        state.copyWith(
          editRecordDetailsViewModel: editedRecord,
        ),
      );

      final result = await updateRecord(editedRecord.entity);

      result.when(
        (_) => emit(
          state.copyWith(
            status: EditRecordDetailsStatus.success,
          ),
        ),
        (_) => emit(
          state.copyWith(
            status: EditRecordDetailsStatus.failure,
          ),
        ),
      );
    }
  }
}
