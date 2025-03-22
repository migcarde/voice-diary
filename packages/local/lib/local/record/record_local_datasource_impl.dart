import 'package:local/local/core/object_box.dart';
import 'package:local/local/record/models/record_local_entity.dart';
import 'package:local/local/record/record_local_datasource.dart';

class RecordLocalDatasourceImpl implements RecordLocalDatasource {
  const RecordLocalDatasourceImpl({
    required this.localDatasource,
  });

  final ObjectBox localDatasource;

  @override
  Future<void> deleteRecord(int id) async => await localDatasource.remove(id);

  @override
  Future<List<RecordLocalEntity>> getRecords() async {
    final records = await localDatasource.getAll<RecordLocalEntity>();

    return records;
  }

  @override
  Future<void> saveRecord(RecordLocalEntity record) async =>
      await localDatasource.save<RecordLocalEntity>(record);
}
