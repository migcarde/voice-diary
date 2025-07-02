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
      (records) {
        final recordsViewModel =
            records.map((record) => record.viewModel).toList();

        emit(
          state.copyWith(
            status: records.isEmpty ? RecordsStatus.empty : RecordsStatus.data,
            records: recordsViewModel,
            filteredRecords: recordsViewModel,
            tags: records.expand((record) => record.tags).toSet(),
          ),
        );
      },
      (failure) => emit(
        state.copyWith(
          status: RecordsStatus.error,
        ),
      ),
    );
  }

  void searchByTag(Set<String> tags) {
    if (tags.isEmpty) {
      emit(
        state.copyWith(
          filteredRecords: state.records,
        ),
      );
    } else {
      final filteredRecords = state.records
          .where((record) => record.tags.any((tag) => tags.contains(tag)))
          .toList();

      emit(
        state.copyWith(
          filteredRecords: filteredRecords,
        ),
      );
    }
  }
}
