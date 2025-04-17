import 'package:core/core.dart';
import 'package:domain/base/base_use_case.dart';
import 'package:domain/repositories/record/models/record_entity.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:domain/use_cases/record/get_all_records.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class RecordRepositoryMock extends Mock implements RecordRepository {}

void main() {
  late RecordRepositoryMock recordRepository;
  late GetAllRecords getAllRecords;

  setUp(() {
    recordRepository = RecordRepositoryMock();
    getAllRecords = GetAllRecords(recordRepository: recordRepository);
  });

  final date = DateTime.now();
  final recordEntity = RecordEntity(
    id: 1,
    title: 'Title',
    date: date,
    path: 'Path',
    tags: [],
    transcription: 'Transcription',
  );

  group('Get all records', () {
    test('Success', () async {
      // Given
      when(
        () => recordRepository.getRecords(),
      ).thenAnswer((_) async => Result.success([recordEntity]));

      // When
      final result = await getAllRecords(NoParams());

      // Then
      expect((result as Success).data, [recordEntity]);
      verify(() => recordRepository.getRecords()).called(1);
    });

    test('Empty', () async {
      // Given
      when(
        () => recordRepository.getRecords(),
      ).thenAnswer((_) async => Result.success([]));

      // When
      final result = await getAllRecords(NoParams());

      // Then
      expect(result, isA<Success>());
      verify(() => recordRepository.getRecords()).called(1);
    });

    test('Failure', () async {
      // Given
      when(
        () => recordRepository.getRecords(),
      ).thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await getAllRecords(NoParams());

      // Then
      expect(result, isA<Failure>());
      verify(() => recordRepository.getRecords()).called(1);
    });
  });
}
