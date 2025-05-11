import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:domain/use_cases/record/save_record.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
