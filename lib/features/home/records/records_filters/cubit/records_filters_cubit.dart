import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

part 'records_filters_state.dart';

class RecordsFiltersCubit extends Cubit<RecordsFiltersState> {
  RecordsFiltersCubit() : super(const RecordsFiltersState());

  void init(Set<String> tags) => emit(
        state.copyWith(tags: tags, filteredTags: tags),
      );

  Future<void> searchTag(String tag) async => emit(
        state.copyWith(
          filteredTags: tag.isEmpty
              ? state.tags
              : state.tags.where((t) => t.contains(tag)).toSet(),
        ),
      );

  Future<void> removeTag(String tag) async {
    final selectedTags = {...state.selectedTags};
    final tags = {...state.filteredTags};
    selectedTags.remove(tag);
    tags.add(tag);

    emit(
      state.copyWith(
        selectedTags: selectedTags,
        filteredTags: tags,
      ),
    );
  }

  Future<void> addTag(String tag) async {
    final selectedTags = {...state.selectedTags};
    final tags = {...state.filteredTags};
    selectedTags.add(tag);
    tags.remove(tag);

    emit(
      state.copyWith(
        selectedTags: selectedTags,
        filteredTags: tags,
      ),
    );
  }
}
