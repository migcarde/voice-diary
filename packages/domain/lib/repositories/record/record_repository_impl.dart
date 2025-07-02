import 'package:domain/repositories/record/models/record_entity.dart';
import 'package:domain/repositories/record/models/save_record_entity.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:local/local/record/record_local_datasource.dart';
import 'package:result/result.dart';

class RecordRepositoryImpl implements RecordRepository {
  const RecordRepositoryImpl({
    required this.localDatasource,
  });

  final RecordLocalDatasource localDatasource;
  @override
  Future<Result<void>> deleteRecord(int id) async {
    try {
      await localDatasource.deleteRecord(id);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<RecordEntity>>> getRecords() async {
    try {
      final result = await localDatasource.getRecords();

      return Result.success(
        result.map((e) => e.entity).toList(),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> saveRecord(SaveRecordEntity record) async {
    try {
      await localDatasource.saveRecord(record.localEntity);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateRecord(RecordEntity record) async {
    try {
      await localDatasource.editRecord(record.localEntity);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
