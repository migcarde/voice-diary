import 'package:core/core.dart';
import 'package:result/result.dart';

abstract class BaseUseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
