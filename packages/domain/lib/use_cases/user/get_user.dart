import 'package:domain/base/base_use_case.dart';
import 'package:domain/repositories/user/models/user_entity.dart';
import 'package:domain/repositories/user/user_repository.dart';
import 'package:result/result.dart';

class GetUser implements BaseUseCase<UserEntity, String> {
  const GetUser({required this.userRepository});

  final UserRepository userRepository;
  @override
  Future<Result<UserEntity>> call(String params) async =>
      userRepository.getUser(params);
}
