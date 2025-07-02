import 'package:core/core.dart';
import 'package:domain/repositories/user/models/user_entity.dart';
import 'package:domain/repositories/user/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote/remote.dart';
import 'package:result/result.dart';

class UserRemoteDatasourceMock extends Mock implements UserRemoteDatasource {}

void main() {
  late UserRemoteDatasourceMock userRemoteDatasource;
  late UserRepositoryImpl userRepositoryImpl;

  setUp(() {
    userRemoteDatasource = UserRemoteDatasourceMock();
    userRepositoryImpl = UserRepositoryImpl(
      remoteDatasource: userRemoteDatasource,
    );
  });

  final userRemoteEntity = UserRemoteEntity(
    uid: 'uid',
    email: 'email',
    locale: 'locale',
  );
  final userEntity = UserEntity(uid: 'uid', email: 'email', locale: 'locale');

  group('Save user', () {
    test('Success', () async {
      // Given
      when(
        () => userRemoteDatasource.saveUser(userRemoteEntity),
      ).thenAnswer((_) async {});

      // When
      final result = await userRepositoryImpl.saveUser(userEntity);

      // Then
      expect(result, isA<Success>());
      verify(() => userRemoteDatasource.saveUser(userRemoteEntity)).called(1);
    });

    test('Failure', () async {
      // Given
      when(
        () => userRemoteDatasource.saveUser(userRemoteEntity),
      ).thenThrow(Exception());

      // When
      final result = await userRepositoryImpl.saveUser(userEntity);

      // Then
      expect(result, isA<Failure>());
      verify(() => userRemoteDatasource.saveUser(userRemoteEntity)).called(1);
    });
  });

  group('Get user', () {
    test('Success', () async {
      // Given
      when(
        () => userRemoteDatasource.getUser('uid'),
      ).thenAnswer((_) async => userRemoteEntity);

      // When
      final result = await userRepositoryImpl.getUser('uid');

      // Then
      expect((result as Success).data, userEntity);
      verify(() => userRemoteDatasource.getUser('uid')).called(1);
    });

    test('Failure', () async {
      // Given
      when(() => userRemoteDatasource.getUser('uid')).thenThrow(Exception());

      // When
      final result = await userRepositoryImpl.getUser('uid');

      // Then
      expect(result, isA<Failure>());
      verify(() => userRemoteDatasource.getUser('uid')).called(1);
    });
  });

  group('Delete user', () {
    test('Success', () async {
      // Given
      when(
        () => userRemoteDatasource.deleteUser('uid'),
      ).thenAnswer((_) async {});

      // When
      final result = await userRepositoryImpl.deleteUser('uid');

      // Then
      expect(result, isA<Success>());
      verify(() => userRemoteDatasource.deleteUser('uid')).called(1);
    });

    test('Failure', () async {
      // Given
      when(() => userRemoteDatasource.deleteUser('uid')).thenThrow(Exception());

      // When
      final result = await userRepositoryImpl.deleteUser('uid');

      // Then
      expect(result, isA<Failure>());
      verify(() => userRemoteDatasource.deleteUser('uid')).called(1);
    });
  });
}
