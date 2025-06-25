import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/audio_player/cubit/audio_player_cubit.dart';
import 'package:voice_diary/features/record_details/cubit/record_details_cubit.dart';
import 'package:voice_diary/features/record_details/models/record_details_view_model.dart';
import 'package:voice_diary/features/record_details/record_details_page.dart';
import 'package:voice_diary/l10n/app_localizations.dart';

class MockAudioPlayerCubit extends MockCubit<AudioPlayerState>
    implements AudioPlayerCubit {}

void main() {
  late MockAudioPlayerCubit audioPlayerCubit;
  final today = DateTime.now();
  setUp(() {
    audioPlayerCubit = MockAudioPlayerCubit();
    getIt.registerFactory<AudioPlayerCubit>(
      () => audioPlayerCubit,
    );
    getIt.registerFactory<RecordDetailsCubit>(
      () => RecordDetailsCubit(),
    );
  });
  testWidgets('show record details page', (WidgetTester tester) async {
    when(() => audioPlayerCubit.state).thenReturn(
      AudioPlayerState(
        status: AudioPlayerStatus.ready,
        position: const Duration(seconds: 0),
        recordDuration: const Duration(seconds: 10),
      ),
    );
    when(() => audioPlayerCubit.init(
          path: 'path',
          recordDuration: const Duration(
            seconds: 10,
          ),
        )).thenAnswer((_) async {});
    await tester.pumpWidget(
      MaterialApp(
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: AppTheme.mainTheme(),
        home: RecordDetailsPage(
          recordDetailsViewModel: RecordDetailsViewModel(
            id: 1,
            date: today,
            title: 'title',
            path: 'path',
            tags: ['tag'],
            transcription: 'transcription',
            duration: Duration(
              seconds: 10,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('title'), findsOneWidget);
    expect(find.text('tag'), findsOneWidget);
    expect(find.text('transcription'), findsOneWidget);
  });
}
