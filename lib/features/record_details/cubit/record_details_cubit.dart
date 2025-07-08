import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:voice_diary/features/record_details/models/record_details_view_model.dart';

part 'record_details_state.dart';

class RecordDetailsCubit extends Cubit<RecordDetailsState> {
  RecordDetailsCubit({
    required this.deleteRecord,
  }) : super(const RecordDetailsState());

  final DeleteRecord deleteRecord;

  void init(RecordDetailsViewModel recordDetailsViewModel) => emit(
        state.copyWith(
          recordDetailsViewModel: recordDetailsViewModel,
        ),
      );

  Future<void> delete() async {
    if (state.recordDetailsViewModel != null) {
      emit(
        state.copyWith(
          status: RecordDetailsStatus.loading,
        ),
      );

      final result = await deleteRecord(state.recordDetailsViewModel!.id);
      result.when(
        (_) => emit(
          state.copyWith(
            status: RecordDetailsStatus.success,
          ),
        ),
        (failure) => emit(
          state.copyWith(
            status: RecordDetailsStatus.failure,
          ),
        ),
      );
    }
  }
}
