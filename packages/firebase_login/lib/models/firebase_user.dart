import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUser extends Equatable {
  const FirebaseUser({
    required this.uid,
    required this.email,
  });

  final String uid;
  final String email;

  @override
  List<Object?> get props => [
        uid,
        email,
      ];
}

extension UserFromFirebaseExtensions on User {
  FirebaseUser get firebaseUser => FirebaseUser(
        uid: uid,
        email: email ?? '',
      );
}
