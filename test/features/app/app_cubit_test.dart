import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:firebase_login/firebase_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';
import 'package:voice_diary/features/app/models/user_view_model.dart';

class FirebaseLoginServiceMock extends Mock implements FirebaseLoginService {}

class UserMock extends Mock implements User {}

void main() {
  late FirebaseLoginServiceMock firebaseLoginService;
  late UserMock user;
  late AppCubit cubit;

  setUp(() {
    firebaseLoginService = FirebaseLoginServiceMock();
    user = UserMock();
    cubit = AppCubit(
      firebaseLoginService: firebaseLoginService,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('init', () {
    blocTest<AppCubit, AppState>(
      'emits [disconnected] when init does not have any user logged.',
      build: () => cubit,
      act: (bloc) => cubit.init(),
      setUp: () {
        when(() => firebaseLoginService.listenChanges())
            .thenAnswer((_) => Stream.empty());
      },
      expect: () => const <AppState>[],
    );

    blocTest<AppCubit, AppState>(
      'emits [connect] when init has a user logged.',
      build: () => cubit,
      act: (bloc) => cubit.init(),
      setUp: () {
        when(() => firebaseLoginService.listenChanges())
            .thenAnswer((_) => Stream.value(user));
        when(() => user.uid).thenAnswer((_) => 'uid');
        when(() => user.email).thenAnswer((_) => 'email@gmail.com');
      },
      expect: () => const <AppState>[
        AppState(
          status: AppStatus.connected,
          user: UserViewModel(
            uid: 'uid',
            email: 'email@gmail.com',
          ),
        ),
      ],
    );

    blocTest<AppCubit, AppState>(
      'emits [disconnected] when user logout',
      build: () => cubit,
      act: (bloc) => cubit.init(),
      setUp: () {
        when(() => firebaseLoginService.listenChanges()).thenAnswer(
          (_) => Stream.fromIterable(
            [user, null],
          ),
        );
        when(() => user.uid).thenAnswer((_) => 'uid');
        when(() => user.email).thenAnswer((_) => 'email@gmail.com');
      },
      expect: () => const <AppState>[
        AppState(
          status: AppStatus.connected,
          user: UserViewModel(
            uid: 'uid',
            email: 'email@gmail.com',
          ),
        ),
        AppState(
          status: AppStatus.disconnected,
          user: null,
        ),
      ],
    );
  });
}
