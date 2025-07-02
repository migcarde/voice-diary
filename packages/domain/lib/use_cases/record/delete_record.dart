import 'package:domain/domain.dart';
import 'package:domain/repositories/record/record_repository.dart';
import 'package:result/result.dart';

class DeleteRecord implements BaseUseCase<void, int> {
  const DeleteRecord({
    required this.recordRepository,
  });

  final RecordRepository recordRepository;
  @override
  Future<Result<void>> call(int params) async =>
      recordRepository.deleteRecord(params);
}
