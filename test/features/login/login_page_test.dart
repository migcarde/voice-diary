import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';
import 'package:voice_diary/features/login/login_mobile_layout.dart';
import 'package:voice_diary/features/register/cubit/register_cubit.dart';
import 'package:voice_diary/features/register/register_page.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/l10n/app_localizations_en.dart';
import 'package:voice_diary/routing/app_router.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_link.dart';
import 'package:voice_diary/widgets/primary_loading_button.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class MockRegisterCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

void main() {
  group('Login', () {
    testWidgets('show loading button when login cubit state is loading',
        (WidgetTester tester) async {
      final loginCubit = MockLoginCubit();
      when(() => loginCubit.state).thenReturn(
        LoginState(
          status: LoginStatus.loading,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<LoginCubit>(
              create: (context) => loginCubit,
              child: LoginMobileLayout(),
            ),
          ),
        ),
      );
      await tester.pump(
        const Duration(
          seconds: 1,
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'show error message when login state has invalid credentials error',
        (WidgetTester tester) async {
      final loginCubit = MockLoginCubit();
      when(() => loginCubit.state).thenReturn(
        LoginState(
          status: LoginStatus.disconnected,
          error: LoginError.invalidCredentials,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<LoginCubit>(
              create: (context) => loginCubit,
              child: LoginMobileLayout(),
            ),
          ),
        ),
      );
      await tester.pump(
        const Duration(
          seconds: 1,
        ),
      );

      expect(
        find.text(AppLocalizationsEn().invalid_credentials_please_try_again),
        findsOneWidget,
      );
    });

    testWidgets('show error message when login state has unknown error',
        (WidgetTester tester) async {
      final loginCubit = MockLoginCubit();
      when(() => loginCubit.state).thenReturn(
        LoginState(
          status: LoginStatus.disconnected,
          error: LoginError.unknown,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<LoginCubit>(
              create: (context) => loginCubit,
              child: LoginMobileLayout(),
            ),
          ),
        ),
      );
      await tester.pump(
        const Duration(
          seconds: 1,
        ),
      );

      expect(
        find.text(
            AppLocalizationsEn().sorry_we_have_problems_please_try_again_later),
        findsOneWidget,
      );
    });

    testWidgets('login success', (WidgetTester tester) async {
      final loginCubit = MockLoginCubit();
      when(() => loginCubit.state).thenReturn(
        LoginState(
          status: LoginStatus.connected,
        ),
      );
      when(
        () => loginCubit.login(
          email: 'email@gmail.com',
          password: 'password',
        ),
      ).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<LoginCubit>(
              create: (context) => loginCubit,
              child: LoginMobileLayout(),
            ),
          ),
        ),
      );
      await tester.enterText(
          find.widgetWithText(BaseTextField, 'Email'), 'email@gmail.com');
      await tester.enterText(
          find.widgetWithText(BaseTextField, 'Password'), 'password');
      await tester.tap(find.byType(PrimaryLoadingButton));
      verify(() =>
              loginCubit.login(email: 'email@gmail.com', password: 'password'))
          .called(1);
    });
  });

  group('Navigation', () {
    late MockLoginCubit loginCubit;
    late MockRegisterCubit registerCubit;
    late MockAppCubit appCubit;

    setUp(() {
      loginCubit = MockLoginCubit();
      registerCubit = MockRegisterCubit();
      appCubit = MockAppCubit();
      getIt.registerFactory<LoginCubit>(
        () => loginCubit,
      );
      getIt.registerFactory<RegisterCubit>(
        () => registerCubit,
      );
      getIt.registerLazySingleton<AppCubit>(
        () => appCubit,
      );
    });
    testWidgets('to register page on tap are you not registered button',
        (WidgetTester tester) async {
      when(() => loginCubit.state).thenReturn(
        LoginState(
          status: LoginStatus.connected,
        ),
      );
      when(() => registerCubit.state).thenReturn(
        RegisterState(),
      );
      when(() => appCubit.state).thenReturn(
        AppState(
          status: AppStatus.disconnected,
        ),
      );

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => getIt<AppCubit>(),
          child: MaterialApp.router(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
            theme: AppTheme.mainTheme(),
            routerConfig: AppRouter.router,
          ),
        ),
      );
      await tester.tap(find.byType(PrimaryLink));
      await tester.pumpAndSettle();
      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}
