import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:domain/repositories/record/models/record_entity.dart';
import 'package:domain/use_cases/record/update_record.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';
import 'package:voice_diary/features/record_details/edit_record_details/cubit/edit_record_details_cubit.dart';
import 'package:voice_diary/features/record_details/edit_record_details/models/edit_record_details_view_model.dart';

class MockUpdateRecord extends Mock implements UpdateRecord {}

void main() {
  late MockUpdateRecord updateRecord;
  late EditRecordDetailsCubit cubit;

  setUp(() {
    updateRecord = MockUpdateRecord();
    cubit = EditRecordDetailsCubit(
      updateRecord: updateRecord,
    );
  });

  final today = DateTime.now();

  final editRecordDetailsViewModel = EditRecordDetailsViewModel(
    id: 1,
    title: 'title',
    date: today,
    path: 'path',
    tags: ['tag1', 'tag2'],
    transcription: 'transcription',
    duration: const Duration(seconds: 104),
  );

  final editRecordDetailsViewModelThreeTags = EditRecordDetailsViewModel(
    id: 1,
    title: 'title',
    date: today,
    path: 'path',
    tags: ['tag1', 'tag2', 'tag3'],
    transcription: 'transcription',
    duration: const Duration(seconds: 104),
  );

  final editRecordDetailsModifiedViewModel = EditRecordDetailsViewModel(
    id: 1,
    title: 'title2',
    date: today,
    path: 'path',
    tags: ['tag1', 'tag2'],
    transcription: 'transcription2',
    duration: const Duration(seconds: 104),
  );

  final editRecordEntity = RecordEntity(
    id: 1,
    title: 'title2',
    date: today,
    path: 'path',
    tags: ['tag1', 'tag2'],
    transcription: 'transcription2',
    duration: const Duration(seconds: 104),
  );

  group('Init', () {
    blocTest<EditRecordDetailsCubit, EditRecordDetailsState>(
      'emits [editRecordDetailsViewModel] when init is called.',
      build: () => cubit,
      act: (_) => cubit.init(editRecordDetailsViewModel),
      expect: () => <EditRecordDetailsState>[
        EditRecordDetailsState(
          editRecordDetailsViewModel: editRecordDetailsViewModel,
        ),
      ],
    );
  });

  group('Add tag', () {
    blocTest<EditRecordDetailsCubit, EditRecordDetailsState>(
      'emits [tags] with tag3 when addTag is called.',
      build: () => cubit,
      act: (_) => cubit.addTag('tag3'),
      seed: () => EditRecordDetailsState(
        editRecordDetailsViewModel: editRecordDetailsViewModel,
      ),
      expect: () => <EditRecordDetailsState>[
        EditRecordDetailsState(
          editRecordDetailsViewModel: editRecordDetailsViewModelThreeTags,
        ),
      ],
    );
  });

  group('Remove tag', () {
    blocTest<EditRecordDetailsCubit, EditRecordDetailsState>(
      'emits [tags] without tag3 when removeTag is called.',
      build: () => cubit,
      act: (_) => cubit.removeTag('tag3'),
      seed: () => EditRecordDetailsState(
        editRecordDetailsViewModel: editRecordDetailsViewModelThreeTags,
      ),
      expect: () => <EditRecordDetailsState>[
        EditRecordDetailsState(
          editRecordDetailsViewModel: editRecordDetailsViewModel,
        ),
      ],
    );
  });

  group('Save record', () {
    blocTest<EditRecordDetailsCubit, EditRecordDetailsState>(
      'emits [success] when saveRecord called successfully.',
      build: () => cubit,
      act: (_) => cubit.saveRecord(
        title: 'title2',
        text: 'transcription2',
      ),
      seed: () => EditRecordDetailsState(
        editRecordDetailsViewModel: editRecordDetailsViewModel,
      ),
      setUp: () {
        // Given
        when(
          () => updateRecord(
            editRecordEntity,
          ),
        ).thenAnswer((_) async => Result.success(null));
      },
      expect: () => <EditRecordDetailsState>[
        EditRecordDetailsState(
          status: EditRecordDetailsStatus.loading,
          editRecordDetailsViewModel: editRecordDetailsViewModel,
        ),
        EditRecordDetailsState(
          status: EditRecordDetailsStatus.loading,
          editRecordDetailsViewModel: editRecordDetailsModifiedViewModel,
        ),
        EditRecordDetailsState(
          status: EditRecordDetailsStatus.success,
          editRecordDetailsViewModel: editRecordDetailsModifiedViewModel,
        ),
      ],
    );

    blocTest<EditRecordDetailsCubit, EditRecordDetailsState>(
      'emits [failure] when saveRecord throws an exception.',
      build: () => cubit,
      act: (_) => cubit.saveRecord(
        title: 'title2',
        text: 'transcription2',
      ),
      seed: () => EditRecordDetailsState(
        editRecordDetailsViewModel: editRecordDetailsViewModel,
      ),
      setUp: () {
        // Given
        when(
          () => updateRecord(
            editRecordEntity,
          ),
        ).thenAnswer((_) async => Result.failure(Exception()));
      },
      expect: () => <EditRecordDetailsState>[
        EditRecordDetailsState(
          status: EditRecordDetailsStatus.loading,
          editRecordDetailsViewModel: editRecordDetailsViewModel,
        ),
        EditRecordDetailsState(
          status: EditRecordDetailsStatus.loading,
          editRecordDetailsViewModel: editRecordDetailsModifiedViewModel,
        ),
        EditRecordDetailsState(
          status: EditRecordDetailsStatus.failure,
          editRecordDetailsViewModel: editRecordDetailsModifiedViewModel,
        ),
      ],
    );

    blocTest<EditRecordDetailsCubit, EditRecordDetailsState>(
      'emits [initial] when saveRecord called with empty title and text.',
      build: () => cubit,
      act: (_) => cubit.saveRecord(
        title: '',
        text: '',
      ),
      seed: () => EditRecordDetailsState(
        editRecordDetailsViewModel: editRecordDetailsViewModel,
      ),
      expect: () => <EditRecordDetailsState>[
        EditRecordDetailsState(
          status: EditRecordDetailsStatus.loading,
          editRecordDetailsViewModel: editRecordDetailsViewModel,
          formErrors: [
            EditRecordDetailsFormError.titleRequired,
            EditRecordDetailsFormError.transcriptionRequired,
          ],
        ),
      ],
    );
  });
}
