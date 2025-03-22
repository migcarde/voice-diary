import 'package:local/local/record/models/record_local_entity.dart';

abstract class RecordLocalDatasource {
  Future<void> saveRecord(RecordLocalEntity record);
  Future<void> deleteRecord(int id);
  Future<List<RecordLocalEntity>> getRecords();
}
