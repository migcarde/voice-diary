import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:domain/use_cases/record/save_record.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/cubit/save_record_entry_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/models/save_record_entry_view_model.dart';

class SaveRecordMock extends Mock implements SaveRecord {}

void main() {
  late SaveRecordMock saveRecord;
  late SaveRecordEntryCubit saveRecordEntryCubit;

  setUp(() {
    saveRecord = SaveRecordMock();
    saveRecordEntryCubit = SaveRecordEntryCubit(
      saveRecord: saveRecord,
    );
  });

  final date = DateTime.now();
  final viewModel = SaveRecordEntryViewModel(
    title: 'title',
    date: date,
    path: 'path',
    tags: [],
    transcription: 'Transcription',
    duration: Duration(seconds: 1),
  );
  final editedViewModel = SaveRecordEntryViewModel(
    title: 'test',
    date: date,
    path: 'path',
    tags: [],
    transcription: 'Transcription',
    duration: Duration(seconds: 1),
  );
  final viewModelWithTag = SaveRecordEntryViewModel(
    title: 'title',
    date: date,
    path: 'path',
    tags: ['test'],
    transcription: 'Transcription',
    duration: Duration(seconds: 1),
  );

  group('Init', () {
    blocTest<SaveRecordEntryCubit, SaveRecordEntryState>(
      'updates viewModel when init called.',
      build: () => saveRecordEntryCubit,
      act: (bloc) => saveRecordEntryCubit.init(viewModel),
      expect: () => <SaveRecordEntryState>[
        SaveRecordEntryState(
          viewModel: viewModel,
        ),
      ],
    );
  });

  group('Save', () {
    blocTest<SaveRecordEntryCubit, SaveRecordEntryState>(
      'emits [loading, success] when save is called successfully.',
      build: () => saveRecordEntryCubit,
      act: (bloc) => saveRecordEntryCubit.save('test'),
      seed: () => SaveRecordEntryState(
        viewModel: viewModel,
      ),
      setUp: () {
        when(() => saveRecord(editedViewModel.entity))
            .thenAnswer((_) async => Result.success(null));
      },
      expect: () => <SaveRecordEntryState>[
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.loading,
          viewModel: viewModel,
        ),
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.success,
          viewModel: viewModel,
        ),
      ],
    );

    blocTest<SaveRecordEntryCubit, SaveRecordEntryState>(
      'emits [titleRequiredError] when save is called and title is empty.',
      build: () => saveRecordEntryCubit,
      act: (bloc) => saveRecordEntryCubit.save(''),
      expect: () => <SaveRecordEntryState>[
        SaveRecordEntryState(
          titleRequiredError: true,
        ),
      ],
    );

    blocTest<SaveRecordEntryCubit, SaveRecordEntryState>(
      'emits [loading, failure] when save throws an exception.',
      build: () => saveRecordEntryCubit,
      act: (bloc) => saveRecordEntryCubit.save('test'),
      seed: () => SaveRecordEntryState(
        viewModel: viewModel,
      ),
      setUp: () {
        when(() => saveRecord(editedViewModel.entity))
            .thenAnswer((_) async => Result.failure(Exception()));
      },
      expect: () => <SaveRecordEntryState>[
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.loading,
          viewModel: viewModel,
        ),
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.failure,
          viewModel: viewModel,
        ),
      ],
    );
  });

  group('Add tag', () {
    blocTest<SaveRecordEntryCubit, SaveRecordEntryState>(
      'adds new tag on called successfully.',
      build: () => saveRecordEntryCubit,
      act: (bloc) => saveRecordEntryCubit.addTag('test'),
      seed: () => SaveRecordEntryState(
        viewModel: viewModel,
      ),
      expect: () => <SaveRecordEntryState>[
        SaveRecordEntryState(
          viewModel: viewModelWithTag,
        ),
      ],
    );
  });

  group('Remove tag', () {
    blocTest<SaveRecordEntryCubit, SaveRecordEntryState>(
      'remove tag on called successfully.',
      build: () => saveRecordEntryCubit,
      act: (bloc) => saveRecordEntryCubit.removeTag('test'),
      seed: () => SaveRecordEntryState(
        viewModel: viewModelWithTag,
      ),
      expect: () => <SaveRecordEntryState>[
        SaveRecordEntryState(
          viewModel: viewModel,
        ),
      ],
    );
  });
}
