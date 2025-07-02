import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_diary/features/app/app_page.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';
import 'package:voice_diary/features/app/models/user_view_model.dart';
import 'package:voice_diary/features/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:voice_diary/features/home/home_page.dart';
import 'package:voice_diary/features/home/records/cubit/records_cubit.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';
import 'package:voice_diary/features/login/login_page.dart';

class AppCubitMock extends MockCubit<AppState> implements AppCubit {}

class LoginCubitMock extends MockCubit<LoginState> implements LoginCubit {}

class BottomBarCubitMock extends MockCubit<BottomBarState>
    implements BottomBarCubit {}

class RecordsCubitMock extends MockCubit<RecordsState>
    implements RecordsCubit {}

void main() {
  group('User session', () {
    late AppCubitMock appCubit;
    late LoginCubitMock loginCubit;
    late BottomBarCubitMock bottomBarCubit;
    late RecordsCubitMock recordsCubit;

    setUpAll(() {
      appCubit = AppCubitMock();
      loginCubit = LoginCubitMock();
      bottomBarCubit = BottomBarCubitMock();
      recordsCubit = RecordsCubitMock();
      getIt.registerLazySingleton<AppCubit>(
        () => appCubit,
      );
      getIt.registerFactory<LoginCubit>(
        () => loginCubit,
      );
      getIt.registerFactory<BottomBarCubit>(
        () => bottomBarCubit,
      );
      getIt.registerFactory<RecordsCubit>(
        () => recordsCubit,
      );
    });
    testWidgets('navigates to home when user is connected',
        (WidgetTester tester) async {
      final userViewModel = UserViewModel(
        uid: 'uid',
        email: 'email@gmail.com',
      );

      when(() => appCubit.state).thenReturn(
        AppState(
          status: AppStatus.connected,
          user: userViewModel,
        ),
      );
      when(() => appCubit.init()).thenAnswer((_) async {});
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        AppPage(),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
    testWidgets('navigates to login when user is disconnected',
        (WidgetTester tester) async {
      when(() => appCubit.state).thenReturn(
        AppState(),
      );
      when(() => appCubit.init()).thenAnswer((_) async {});

      when(() => loginCubit.state).thenReturn(LoginState());

      await tester.pumpWidget(
        AppPage(),
      );
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
