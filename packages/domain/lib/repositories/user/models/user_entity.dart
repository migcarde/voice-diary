import 'package:core/core.dart';
import 'package:remote/remote/user/models/user_remote_entity.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.email,
    required this.locale,
  });

  final String uid;
  final String email;
  final String locale;

  UserRemoteEntity get remoteEntity =>
      UserRemoteEntity(uid: uid, email: email, locale: locale);

  @override
  List<Object?> get props => [uid, email, locale];
}

extension UserRemoteEntityExtensions on UserRemoteEntity {
  UserEntity get entity => UserEntity(uid: uid, email: email, locale: locale);
}
