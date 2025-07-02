import 'package:domain/base/base_use_case.dart';
import 'package:domain/repositories/record/models/save_record_entity.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:result/result.dart';

class SaveRecord implements BaseUseCase<void, SaveRecordEntity> {
  const SaveRecord({
    required this.recordRepository,
  });

  final RecordRepository recordRepository;

  @override
  Future<Result<void>> call(SaveRecordEntity params) async =>
      recordRepository.saveRecord(params);
}
