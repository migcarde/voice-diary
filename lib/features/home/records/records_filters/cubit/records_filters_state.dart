part of 'records_filters_cubit.dart';

class RecordsFiltersState extends Equatable {
  const RecordsFiltersState({
    this.tags = const {},
    this.filteredTags = const {},
    this.selectedTags = const {},
  });

  final Set<String> tags;
  final Set<String> filteredTags;
  final Set<String> selectedTags;

  @override
  List<Object?> get props => [
        tags,
        filteredTags,
        selectedTags,
      ];

  RecordsFiltersState copyWith({
    Set<String>? tags,
    Set<String>? filteredTags,
    Set<String>? selectedTags,
  }) =>
      RecordsFiltersState(
        tags: tags ?? this.tags,
        filteredTags: filteredTags ?? this.filteredTags,
        selectedTags: selectedTags ?? this.selectedTags,
      );
}
