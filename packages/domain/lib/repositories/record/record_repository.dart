import 'package:domain/repositories/record/models/record_entity.dart';
import 'package:domain/repositories/record/models/save_record_entity.dart';
import 'package:result/result.dart';

abstract class RecordRepository {
  Future<Result<void>> saveRecord(SaveRecordEntity record);
  Future<Result<void>> deleteRecord(int id);
  Future<Result<List<RecordEntity>>> getRecords();
  Future<Result<void>> updateRecord(RecordEntity record);
}
