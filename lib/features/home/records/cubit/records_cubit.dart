import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:voice_diary/features/home/records/models/record_view_model.dart';

part 'records_state.dart';

class RecordsCubit extends Cubit<RecordsState> {
  RecordsCubit({
    required this.getAllRecords,
  }) : super(const RecordsState());

  final GetAllRecords getAllRecords;

  Future<void> init() async {
    emit(
      state.copyWith(
        status: RecordsStatus.loading,
      ),
    );

    final result = await getAllRecords(NoParams());

    result.when(
      (records) => emit(
        state.copyWith(
          status: records.isEmpty ? RecordsStatus.empty : RecordsStatus.data,
          records: records.map((record) => record.viewModel).toList(),
        ),
      ),
      (failure) => emit(
        state.copyWith(
          status: RecordsStatus.error,
        ),
      ),
    );
  }
}
