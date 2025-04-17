import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/bottom_bar/bottom_bar.dart';
import 'package:voice_diary/features/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:voice_diary/features/home/home_page.dart';
import 'package:voice_diary/features/home/records/cubit/records_cubit.dart';
import 'package:voice_diary/features/home/records/records_page.dart';
import 'package:voice_diary/features/home/settings/cubit/settings_cubit.dart';
import 'package:voice_diary/features/home/settings/reauthentication/cubit/reauthentication_cubit.dart';
import 'package:voice_diary/features/home/settings/settings_page.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/cubit/voice_record_entry_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/voice_record_entry_page.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/l10n/app_localizations_en.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/routing/routes.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_loading_button.dart';

class MockBottomBarCubit extends MockCubit<BottomBarState>
    implements BottomBarCubit {}

class MockRecordsCubit extends MockCubit<RecordsState>
    implements RecordsCubit {}

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

class MockVoiceRecordEntryCubit extends MockCubit<VoiceRecordEntryState>
    implements VoiceRecordEntryCubit {}

class MockReauthenticationCubit extends MockCubit<ReauthenticationState>
    implements ReauthenticationCubit {}

void main() {
  late MockBottomBarCubit bottomBarCubit;
  late MockRecordsCubit recordsCubit;
  late MockSettingsCubit settingsCubit;
  late MockVoiceRecordEntryCubit voiceRecordEntryCubit;
  late MockReauthenticationCubit reauthenticationCubit;

  setUpAll(() {
    bottomBarCubit = MockBottomBarCubit();
    recordsCubit = MockRecordsCubit();
    settingsCubit = MockSettingsCubit();
    voiceRecordEntryCubit = MockVoiceRecordEntryCubit();
    reauthenticationCubit = MockReauthenticationCubit();
    getIt.registerFactory<BottomBarCubit>(() => bottomBarCubit);
    getIt.registerFactory<RecordsCubit>(() => recordsCubit);
    getIt.registerFactory<SettingsCubit>(() => settingsCubit);
    getIt.registerFactory<VoiceRecordEntryCubit>(() => voiceRecordEntryCubit);
    getIt.registerFactory<ReauthenticationCubit>(() => reauthenticationCubit);
  });

  tearDownAll(() {
    getIt.unregister<BottomBarCubit>();
  });

  group('Records section', () {
    testWidgets('show record section page', (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(
          selectedTab: BottomBarTabs.records,
        ),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RecordsPage), findsOneWidget);
    });

    testWidgets('goes to voice record entry page', (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(
          selectedTab: BottomBarTabs.records,
        ),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(),
      );
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(
          selectedTab: BottomBarTabs.records,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RecordsPage), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.microphone(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(VoiceRecordEntryPage), findsOneWidget);
    });

    testWidgets('show settings section page', (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(
          selectedTab: BottomBarTabs.records,
        ),
      );
      whenListen(
        bottomBarCubit,
        Stream.fromIterable(
          [
            BottomBarState(
              selectedTab: BottomBarTabs.records,
            ),
            BottomBarState(
              selectedTab: BottomBarTabs.settings,
            ),
          ],
        ),
      );
      when(() => settingsCubit.state).thenReturn(
        SettingsState(),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(
          status: RecordsStatus.empty,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RecordsPage), findsOneWidget);
      expect(find.byType(BottomBar), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.gear(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });
  });

  group('Settings section', () {
    // TODO: Add test for navigation to change language page
    testWidgets('show remove account dialog', (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(
          selectedTab: BottomBarTabs.records,
        ),
      );
      whenListen(
        bottomBarCubit,
        Stream.fromIterable(
          [
            BottomBarState(
              selectedTab: BottomBarTabs.records,
            ),
            BottomBarState(
              selectedTab: BottomBarTabs.settings,
            ),
          ],
        ),
      );
      when(() => settingsCubit.state).thenReturn(
        SettingsState(),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(
          status: RecordsStatus.empty,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RecordsPage), findsOneWidget);
      expect(find.byType(BottomBar), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.gear(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().delete_account,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().are_you_sure),
        findsOneWidget,
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().cancel,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().are_you_sure),
        findsNothing,
      );
    });

    testWidgets('show remove account form', (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(
          selectedTab: BottomBarTabs.records,
        ),
      );
      whenListen(
        bottomBarCubit,
        Stream.fromIterable(
          [
            BottomBarState(
              selectedTab: BottomBarTabs.records,
            ),
            BottomBarState(
              selectedTab: BottomBarTabs.settings,
            ),
          ],
        ),
      );
      when(() => settingsCubit.state).thenReturn(
        SettingsState(),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(
          status: RecordsStatus.empty,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});
      when(() => reauthenticationCubit.state).thenReturn(
        ReauthenticationState(),
      );

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RecordsPage), findsOneWidget);
      expect(find.byType(BottomBar), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.gear(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().delete_account,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().are_you_sure),
        findsOneWidget,
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().delete,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().email),
        findsOneWidget,
      );
    });

    testWidgets('reauthentication call', (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(
          selectedTab: BottomBarTabs.records,
        ),
      );
      whenListen(
        bottomBarCubit,
        Stream.fromIterable(
          [
            BottomBarState(
              selectedTab: BottomBarTabs.records,
            ),
            BottomBarState(
              selectedTab: BottomBarTabs.settings,
            ),
          ],
        ),
      );
      when(() => settingsCubit.state).thenReturn(
        SettingsState(),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(
          status: RecordsStatus.empty,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});
      when(() => reauthenticationCubit.state).thenReturn(
        ReauthenticationState(),
      );
      when(() => reauthenticationCubit.reauthenticate(
          email: 'email@gmail.com',
          password: 'password')).thenAnswer((_) async {});
      whenListen(
        reauthenticationCubit,
        Stream.fromIterable(
          [
            ReauthenticationState(),
            ReauthenticationState(
              status: ReauthenticationStatus.loading,
            ),
          ],
        ),
      );
      when(() => settingsCubit.removeUser()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RecordsPage), findsOneWidget);
      expect(find.byType(BottomBar), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.gear(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().delete_account,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().are_you_sure),
        findsOneWidget,
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().delete,
          ),
        ),
      );
      await tester.pump();

      final emailInput =
          find.widgetWithText(BaseTextField, AppLocalizationsEn().email);
      final passwordInput =
          find.widgetWithText(BaseTextField, AppLocalizationsEn().password);
      final loadingButton = find.byType(PrimaryLoadingButton);

      await tester.enterText(emailInput, 'email@gmail.com');
      await tester.enterText(passwordInput, 'password');

      await tester.runAsync(
        () async => await tester.tap(
          loadingButton,
        ),
      );
      await tester.pump();

      expect(
        find.byType(
          CircularProgressIndicator,
        ),
        findsOneWidget,
      );
      verify(() => reauthenticationCubit.reauthenticate(
          email: 'email@gmail.com', password: 'password')).called(1);
    });

    testWidgets('email not valid', (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(
          selectedTab: BottomBarTabs.records,
        ),
      );
      whenListen(
        bottomBarCubit,
        Stream.fromIterable(
          [
            BottomBarState(
              selectedTab: BottomBarTabs.records,
            ),
            BottomBarState(
              selectedTab: BottomBarTabs.settings,
            ),
          ],
        ),
      );
      when(() => settingsCubit.state).thenReturn(
        SettingsState(),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(
          status: RecordsStatus.empty,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});
      when(() => reauthenticationCubit.state).thenReturn(
        ReauthenticationState(),
      );
      when(() => reauthenticationCubit.reauthenticate(
          email: 'email@gmail.com',
          password: 'password')).thenAnswer((_) async {});
      whenListen(
        reauthenticationCubit,
        Stream.fromIterable(
          [
            ReauthenticationState(),
            ReauthenticationState(
              emailNotValid: true,
            ),
          ],
        ),
      );
      when(() => settingsCubit.removeUser()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RecordsPage), findsOneWidget);
      expect(find.byType(BottomBar), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.gear(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().delete_account,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().are_you_sure),
        findsOneWidget,
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().delete,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().email_not_valid),
        findsOneWidget,
      );
    });

    testWidgets('invalid credentials', (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(
          selectedTab: BottomBarTabs.records,
        ),
      );
      whenListen(
        bottomBarCubit,
        Stream.fromIterable(
          [
            BottomBarState(
              selectedTab: BottomBarTabs.records,
            ),
            BottomBarState(
              selectedTab: BottomBarTabs.settings,
            ),
          ],
        ),
      );
      when(() => settingsCubit.state).thenReturn(
        SettingsState(),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(
          status: RecordsStatus.empty,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});
      when(() => reauthenticationCubit.state).thenReturn(
        ReauthenticationState(),
      );
      when(() => reauthenticationCubit.reauthenticate(
          email: 'email@gmail.com',
          password: 'password')).thenAnswer((_) async {});
      whenListen(
        reauthenticationCubit,
        Stream.fromIterable(
          [
            ReauthenticationState(),
            ReauthenticationState(
              error: LoginError.invalidCredentials,
            ),
          ],
        ),
      );
      when(() => settingsCubit.removeUser()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RecordsPage), findsOneWidget);
      expect(find.byType(BottomBar), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.gear(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().delete_account,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().are_you_sure),
        findsOneWidget,
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.text(
            AppLocalizationsEn().delete,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().invalid_credentials_please_try_again),
        findsOneWidget,
      );
    });
  });
}
