import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/user/models/user_entity.dart';
import 'package:domain/repositories/user_preferences/models/save_user_preferences_entity.dart';
import 'package:firebase_login/firebase_login_service.dart';
import 'package:firebase_login/models/firebase_auth_errors.dart';
import 'package:firebase_login/models/firebase_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result/result.dart';
import 'package:voice_diary/features/register/cubit/register_cubit.dart';

class FirebaseLoginServiceMock extends Mock implements FirebaseLoginService {}

class SaveUserMock extends Mock implements SaveUser {}

class SaveUserPreferencesMock extends Mock implements SaveUserPreferences {}

void main() {
  late FirebaseLoginServiceMock firebaseLoginService;
  late SaveUserMock saveUser;
  late SaveUserPreferencesMock saveUserPreferences;
  late RegisterCubit cubit;

  setUp(() {
    firebaseLoginService = FirebaseLoginServiceMock();
    saveUser = SaveUserMock();
    saveUserPreferences = SaveUserPreferencesMock();
    cubit = RegisterCubit(
      firebaseLoginService: firebaseLoginService,
      saveUser: saveUser,
      saveUserPreferences: saveUserPreferences,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('Register', () {
    final firebaseUser = FirebaseUser(
      uid: 'uid',
      email: 'email',
    );
    final userEntity = UserEntity(
      uid: 'uid',
      email: 'email',
      locale: Platform.localeName,
    );
    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, success] when register is success.',
      build: () => cubit,
      act: (bloc) => cubit.register(
        email: 'email@gmail.com',
        password: '#Va1idP4SSW0rD',
        repeatPassword: '#Va1idP4SSW0rD',
      ),
      setUp: () {
        when(() => firebaseLoginService.createUserWithEmailAndPassword(
                email: 'email@gmail.com', password: '#Va1idP4SSW0rD'))
            .thenAnswer((_) async => Result.success(firebaseUser));
        when(() => saveUser(userEntity))
            .thenAnswer((_) async => Result.success(null));
        when(() => saveUserPreferences(
              SaveUserPreferencesEntity(
                selectedLocale: Platform.localeName,
              ),
            )).thenAnswer((_) async => Result.success(null));
      },
      expect: () => const <RegisterState>[
        RegisterState(
          status: RegisterStatus.loading,
        ),
        RegisterState(
          status: RegisterStatus.success,
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, emailNotValid] when email is not valid.',
      build: () => cubit,
      act: (bloc) => cubit.register(
        email: 'email',
        password: '#Va1idP4SSW0rD',
        repeatPassword: '#Va1idP4SSW0rD',
      ),
      expect: () => const <RegisterState>[
        RegisterState(
          status: RegisterStatus.initial,
          errors: [RegisterError.emailNotValid],
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, passwordMustBeStronger] when password is weak.',
      build: () => cubit,
      act: (bloc) => cubit.register(
        email: 'email@gmail.com',
        password: 'test',
        repeatPassword: 'test',
      ),
      expect: () => const <RegisterState>[
        RegisterState(
          status: RegisterStatus.initial,
          errors: [RegisterError.passwordMustBeStronger],
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, passwordNotMatch] when password is different from repeatPassword.',
      build: () => cubit,
      act: (bloc) => cubit.register(
        email: 'email@gmail.com',
        password: '#Va1idP4SSW0rD',
        repeatPassword: 'test',
      ),
      expect: () => const <RegisterState>[
        RegisterState(
          status: RegisterStatus.initial,
          errors: [RegisterError.passwordNotMatch],
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, emailAlreadyInUse] when email is already in use.',
      build: () => cubit,
      act: (bloc) => cubit.register(
        email: 'email@gmail.com',
        password: '#Va1idP4SSW0rD',
        repeatPassword: '#Va1idP4SSW0rD',
      ),
      setUp: () {
        when(() =>
            firebaseLoginService.createUserWithEmailAndPassword(
                email: 'email@gmail.com',
                password: '#Va1idP4SSW0rD')).thenAnswer(
            (_) async => Result.failure(FirebaseAuthErrors.emailAlreadyInUse));
      },
      expect: () => const <RegisterState>[
        RegisterState(
          status: RegisterStatus.loading,
        ),
        RegisterState(
          status: RegisterStatus.initial,
          errors: [RegisterError.emailAlreadyInUse],
        ),
      ],
    );
  });
}
