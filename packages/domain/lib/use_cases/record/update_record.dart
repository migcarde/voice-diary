import 'package:domain/domain.dart';
import 'package:domain/repositories/record/models/record_entity.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:result/result.dart';

class UpdateRecord implements BaseUseCase<void, RecordEntity> {
  const UpdateRecord({
    required this.recordRepository,
  });

  final RecordRepository recordRepository;

  @override
  Future<Result<void>> call(RecordEntity params) async =>
      recordRepository.updateRecord(params);
}
