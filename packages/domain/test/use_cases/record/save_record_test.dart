import 'package:core/core.dart';
import 'package:domain/repositories/record/models/save_record_entity.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:domain/use_cases/use_cases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class RecordRepositoryMock extends Mock implements RecordRepository {}

void main() {
  late RecordRepositoryMock recordRepository;
  late SaveRecord saveRecord;

  setUp(() {
    recordRepository = RecordRepositoryMock();
    saveRecord = SaveRecord(recordRepository: recordRepository);
  });

  final date = DateTime.now();
  final saveRecordEntity = SaveRecordEntity(
    title: 'Title',
    date: date,
    path: 'Path',
    tags: [],
    transcription: 'Transcription',
  );

  group('Save record', () {
    test('Success', () async {
      // Given
      when(
        () => recordRepository.saveRecord(saveRecordEntity),
      ).thenAnswer((_) async => Result.success(null));

      // When
      final result = await saveRecord(saveRecordEntity);

      // Then
      expect(result, isA<Success>());
      verify(() => recordRepository.saveRecord(saveRecordEntity)).called(1);
    });

    test('Failure', () async {
      // Given
      when(
        () => recordRepository.saveRecord(saveRecordEntity),
      ).thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await saveRecord(saveRecordEntity);

      // Then
      expect(result, isA<Failure>());
      verify(() => recordRepository.saveRecord(saveRecordEntity)).called(1);
    });
  });
}
