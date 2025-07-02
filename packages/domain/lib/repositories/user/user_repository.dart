import 'package:domain/repositories/user/models/user_entity.dart';
import 'package:result/result.dart';

abstract class UserRepository {
  Future<Result<void>> saveUser(UserEntity user);
  Future<Result<UserEntity>> getUser(String uid);
  Future<Result<void>> deleteUser(String uid);
}
