import 'package:core/core.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:domain/use_cases/record/delete_record.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class RecordRepositoryMock extends Mock implements RecordRepository {}

void main() {
  late RecordRepositoryMock recordRepository;
  late DeleteRecord deleteRecord;

  setUp(() {
    recordRepository = RecordRepositoryMock();
    deleteRecord = DeleteRecord(recordRepository: recordRepository);
  });

  group('Delete record', () {
    test('Success', () async {
      // Given
      when(
        () => recordRepository.deleteRecord(1),
      ).thenAnswer((_) async => Result.success(null));

      // When
      final result = await deleteRecord(1);

      // Then
      expect(result, isA<Success>());
      verify(() => recordRepository.deleteRecord(1)).called(1);
    });

    test('Failure', () async {
      // Given
      when(
        () => recordRepository.deleteRecord(1),
      ).thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await deleteRecord(1);

      // Then
      expect(result, isA<Failure>());
      verify(() => recordRepository.deleteRecord(1)).called(1);
    });
  });
}
