import 'package:domain/domain.dart';
import 'package:domain/repositories/record/models/record_entity.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:result/result.dart';

class GetAllRecords implements BaseUseCase<List<RecordEntity>, NoParams> {
  const GetAllRecords({
    required this.recordRepository,
  });

  final RecordRepository recordRepository;
  @override
  Future<Result<List<RecordEntity>>> call(NoParams params) async =>
      recordRepository.getRecords();
}
