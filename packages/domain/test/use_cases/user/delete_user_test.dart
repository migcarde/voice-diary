import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/user/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  late UserRepositoryMock userRepository;
  late DeleteUser deleteUser;

  setUp(() {
    userRepository = UserRepositoryMock();
    deleteUser = DeleteUser(userRepository: userRepository);
  });

  group('Delete user', () {
    test('Success', () async {
      // Given
      when(
        () => userRepository.deleteUser('uid'),
      ).thenAnswer((_) async => Result.success(null));

      // When
      final result = await deleteUser('uid');

      // Then
      expect(result, isA<Success>());
      verify(() => userRepository.deleteUser('uid')).called(1);
    });

    test('Failure', () async {
      // Given
      when(
        () => userRepository.deleteUser('uid'),
      ).thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await deleteUser('uid');

      // Then
      expect(result, isA<Failure>());
      verify(() => userRepository.deleteUser('uid')).called(1);
    });
  });
}
