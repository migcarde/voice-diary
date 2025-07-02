import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:voice_diary/features/record_details/models/record_details_view_model.dart';

part 'record_details_state.dart';

class RecordDetailsCubit extends Cubit<RecordDetailsState> {
  RecordDetailsCubit() : super(const RecordDetailsState());

  void init(RecordDetailsViewModel recordDetailsViewModel) => emit(
        state.copyWith(
          recordDetailsViewModel: recordDetailsViewModel,
        ),
      );
}
