import 'package:domain/base/base_use_case.dart';
import 'package:domain/repositories/user/user_repository.dart';
import 'package:result/result.dart';

class DeleteUser implements BaseUseCase<void, String> {
  const DeleteUser({required this.userRepository});

  final UserRepository userRepository;
  @override
  Future<Result<void>> call(String params) async =>
      userRepository.deleteUser(params);
}
