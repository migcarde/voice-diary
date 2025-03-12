import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/register/cubit/register_cubit.dart';
import 'package:voice_diary/features/register/register_mobile_layout.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/l10n/app_localizations_en.dart';

class RegisterCubitMock extends MockCubit<RegisterState>
    implements RegisterCubit {}

void main() {
  group('Register', () {
    testWidgets('show loading button when register cubit state is loading',
        (WidgetTester tester) async {
      final registerCubit = RegisterCubitMock();
      when(() => registerCubit.state).thenReturn(
        RegisterState(
          status: RegisterStatus.loading,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<RegisterCubit>(
              create: (context) => registerCubit,
              child: RegisterMobileLayout(),
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

    testWidgets('show email already in use error message',
        (WidgetTester tester) async {
      final registerCubit = RegisterCubitMock();
      when(() => registerCubit.state).thenReturn(
        RegisterState(
          status: RegisterStatus.initial,
          errors: [RegisterError.emailAlreadyInUse],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<RegisterCubit>(
              create: (context) => registerCubit,
              child: RegisterMobileLayout(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn()
            .user_already_registered_please_use_another_email),
        findsOneWidget,
      );
    });

    testWidgets('show email not valid error message',
        (WidgetTester tester) async {
      final registerCubit = RegisterCubitMock();
      when(() => registerCubit.state).thenReturn(
        RegisterState(
          status: RegisterStatus.initial,
          errors: [RegisterError.emailNotValid],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<RegisterCubit>(
              create: (context) => registerCubit,
              child: RegisterMobileLayout(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().email_not_valid),
        findsOneWidget,
      );
    });

    testWidgets('show password must be stronger error message',
        (WidgetTester tester) async {
      final registerCubit = RegisterCubitMock();
      when(() => registerCubit.state).thenReturn(
        RegisterState(
          status: RegisterStatus.initial,
          errors: [RegisterError.passwordMustBeStronger],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<RegisterCubit>(
              create: (context) => registerCubit,
              child: RegisterMobileLayout(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().passwords_is_weak),
        findsOneWidget,
      );
    });

    testWidgets('show password not matching error message',
        (WidgetTester tester) async {
      final registerCubit = RegisterCubitMock();
      when(() => registerCubit.state).thenReturn(
        RegisterState(
          status: RegisterStatus.initial,
          errors: [RegisterError.passwordNotMatch],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<RegisterCubit>(
              create: (context) => registerCubit,
              child: RegisterMobileLayout(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().password_does_not_match),
        findsOneWidget,
      );
    });

    testWidgets('show unknown error message', (WidgetTester tester) async {
      final registerCubit = RegisterCubitMock();
      when(() => registerCubit.state).thenReturn(
        RegisterState(),
      );
      whenListen(
        registerCubit,
        Stream.fromIterable(
          <RegisterState>[
            RegisterState(
              status: RegisterStatus.loading,
            ),
            RegisterState(
              status: RegisterStatus.error,
              errors: [RegisterError.unknown],
            ),
          ],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<RegisterCubit>(
              create: (context) => registerCubit,
              child: RegisterMobileLayout(),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(
        find.text(
          AppLocalizationsEn().sorry_we_have_problems_please_try_again_later,
        ),
        findsOneWidget,
      );
    });
  });
}
