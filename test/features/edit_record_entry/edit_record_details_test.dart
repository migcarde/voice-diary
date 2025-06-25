import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/record_details/edit_record_details/cubit/edit_record_details_cubit.dart';
import 'package:voice_diary/features/record_details/edit_record_details/edit_record_details_page.dart';
import 'package:voice_diary/features/record_details/edit_record_details/models/edit_record_details_view_model.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_button.dart';
import 'package:voice_diary/widgets/primary_chip.dart';

class MockEditRecordDetailsCubit extends MockCubit<EditRecordDetailsState>
    implements EditRecordDetailsCubit {}

void main() {
  late MockEditRecordDetailsCubit editRecordDetailsCubit;

  final today = DateTime.now();
  final viewModel = EditRecordDetailsViewModel(
    title: 'Example title',
    date: today,
    duration: const Duration(seconds: 1),
    tags: const [],
    transcription: 'Example transcription',
    id: 1,
    path: 'Path',
  );

  Future<void> pumpEditRecordDetailsPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: const Locale('en'),
        theme: AppTheme.mainTheme(),
        home: Scaffold(
          body: EditRecordDetailsPage(
            editRecordDetailsViewModel: viewModel,
          ),
        ),
      ),
    );
  }

  setUp(() {
    editRecordDetailsCubit = MockEditRecordDetailsCubit();

    if (getIt.isRegistered<EditRecordDetailsCubit>()) {
      getIt.unregister<EditRecordDetailsCubit>();
    }
    getIt.registerLazySingleton<EditRecordDetailsCubit>(
      () => editRecordDetailsCubit,
    );

    when(() => editRecordDetailsCubit.state).thenReturn(
      EditRecordDetailsState(
        status: EditRecordDetailsStatus.initial,
        editRecordDetailsViewModel: viewModel,
      ),
    );
    when(() => editRecordDetailsCubit.init(viewModel)).thenAnswer((_) async {});
  });

  group('EditRecordDetailsPage Initial State', () {
    testWidgets('displays initial widgets correctly',
        (WidgetTester tester) async {
      await pumpEditRecordDetailsPage(tester);
      await tester.pumpAndSettle();

      expect(find.text('Example title'), findsOneWidget);
      expect(find.text('Example transcription'), findsOneWidget);

      expect(find.byType(BaseTextField), findsNWidgets(3));
      expect(find.byType(PrimaryChip), findsNothing);
      expect(find.byType(PrimaryButton), findsOneWidget);
    });
  });

  group('EditRecordDetailsPage Interactions', () {
    testWidgets('calls addTag on tapping plus icon inside Tags field',
        (WidgetTester tester) async {
      await pumpEditRecordDetailsPage(tester);
      await tester.pumpAndSettle();

      const newTag = 'Example tag';
      await tester.enterText(
        find.widgetWithText(BaseTextField, 'Tags'),
        newTag,
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.byIcon(PhosphorIcons.plus()),
      );
      await tester.pumpAndSettle();

      verify(() => editRecordDetailsCubit.addTag(newTag)).called(1);
    });

    testWidgets('calls addTag on pressing submit button in Tags field',
        (WidgetTester tester) async {
      await pumpEditRecordDetailsPage(tester);
      await tester.pumpAndSettle();

      const newTag = 'Example tag';
      await tester.enterText(
        find.widgetWithText(BaseTextField, 'Tags'),
        newTag,
      );
      await tester.pumpAndSettle();

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      verify(() => editRecordDetailsCubit.addTag(newTag)).called(1);
    });

    testWidgets('calls saveRecord on tapping the main submit button',
        (WidgetTester tester) async {
      when(() => editRecordDetailsCubit.saveRecord(
            title: any(named: 'title'),
            text: any(named: 'text'),
          )).thenAnswer((_) async {});

      await pumpEditRecordDetailsPage(tester);
      await tester.pumpAndSettle();

      await tester.tap(
        find.byType(PrimaryButton),
      );
      await tester.pumpAndSettle();

      verify(() => editRecordDetailsCubit.saveRecord(
            title: 'Example title',
            text: 'Example transcription',
          )).called(1);
    });

    testWidgets('calls saveRecord on tapping the main submit button',
        (WidgetTester tester) async {
      when(() => editRecordDetailsCubit.saveRecord(
            title: any(named: 'title'),
            text: any(named: 'text'),
          )).thenAnswer((_) async {});

      await pumpEditRecordDetailsPage(tester);
      await tester.pumpAndSettle();

      await tester.tap(
        find.byType(PrimaryButton),
      );
      await tester.pumpAndSettle();

      verify(() => editRecordDetailsCubit.saveRecord(
            title: 'Example title',
            text: 'Example transcription',
          )).called(1);
    });

    testWidgets('show required fields text', (WidgetTester tester) async {
      when(() => editRecordDetailsCubit.state).thenReturn(
        EditRecordDetailsState(
          formErrors: [
            EditRecordDetailsFormError.titleRequired,
            EditRecordDetailsFormError.transcriptionRequired,
          ],
        ),
      );
      await pumpEditRecordDetailsPage(tester);
      await tester.pumpAndSettle();

      expect(find.text('Example title'), findsOneWidget);
      expect(find.text('Example transcription'), findsOneWidget);

      expect(find.byType(BaseTextField), findsNWidgets(3));
      expect(find.byType(PrimaryChip), findsNothing);
      expect(find.byType(PrimaryButton), findsOneWidget);

      expect(find.text('Required field'), findsNWidgets(2));
    });
  });
}
