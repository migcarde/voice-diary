import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/firebase_login_service.dart';
import 'package:firebase_login/models/firebase_user.dart';

class FirebaseLoginServiceImpl implements FirebaseLoginService {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user!.firebaseUser;
  }

  @override
  // TODO: implement isLoggedIn
  bool get isLoggedIn => throw UnimplementedError();

  @override
  Stream<User?> listenChanges() {
    // TODO: implement listenChanges
    throw UnimplementedError();
  }

  @override
  Future<FirebaseUser> loginWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  // TODO: implement uid
  String get uid => throw UnimplementedError();
}
