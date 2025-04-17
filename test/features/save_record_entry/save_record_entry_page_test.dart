import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/cubit/save_record_entry_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/models/save_record_entry_view_model.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/save_record_entry_page.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/l10n/app_localizations_en.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_chip.dart';
import 'package:voice_diary/widgets/primary_loading_button.dart';

class MockSaveRecordEntryCubit extends MockCubit<SaveRecordEntryState>
    implements SaveRecordEntryCubit {}

void main() {
  late MockSaveRecordEntryCubit saveRecordEntryCubit;

  setUpAll(() {
    saveRecordEntryCubit = MockSaveRecordEntryCubit();

    getIt.registerLazySingleton<SaveRecordEntryCubit>(
      () => saveRecordEntryCubit,
    );
  });

  final today = DateTime.now();
  final viewModel = SaveRecordEntryViewModel(
    title: 'Title',
    date: today,
    path: 'Path',
    tags: [],
    transcription: 'Transcription',
  );

  group('Initial state', () {
    testWidgets('check widgets from initial state',
        (WidgetTester tester) async {
      when(() => saveRecordEntryCubit.init(viewModel)).thenAnswer((_) {});
      when(() => saveRecordEntryCubit.state).thenReturn(
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.initial,
          viewModel: viewModel,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: SaveRecordEntryPage(
              viewModel: viewModel,
            ),
          ),
        ),
      );

      expect(find.text(AppLocalizationsEn().title), findsOneWidget);
      expect(find.text(AppLocalizationsEn().tags), findsOneWidget);
      expect(
          find.text(
              AppLocalizationsEn().base_on_your_record_we_recommend_these_tags),
          findsOneWidget);
      expect(find.text(AppLocalizationsEn().save), findsOneWidget);
    });

    testWidgets('change title textfield', (WidgetTester tester) async {
      when(() => saveRecordEntryCubit.init(viewModel)).thenAnswer((_) {});
      when(() => saveRecordEntryCubit.state).thenReturn(
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.initial,
          viewModel: viewModel,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: SaveRecordEntryPage(
              viewModel: viewModel,
            ),
          ),
        ),
      );
      await tester.enterText(
        find.widgetWithText(BaseTextField, AppLocalizationsEn().title),
        'Example',
      );

      expect(find.text('Example'), findsOneWidget);
      expect(find.text(AppLocalizationsEn().tags), findsOneWidget);
      expect(
          find.text(
              AppLocalizationsEn().base_on_your_record_we_recommend_these_tags),
          findsOneWidget);
      expect(find.text(AppLocalizationsEn().save), findsOneWidget);
    });

    testWidgets('add tag', (WidgetTester tester) async {
      when(() => saveRecordEntryCubit.init(viewModel)).thenAnswer((_) {});
      when(() => saveRecordEntryCubit.state).thenReturn(
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.initial,
          viewModel: viewModel.copyWith(
            tags: [
              'Example',
            ],
          ),
        ),
      );
      when(() => saveRecordEntryCubit.addTag('Example')).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: SaveRecordEntryPage(
              viewModel: viewModel,
            ),
          ),
        ),
      );
      await tester.enterText(
        find.widgetWithText(BaseTextField, AppLocalizationsEn().tags),
        'Example',
      );
      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.plus(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.widgetWithText(PrimaryChip, 'Example'), findsOneWidget);
      expect(
        find.text(
          AppLocalizationsEn().base_on_your_record_we_recommend_these_tags,
        ),
        findsOneWidget,
      );
      expect(find.text(AppLocalizationsEn().save), findsOneWidget);
      verify(() => saveRecordEntryCubit.addTag('Example')).called(1);
    });

    testWidgets('remove tag', (WidgetTester tester) async {
      when(() => saveRecordEntryCubit.init(viewModel)).thenAnswer((_) {});
      when(() => saveRecordEntryCubit.state).thenReturn(
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.initial,
          viewModel: viewModel.copyWith(
            tags: [
              'Example',
            ],
          ),
        ),
      );
      when(() => saveRecordEntryCubit.removeTag('Example')).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: SaveRecordEntryPage(
              viewModel: viewModel,
            ),
          ),
        ),
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.x(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.widgetWithText(PrimaryChip, 'Example'), findsOneWidget);
      expect(
        find.text(
          AppLocalizationsEn().base_on_your_record_we_recommend_these_tags,
        ),
        findsOneWidget,
      );
      expect(find.text(AppLocalizationsEn().save), findsOneWidget);
      verify(() => saveRecordEntryCubit.removeTag('Example')).called(1);
    });
  });

  group('Loading state', () {
    testWidgets('Check loading button', (WidgetTester tester) async {
      when(() => saveRecordEntryCubit.state).thenReturn(
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.loading,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: SaveRecordEntryPage(
              viewModel: viewModel,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Save', () {
    testWidgets('Check save function on tap', (WidgetTester tester) async {
      when(() => saveRecordEntryCubit.state).thenReturn(
        SaveRecordEntryState(
          status: SaveRecordEntryStatus.initial,
        ),
      );
      when(() => saveRecordEntryCubit.save('Example')).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: SaveRecordEntryPage(
              viewModel: viewModel,
            ),
          ),
        ),
      );
      await tester.enterText(
        find.widgetWithText(BaseTextField, AppLocalizationsEn().title),
        'Example',
      );
      await tester.tap(find.byType(PrimaryLoadingButton));

      verify(
        () => saveRecordEntryCubit.save(
          'Example',
        ),
      );
    });
  });
}
