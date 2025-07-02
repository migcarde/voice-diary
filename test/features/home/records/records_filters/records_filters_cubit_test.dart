import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_diary/features/home/records/records_filters/cubit/records_filters_cubit.dart';

void main() {
  late RecordsFiltersCubit recordsFiltersCubit;

  setUp(() {
    recordsFiltersCubit = RecordsFiltersCubit();
  });

  group('Init', () {
    final tags = <String>{'tag1', 'tag2', 'tag3'};
    blocTest<RecordsFiltersCubit, RecordsFiltersState>(
      'emits [tags, filteredTags] when init is success.',
      build: () => recordsFiltersCubit,
      act: (bloc) => recordsFiltersCubit.init(tags),
      expect: () => <RecordsFiltersState>[
        RecordsFiltersState(
          tags: tags,
          filteredTags: tags,
        ),
      ],
    );
  });

  group('Search', () {
    final tags = <String>{'tag1', 'tag2', 'tag3'};
    blocTest<RecordsFiltersCubit, RecordsFiltersState>(
      'emits [filteredTags] when finds one',
      seed: () => RecordsFiltersState(
        tags: tags,
        filteredTags: tags,
      ),
      build: () => recordsFiltersCubit,
      act: (bloc) => recordsFiltersCubit.searchTag('tag1'),
      expect: () => <RecordsFiltersState>[
        RecordsFiltersState(
          tags: tags,
          filteredTags: {'tag1'},
        ),
      ],
    );

    blocTest<RecordsFiltersCubit, RecordsFiltersState>(
      'emits [filteredTags] when finds all',
      seed: () => RecordsFiltersState(
        tags: tags,
        filteredTags: tags,
      ),
      build: () => recordsFiltersCubit,
      act: (bloc) => recordsFiltersCubit.searchTag('tag'),
      expect: () => <RecordsFiltersState>[],
    );

    blocTest<RecordsFiltersCubit, RecordsFiltersState>(
      'emits [filteredTags] empty when finds nothing',
      seed: () => RecordsFiltersState(
        tags: tags,
        filteredTags: tags,
      ),
      build: () => recordsFiltersCubit,
      act: (bloc) => recordsFiltersCubit.searchTag('tag4'),
      expect: () => <RecordsFiltersState>[
        RecordsFiltersState(
          tags: tags,
          filteredTags: {},
        ),
      ],
    );

    blocTest<RecordsFiltersCubit, RecordsFiltersState>(
      'emits [filteredTags] when tag to search is empty',
      seed: () => RecordsFiltersState(
        tags: tags,
        filteredTags: {'tag1'},
      ),
      build: () => recordsFiltersCubit,
      act: (bloc) => recordsFiltersCubit.searchTag(''),
      expect: () => <RecordsFiltersState>[
        RecordsFiltersState(
          tags: tags,
          filteredTags: tags,
        ),
      ],
    );
  });

  group('Remove tag', () {
    final tags = <String>{'tag1', 'tag2', 'tag3'};
    blocTest<RecordsFiltersCubit, RecordsFiltersState>(
      'emits [tags, filteredTags] when remove tag is success.',
      build: () => recordsFiltersCubit,
      seed: () => RecordsFiltersState(
        tags: tags,
        filteredTags: {'tag1', 'tag2'},
        selectedTags: {'tag3'},
      ),
      act: (bloc) => recordsFiltersCubit.removeTag('tag3'),
      expect: () => <RecordsFiltersState>[
        RecordsFiltersState(
          tags: tags,
          filteredTags: tags,
          selectedTags: {},
        ),
      ],
    );
  });

  group('Add tag', () {
    final tags = <String>{'tag1', 'tag2', 'tag3'};
    blocTest<RecordsFiltersCubit, RecordsFiltersState>(
      'emits [tags, filteredTags] when add tag is success.',
      build: () => recordsFiltersCubit,
      seed: () => RecordsFiltersState(
        tags: tags,
        filteredTags: tags,
      ),
      act: (bloc) => recordsFiltersCubit.addTag('tag3'),
      expect: () => <RecordsFiltersState>[
        RecordsFiltersState(
          tags: tags,
          filteredTags: {'tag1', 'tag2'},
          selectedTags: {'tag3'},
        ),
      ],
    );
  });
}
