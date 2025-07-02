import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/home/settings/change_language/change_language_mobile_layout.dart';
import 'package:voice_diary/features/home/settings/change_language/cubit/change_language_cubit.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/l10n/app_localizations_en.dart';

class MockChangeLanguageCubit extends MockCubit<ChangeLanguageState>
    implements ChangeLanguageCubit {}

void main() {
  group('Change language', () {
    testWidgets('show loading button when change language cubit is loading',
        (WidgetTester tester) async {
      final changeLanguageCubit = MockChangeLanguageCubit();
      when(() => changeLanguageCubit.state).thenReturn(
        ChangeLanguageState(
          status: ChangeLanguageStatus.loading,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<ChangeLanguageCubit>(
              create: (context) => changeLanguageCubit,
              child: ChangeLanguageMobileLayout(),
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

    testWidgets('call changeLanguage on tap radio button',
        (WidgetTester tester) async {
      final changeLanguageCubit = MockChangeLanguageCubit();
      when(() => changeLanguageCubit.state).thenReturn(
        ChangeLanguageState(
          status: ChangeLanguageStatus.loading,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<ChangeLanguageCubit>(
              create: (context) => changeLanguageCubit,
              child: ChangeLanguageMobileLayout(),
            ),
          ),
        ),
      );

      await tester.tap(
        find.text(
          AppLocalizationsEn().spanish,
        ),
      );
      await tester.pump();

      verify(() => changeLanguageCubit.changeLanguage(Locale('es'))).called(1);
    });

    testWidgets('call saveLanguage on tap save button',
        (WidgetTester tester) async {
      final changeLanguageCubit = MockChangeLanguageCubit();
      when(() => changeLanguageCubit.state).thenReturn(
        ChangeLanguageState(
          selectedLocale: const Locale('en'),
        ),
      );
      when(() => changeLanguageCubit.saveLanguage()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<ChangeLanguageCubit>(
              create: (context) => changeLanguageCubit,
              child: ChangeLanguageMobileLayout(),
            ),
          ),
        ),
      );

      await tester.runAsync(
        () async => tester.tap(
          find.text(
            AppLocalizationsEn().save,
          ),
        ),
      );
      await tester.pumpAndSettle();

      verify(() => changeLanguageCubit.saveLanguage()).called(1);
    });

    testWidgets('show unknown error message', (WidgetTester tester) async {
      final changeLanguageCubit = MockChangeLanguageCubit();
      when(() => changeLanguageCubit.state).thenReturn(
        ChangeLanguageState(),
      );
      whenListen(
          changeLanguageCubit,
          Stream.fromIterable([
            ChangeLanguageState(
              status: ChangeLanguageStatus.loading,
            ),
            ChangeLanguageState(
              status: ChangeLanguageStatus.error,
            ),
          ]));

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<ChangeLanguageCubit>(
              create: (context) => changeLanguageCubit,
              child: ChangeLanguageMobileLayout(),
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
