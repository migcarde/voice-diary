import 'package:domain/base/result.dart';
import 'package:domain/repositories/user/models/user_entity.dart';
import 'package:domain/repositories/user/user_repository.dart';
import 'package:remote/remote.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.remoteDatasource});

  final UserRemoteDatasource remoteDatasource;

  @override
  Future<Result<void>> deleteUser(String uid) async {
    try {
      await remoteDatasource.deleteUser(uid);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserEntity>> getUser(String uid) async {
    try {
      final result = await remoteDatasource.getUser(uid);

      return Result.success(result.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> saveUser(UserEntity user) async {
    try {
      final result = await remoteDatasource.saveUser(user.remoteEntity);

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
