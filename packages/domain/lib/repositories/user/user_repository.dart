import 'package:domain/base/result.dart';
import 'package:domain/repositories/user/models/user_entity.dart';

abstract class UserRepository {
  Future<Result<void>> saveUser(UserEntity user);
  Future<Result<UserEntity>> getUser(String uid);
  Future<Result<void>> deleteUser(String uid);
}
