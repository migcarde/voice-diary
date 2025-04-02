import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/models/firebase_user.dart';
import 'package:result/result.dart';

abstract class FirebaseLoginService {
  Future<Result<FirebaseUser>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Result<void>> logout();
  Future<Result<FirebaseUser>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Stream<User?> listenChanges();
  bool get isLoggedIn;
  String get uid;
  Future<Result<void>> deleteAccount();
  Future<Result<void>> reauthenticate({
    required String email,
    required String password,
  });
}
