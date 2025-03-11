import 'package:core/core.dart';

class UserViewModel extends Equatable {
  const UserViewModel({
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
