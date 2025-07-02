import 'package:core/core.dart';
import 'package:domain/repositories/record/models/record_entity.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:domain/use_cases/record/update_record.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class MockRecordRepository extends Mock implements RecordRepository {}

void main() {
  late MockRecordRepository recordRepository;
  late UpdateRecord updateRecord;

  setUp(() {
    recordRepository = MockRecordRepository();
    updateRecord = UpdateRecord(recordRepository: recordRepository);
  });

  final date = DateTime.now();

  final recordEntity = RecordEntity(
    id: 1,
    title: 'Title',
    date: date,
    path: 'Path',
    tags: [],
    transcription: 'Transcription',
    duration: Duration(seconds: 1),
  );

  group('Update record', () {
    test('Success', () async {
      // Given
      when(() => recordRepository.updateRecord(recordEntity))
          .thenAnswer((_) async => Result.success(null));

      // When
      final result = await updateRecord(recordEntity);

      // Then
      expect(result, isA<Success>());
      verify(() => recordRepository.updateRecord(recordEntity)).called(1);
    });

    test('Failure', () async {
      // Given
      when(() => recordRepository.updateRecord(recordEntity))
          .thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await updateRecord(recordEntity);

      // Then
      expect(result, isA<Failure>());
      verify(() => recordRepository.updateRecord(recordEntity)).called(1);
    });
  });
}
