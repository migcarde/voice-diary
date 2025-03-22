import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:domain/use_cases/record/save_record.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/models/save_record_entry_view_model.dart';

part 'save_record_entry_state.dart';

class SaveRecordEntryCubit extends Cubit<SaveRecordEntryState> {
  SaveRecordEntryCubit({
    required this.saveRecord,
  }) : super(const SaveRecordEntryState());

  final SaveRecord saveRecord;

  void init(SaveRecordEntryViewModel viewModel) => emit(
        state.copyWith(
          viewModel: viewModel,
        ),
      );

  Future<void> save(String title) async {
    emit(
      state.copyWith(
        status: SaveRecordEntryStatus.loading,
      ),
    );

    if (state.viewModel != null) {
      final result = await saveRecord(
        state.viewModel!.copyWith(title: title).entity,
      );

      result.when(
        (_) => emit(
          state.copyWith(
            status: SaveRecordEntryStatus.success,
          ),
        ),
        (_) => emit(
          state.copyWith(
            status: SaveRecordEntryStatus.failure,
          ),
        ),
      );
    }
  }

  void addTag(String tag) {
    if (tag.isNotEmpty) {
      final List<String> tags = [
        ...state.viewModel?.tags ?? [],
        tag,
      ];
      final viewModel = state.viewModel?.copyWith(
        tags: tags,
      );

      emit(
        state.copyWith(
          viewModel: viewModel,
        ),
      );
    }
  }

  void removeTag(String tag) {
    final List<String> tags = <String>[
      ...state.viewModel?.tags ?? [],
    ];
    tags.remove(tag);

    final viewModel = state.viewModel?.copyWith(
      tags: tags,
    );

    emit(
      state.copyWith(
        viewModel: viewModel,
      ),
    );
  }
}
