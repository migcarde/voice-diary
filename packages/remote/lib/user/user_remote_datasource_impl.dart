import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remote/user/models/user_remote_entity.dart';
import 'package:remote/user/user_remote_datasource.dart';

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<void> deleteUser(String uid) async =>
      await _collection.doc(uid).delete();

  @override
  Future<UserRemoteEntity> getUser(String uid) async {
    final result = await _collection.doc(uid).get();

    return UserRemoteEntity.fromJson(uid: uid, json: result.data()!);
  }

  @override
  Future<void> saveUser(UserRemoteEntity user) async =>
      _collection.doc(user.uid).set(user.toJson());
}
