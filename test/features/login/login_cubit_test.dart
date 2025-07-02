import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:firebase_login/firebase_login_service.dart';
import 'package:firebase_login/models/firebase_auth_errors.dart';
import 'package:firebase_login/models/firebase_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';

class FirebaseLoginServiceMock extends Mock implements FirebaseLoginService {}

void main() {
  late FirebaseLoginServiceMock firebaseLoginService;
  late LoginCubit cubit;

  setUp(() {
    firebaseLoginService = FirebaseLoginServiceMock();
    cubit = LoginCubit(
      firebaseLoginService: firebaseLoginService,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('Login', () {
    const firebaseUser = FirebaseUser(
      uid: 'uid',
      email: 'email',
    );
    blocTest<LoginCubit, LoginState>(
      'emits [loading, connected] when login successfully.',
      build: () => cubit,
      act: (bloc) => cubit.login(
        email: 'email',
        password: 'password',
      ),
      setUp: () {
        when(() => firebaseLoginService.loginWithEmailAndPassword(
            email: 'email', password: 'password')).thenAnswer(
          (_) async => Result.success(firebaseUser),
        );
      },
      expect: () => const <LoginState>[
        LoginState(
          status: LoginStatus.loading,
        ),
        LoginState(
          status: LoginStatus.connected,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, error] when login fails with generic error.',
      build: () => cubit,
      act: (bloc) => cubit.login(
        email: 'email',
        password: 'password',
      ),
      setUp: () {
        when(() => firebaseLoginService.loginWithEmailAndPassword(
            email: 'email', password: 'password')).thenAnswer(
          (_) async => Result.failure(Exception()),
        );
      },
      expect: () => const <LoginState>[
        LoginState(
          status: LoginStatus.loading,
        ),
        LoginState(
          status: LoginStatus.disconnected,
          error: LoginError.unknown,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, error] when login fails with invalid password.',
      build: () => cubit,
      act: (bloc) => cubit.login(
        email: 'email',
        password: 'password',
      ),
      setUp: () {
        when(() => firebaseLoginService.loginWithEmailAndPassword(
            email: 'email', password: 'password')).thenAnswer(
          (_) async => Result.failure(FirebaseAuthErrors.invalidCredetentials),
        );
      },
      expect: () => const <LoginState>[
        LoginState(
          status: LoginStatus.loading,
        ),
        LoginState(
          status: LoginStatus.disconnected,
          error: LoginError.invalidCredentials,
        ),
      ],
    );
  });
}
