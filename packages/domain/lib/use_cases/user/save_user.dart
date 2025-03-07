import 'package:domain/base/base_use_case.dart';
import 'package:domain/base/result.dart';
import 'package:domain/repositories/user/models/user_entity.dart';
import 'package:domain/repositories/user/user_repository.dart';

class SaveUser implements BaseUseCase<void, UserEntity> {
  const SaveUser({required this.userRepository});

  final UserRepository userRepository;
  @override
  Future<Result<void>> call(UserEntity params) async =>
      userRepository.saveUser(params);
}
