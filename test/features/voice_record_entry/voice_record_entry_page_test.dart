import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:voice_diary/features/home/home_page.dart';
import 'package:voice_diary/features/home/records/cubit/records_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/cubit/voice_record_entry_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/cubit/save_record_entry_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/models/save_record_entry_view_model.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/save_record_entry_page.dart';
import 'package:voice_diary/features/voice_record_entry/voice_record_entry_page.dart';
import 'package:voice_diary/features/voice_record_entry/widget/voice_record_entry_buttons.dart';
import 'package:voice_diary/features/voice_record_entry/widget/voice_record_entry_stopped_buttons.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/l10n/app_localizations_en.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/routing/routes.dart';
import 'package:voice_diary/widgets/primary_circular_icon_button.dart';

class MockVoiceRecordEntryCubit extends MockCubit<VoiceRecordEntryState>
    implements VoiceRecordEntryCubit {}

class MockSaveRecordEntryCubit extends MockCubit<SaveRecordEntryState>
    implements SaveRecordEntryCubit {}

class MockBottomBarCubit extends MockCubit<BottomBarState>
    implements BottomBarCubit {}

class MockRecordsCubit extends MockCubit<RecordsState>
    implements RecordsCubit {}

void main() {
  late MockVoiceRecordEntryCubit voiceRecordEntryCubit;
  late MockSaveRecordEntryCubit saveRecordEntryCubit;
  late MockBottomBarCubit bottomBarCubit;
  late MockRecordsCubit recordsCubit;

  setUpAll(() {
    voiceRecordEntryCubit = MockVoiceRecordEntryCubit();
    saveRecordEntryCubit = MockSaveRecordEntryCubit();
    bottomBarCubit = MockBottomBarCubit();
    recordsCubit = MockRecordsCubit();

    getIt.registerLazySingleton<VoiceRecordEntryCubit>(
        () => voiceRecordEntryCubit);
    getIt.registerLazySingleton<SaveRecordEntryCubit>(
        () => saveRecordEntryCubit);
    getIt.registerLazySingleton<BottomBarCubit>(() => bottomBarCubit);
    getIt.registerLazySingleton<RecordsCubit>(() => recordsCubit);
  });

  group('Initial state', () {
    testWidgets('show record button and helper text on ready state',
        (WidgetTester tester) async {
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.ready,
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: VoiceRecordEntryPage(),
          ),
        ),
      );

      expect(
        find.byType(PrimaryCircularIconButton),
        findsOneWidget,
      );
      expect(
        find.byIcon(PhosphorIcons.microphone()),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizationsEn().tap_to_begin_your_voice_recor_entry),
        findsOneWidget,
      );
    });
  });

  group('Recording', () {
    testWidgets('Set recording state on tap recording button',
        (WidgetTester tester) async {
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.ready,
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});
      when(() => voiceRecordEntryCubit.startRecording())
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: VoiceRecordEntryPage(),
          ),
        ),
      );

      await tester.tap(find.byType(PrimaryCircularIconButton));
      verify(() => voiceRecordEntryCubit.startRecording()).called(1);
    });

    testWidgets('Show record test, play and pause buttons',
        (WidgetTester tester) async {
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.recording,
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: VoiceRecordEntryPage(),
          ),
        ),
      );

      expect(
        find.byType(VoiceRecordEntryButtons),
        findsOneWidget,
      );

      expect(
        find.byIcon(PhosphorIcons.microphone()),
        findsOneWidget,
      );

      expect(
        find.byIcon(PhosphorIcons.pause()),
        findsOneWidget,
      );

      expect(
        find.byIcon(PhosphorIcons.stop()),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizationsEn().recording_dots),
        findsOneWidget,
      );
    });

    testWidgets('Set resume state on tap pause button',
        (WidgetTester tester) async {
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.paused,
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});
      when(() => voiceRecordEntryCubit.resumeRecording())
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: VoiceRecordEntryPage(),
          ),
        ),
      );

      await tester.tap(
        find.byIcon(
          PhosphorIcons.play(),
        ),
      );

      verify(() => voiceRecordEntryCubit.resumeRecording()).called(1);
    });
  });

  group('Paused', () {
    testWidgets('Set pause state on tap pause button',
        (WidgetTester tester) async {
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.recording,
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});
      when(() => voiceRecordEntryCubit.pauseRecording())
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: VoiceRecordEntryPage(),
          ),
        ),
      );

      await tester.tap(
        find.byIcon(
          PhosphorIcons.pause(),
        ),
      );

      verify(() => voiceRecordEntryCubit.pauseRecording()).called(1);
    });
  });

  group('Stopped', () {
    testWidgets('Set stop state on tap stop button',
        (WidgetTester tester) async {
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.paused,
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});
      when(() => voiceRecordEntryCubit.stopRecording())
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: VoiceRecordEntryPage(),
          ),
        ),
      );

      await tester.tap(
        find.byIcon(
          PhosphorIcons.stop(),
        ),
      );

      verify(() => voiceRecordEntryCubit.stopRecording()).called(1);
    });

    testWidgets('Check screen on stopped state', (WidgetTester tester) async {
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.stopped,
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: VoiceRecordEntryPage(),
          ),
        ),
      );

      expect(
        find.byType(VoiceRecordEntryStoppedButtons),
        findsOneWidget,
      );

      expect(
        find.byIcon(PhosphorIcons.microphone()),
        findsOneWidget,
      );

      expect(
        find.byIcon(PhosphorIcons.check()),
        findsOneWidget,
      );

      expect(
        find.byIcon(PhosphorIcons.trash()),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizationsEn().did_you_want_to_save_this_recording),
        findsOneWidget,
      );
    });

    testWidgets('Check dialog on tap delete button',
        (WidgetTester tester) async {
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.stopped,
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: VoiceRecordEntryPage(),
          ),
        ),
      );

      await tester.runAsync(() async {
        await tester.tap(
          find.byIcon(
            PhosphorIcons.trash(),
          ),
        );
      });
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().are_you_sure),
        findsOneWidget,
      );

      expect(
        find.text(AppLocalizationsEn().this_action_cannot_be_undone),
        findsOneWidget,
      );
    });

    testWidgets('Dismiss dialog on tap cancel button',
        (WidgetTester tester) async {
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.stopped,
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.voiceRecordEntry,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(VoiceRecordEntryPage), findsOneWidget);

      await tester.runAsync(() async {
        await tester.tap(
          find.byIcon(
            PhosphorIcons.trash(),
          ),
        );
      });
      await tester.pumpAndSettle();

      await tester.runAsync(() async {
        await tester.tap(
          find.text(
            AppLocalizationsEn().cancel,
          ),
        );
      });
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().are_you_sure),
        findsNothing,
      );

      expect(
        find.text(AppLocalizationsEn().this_action_cannot_be_undone),
        findsNothing,
      );
    });

    testWidgets('Dismiss dialog and goes to home page on tap delete button',
        (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(
        BottomBarState(),
      );
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.stopped,
        ),
      );
      when(() => recordsCubit.state).thenReturn(
        RecordsState(),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});
      when(() => voiceRecordEntryCubit.deleteRecording())
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);

      await tester.runAsync(() async {
        await tester.tap(
          find.byIcon(
            PhosphorIcons.microphone(),
          ),
        );
      });
      await tester.pumpAndSettle();

      expect(find.byType(VoiceRecordEntryPage), findsOneWidget);

      expect(
        find.byIcon(PhosphorIcons.trash()),
        findsOneWidget,
      );

      await tester.runAsync(() async {
        await tester.tap(
          find.byIcon(
            PhosphorIcons.trash(),
          ),
        );
      });
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().are_you_sure),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizationsEn().delete),
        findsOneWidget,
      );

      await tester.runAsync(() async {
        await tester.tap(
          find.text(
            AppLocalizationsEn().delete,
          ),
        );
      });
      await tester.pump();

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('Go to save record entry page on tap save button',
        (WidgetTester tester) async {
      final today = DateTime.now();
      final saveRecordEntryViewModel = SaveRecordEntryViewModel(
        title: '',
        date: today,
        path: '',
        tags: [],
      );
      when(() => voiceRecordEntryCubit.state).thenReturn(
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.stopped,
          date: today,
          path: '',
        ),
      );
      when(() => voiceRecordEntryCubit.init()).thenAnswer((_) async {});
      when(() => voiceRecordEntryCubit.deleteRecording())
          .thenAnswer((_) async {});
      when(
        () => saveRecordEntryCubit.init(
          saveRecordEntryViewModel,
        ),
      ).thenAnswer((_) async {});

      when(
        () => saveRecordEntryCubit.state,
      ).thenReturn(
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.initial,
          viewModel: saveRecordEntryViewModel,
        ),
      );

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('es'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.voiceRecordEntry,
            routes: Routes.list,
          ),
        ),
      );

      expect(find.byType(VoiceRecordEntryPage), findsOneWidget);

      await tester.runAsync(() async {
        await tester.tap(
          find.byIcon(
            PhosphorIcons.check(),
          ),
        );
      });
      await tester.pumpAndSettle();

      expect(find.byType(SaveRecordEntryPage), findsOneWidget);
    });
  });
}
