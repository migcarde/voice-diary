import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/_base/result.dart';
import 'package:firebase_login/firebase_login_service.dart';
import 'package:firebase_login/models/firebase_auth_errors.dart';
import 'package:firebase_login/models/firebase_user.dart';

class FirebaseLoginServiceImpl implements FirebaseLoginService {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  @override
  Future<Result<FirebaseUser>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(result.user!.firebaseUser);
    } on FirebaseAuthException catch (e) {
      return Result.failure(
        FirebaseAuthErrors.fromString(
          e.code,
        ),
      );
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _instance.signOut();

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<FirebaseUser>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(result.user!.firebaseUser);
    } on FirebaseAuthException catch (e) {
      return Result.failure(
        FirebaseAuthErrors.fromString(
          e.code,
        ),
      );
    }
  }

  @override
  Stream<User?> listenChanges() => _instance.userChanges();

  @override
  bool get isLoggedIn => _instance.currentUser != null;

  @override
  String get uid => _instance.currentUser?.uid ?? '';

  @override
  Future<Result<void>> deleteAccount() async {
    try {
      await _instance.currentUser?.delete();

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> reauthenticate({
    required String email,
    required String password,
  }) async {
    try {
      await _instance.currentUser?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: password,
        ),
      );

      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(
        FirebaseAuthErrors.fromString(
          e.code,
        ),
      );
    }
  }
}
