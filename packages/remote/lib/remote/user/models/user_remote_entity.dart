import 'package:core/core.dart';

class UserRemoteEntity extends Equatable {
  const UserRemoteEntity({
    required this.uid,
    required this.email,
    required this.locale,
  });

  final String uid;
  final String email;
  final String locale;

  factory UserRemoteEntity.fromJson({
    required String uid,
    required Map<String, dynamic> json,
  }) =>
      UserRemoteEntity(uid: uid, email: json['email'], locale: json['locale']);

  Map<String, dynamic> toJson() => {'email': email, 'locale': locale};

  @override
  List<Object?> get props => [uid, email, locale];
}
