import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/audio_player/audio_player.dart';
import 'package:voice_diary/features/audio_player/cubit/audio_player_cubit.dart';
import 'package:voice_diary/l10n/app_localizations.dart';

class MockAudioPlayerCubit extends MockCubit<AudioPlayerState>
    implements AudioPlayerCubit {}

void main() {
  group('Audio Player', () {
    testWidgets('show audio player with no progress with ready state',
        (WidgetTester tester) async {
      final audioPlayerCubit = MockAudioPlayerCubit();
      when(() => audioPlayerCubit.state).thenReturn(
        AudioPlayerState(
          status: AudioPlayerStatus.ready,
          position: const Duration(seconds: 0),
          recordDuration: const Duration(seconds: 10),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<AudioPlayerCubit>(
              create: (context) => audioPlayerCubit,
              child: const AudioPlayer(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Slider), findsOneWidget);
      expect(find.text('00:00:00'), findsOneWidget);
      expect(find.text('00:00:10'), findsOneWidget);
      expect(find.byIcon(PhosphorIcons.play()), findsOneWidget);
    });

    testWidgets('calls to start function on play button tap',
        (WidgetTester tester) async {
      final audioPlayerCubit = MockAudioPlayerCubit();
      when(() => audioPlayerCubit.state).thenReturn(
        AudioPlayerState(
          status: AudioPlayerStatus.ready,
          position: const Duration(seconds: 0),
          recordDuration: const Duration(seconds: 10),
        ),
      );
      when(() => audioPlayerCubit.start()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<AudioPlayerCubit>(
              create: (context) => audioPlayerCubit,
              child: const AudioPlayer(),
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(PhosphorIcons.play()));

      verify(() => audioPlayerCubit.start()).called(1);
    });

    testWidgets('calls to pause function on pause button tap',
        (WidgetTester tester) async {
      final audioPlayerCubit = MockAudioPlayerCubit();
      when(() => audioPlayerCubit.state).thenReturn(
        AudioPlayerState(
          status: AudioPlayerStatus.playing,
          position: const Duration(seconds: 0),
          recordDuration: const Duration(seconds: 10),
        ),
      );
      when(() => audioPlayerCubit.pause()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<AudioPlayerCubit>(
              create: (context) => audioPlayerCubit,
              child: const AudioPlayer(),
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(PhosphorIcons.pause()));

      verify(() => audioPlayerCubit.pause()).called(1);
    });

    testWidgets('calls to resume function on play button tap',
        (WidgetTester tester) async {
      final audioPlayerCubit = MockAudioPlayerCubit();
      when(() => audioPlayerCubit.state).thenReturn(
        AudioPlayerState(
          status: AudioPlayerStatus.paused,
          position: const Duration(seconds: 0),
          recordDuration: const Duration(seconds: 10),
        ),
      );
      when(() => audioPlayerCubit.resume()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.mainTheme(),
          home: Scaffold(
            body: BlocProvider<AudioPlayerCubit>(
              create: (context) => audioPlayerCubit,
              child: const AudioPlayer(),
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(PhosphorIcons.play()));

      verify(() => audioPlayerCubit.resume()).called(1);
    });
  });
}
