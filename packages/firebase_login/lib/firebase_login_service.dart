import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/models/firebase_user.dart';

abstract class FirebaseLoginService {
  Future<FirebaseUser> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<FirebaseUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Stream<User?> listenChanges();
  bool get isLoggedIn;
  String get uid;
}
