import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/user/models/user_entity.dart';
import 'package:domain/repositories/user/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  late UserRepositoryMock userRepository;
  late GetUser getUser;

  setUp(() {
    userRepository = UserRepositoryMock();
    getUser = GetUser(userRepository: userRepository);
  });

  final userEntity = UserEntity(uid: 'uid', email: 'email', locale: 'locale');

  group('Get user', () {
    test('Success', () async {
      // Given
      when(
        () => userRepository.getUser('uid'),
      ).thenAnswer((_) async => Result.success(userEntity));

      // When
      final result = await getUser('uid');

      // Then
      expect((result as Success).data, userEntity);
      verify(() => userRepository.getUser('uid')).called(1);
    });

    test('Failure', () async {
      // Given
      when(
        () => userRepository.getUser('uid'),
      ).thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await getUser('uid');

      // Then
      expect(result, isA<Failure>());
      verify(() => userRepository.getUser('uid')).called(1);
    });
  });
}
