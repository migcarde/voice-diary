import 'package:core/core.dart';
import 'package:domain/repositories/record/models/record_entity.dart';
import 'package:domain/repositories/record/models/save_record_entity.dart';
import 'package:domain/repositories/record/record_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local/local/record/models/record_local_entity.dart';
import 'package:local/local/record/record_local_datasource.dart';
import 'package:result/result.dart';

class RecordLocalDatasourceMock extends Mock implements RecordLocalDatasource {}

void main() {
  late RecordLocalDatasourceMock recordLocalDatasource;
  late RecordRepositoryImpl recordRepository;

  setUp(() {
    recordLocalDatasource = RecordLocalDatasourceMock();
    recordRepository =
        RecordRepositoryImpl(localDatasource: recordLocalDatasource);
  });

  final date = DateTime.now();
  final recordLocalEntity = RecordLocalEntity(
    id: 1,
    title: 'Title',
    date: date,
    path: 'Path',
    tags: [],
  );
  final recordLocalEntityWithourId = RecordLocalEntity(
    id: 0,
    title: 'Title',
    date: date,
    path: 'Path',
    tags: [],
  );
  final recordEntity = RecordEntity(
    id: 1,
    title: 'Title',
    date: date,
    path: 'Path',
    tags: [],
  );
  final saveRecordEntity = SaveRecordEntity(
    title: 'Title',
    date: date,
    path: 'Path',
    tags: [],
  );

  group('Get all records', () {
    test('Success', () async {
      // Given
      when(() => recordLocalDatasource.getRecords()).thenAnswer(
        (_) async => [
          recordLocalEntity,
        ],
      );

      // When
      final result = await recordRepository.getRecords();

      // Then
      expect((result as Success).data, [recordEntity]);
      verify(() => recordLocalDatasource.getRecords()).called(1);
    });

    test('Empty', () async {
      // Given
      when(() => recordLocalDatasource.getRecords()).thenAnswer(
        (_) async => [],
      );

      // When
      final result = await recordRepository.getRecords();

      // Then
      expect((result as Success).data, []);
      verify(() => recordLocalDatasource.getRecords()).called(1);
    });

    test('Failure', () async {
      // Given
      when(() => recordLocalDatasource.getRecords()).thenThrow(
        Exception(),
      );

      // When
      final result = await recordRepository.getRecords();

      // Then
      expect(result, isA<Failure>());
      verify(() => recordLocalDatasource.getRecords()).called(1);
    });
  });

  group('Save record', () {
    test('Success', () async {
      // Given
      when(() => recordLocalDatasource.saveRecord(recordLocalEntityWithourId))
          .thenAnswer(
        (_) async {},
      );

      // When
      final result = await recordRepository.saveRecord(saveRecordEntity);

      // Then
      expect(result, isA<Success>());
      verify(() => recordLocalDatasource.saveRecord(recordLocalEntityWithourId))
          .called(1);
    });

    test('Failure', () async {
      // Given
      when(() => recordLocalDatasource.saveRecord(recordLocalEntityWithourId))
          .thenThrow(Exception());

      // When
      final result = await recordRepository.saveRecord(saveRecordEntity);

      // Then
      expect(result, isA<Failure>());
      verify(() => recordLocalDatasource.saveRecord(recordLocalEntityWithourId))
          .called(1);
    });
  });

  group('Delete record', () {
    test('Success', () async {
      // Given
      when(() => recordLocalDatasource.deleteRecord(recordLocalEntity.id))
          .thenAnswer(
        (_) async {},
      );

      // When
      final result = await recordRepository.deleteRecord(recordEntity.id);

      // Then
      expect(result, isA<Success>());
      verify(() => recordLocalDatasource.deleteRecord(recordLocalEntity.id))
          .called(1);
    });

    test('Success', () async {
      // Given
      when(() => recordLocalDatasource.deleteRecord(recordLocalEntity.id))
          .thenThrow(Exception());

      // When
      final result = await recordRepository.deleteRecord(recordEntity.id);

      // Then
      expect(result, isA<Failure>());
      verify(() => recordLocalDatasource.deleteRecord(recordLocalEntity.id))
          .called(1);
    });
  });
}
