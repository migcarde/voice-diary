import 'package:remote/remote/user/models/user_remote_entity.dart';

abstract class UserRemoteDatasource {
  Future<void> saveUser(UserRemoteEntity user);
  Future<UserRemoteEntity> getUser(String uid);
  Future<void> deleteUser(String uid);
}
