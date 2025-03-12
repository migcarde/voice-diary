import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/user/models/user_entity.dart';
import 'package:domain/repositories/user/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  late UserRepositoryMock userRepository;
  late SaveUser saveUser;

  setUp(() {
    userRepository = UserRepositoryMock();
    saveUser = SaveUser(userRepository: userRepository);
  });

  group('Save user', () {
    final userEntity = UserEntity(uid: 'uid', email: 'email', locale: 'locale');
    test('Success', () async {
      // Given
      when(
        () => userRepository.saveUser(userEntity),
      ).thenAnswer((_) async => Result.success(null));

      // When
      final result = await saveUser(userEntity);

      // Then
      expect(result, isA<Success>());
      verify(() => userRepository.saveUser(userEntity)).called(1);
    });

    test('Failure', () async {
      // Given
      when(
        () => userRepository.saveUser(userEntity),
      ).thenAnswer((_) async => Result.failure(Exception()));

      // When
      final result = await saveUser(userEntity);

      // Then
      expect(result, isA<Failure>());
      verify(() => userRepository.saveUser(userEntity)).called(1);
    });
  });
}
