import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_diary/features/voice_record_entry/cubit/voice_record_entry_cubit.dart';
import 'package:voice_diary/services/sound_recorder/sound_recoder_service.dart';

class SoundRecoderServiceMock extends Mock implements SoundRecoderService {}

void main() {
  late SoundRecoderServiceMock soundRecoderService;
  late VoiceRecordEntryCubit voiceRecordEntryCubit;

  setUp(() {
    soundRecoderService = SoundRecoderServiceMock();
    voiceRecordEntryCubit = VoiceRecordEntryCubit(
      soundRecoderService: soundRecoderService,
    );
  });

  group('Init', () {
    final DateTime today = DateTime.now();
    blocTest<VoiceRecordEntryCubit, VoiceRecordEntryState>(
      'emits [ready] on init success.',
      build: () => voiceRecordEntryCubit,
      act: (bloc) => withClock(
        Clock.fixed(today),
        () => voiceRecordEntryCubit.init(),
      ),
      setUp: () {
        when(() => soundRecoderService.open()).thenAnswer(
          (_) async => FlutterSoundRecorder(),
        );
        when(
          () => soundRecoderService.setSubscriptionDuration(
            const Duration(
              seconds: 1,
            ),
          ),
        ).thenAnswer((_) async {});
        when(() => soundRecoderService.close()).thenAnswer(
          (_) async {},
        );
      },
      expect: () => <VoiceRecordEntryState>[
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.ready,
          date: today,
        ),
      ],
    );
  });

  group('Set duration', () {
    blocTest<VoiceRecordEntryCubit, VoiceRecordEntryState>(
      'emits [recordingDuration] on update its value.',
      build: () => voiceRecordEntryCubit,
      act: (bloc) => voiceRecordEntryCubit.setDuration(
        Duration(
          seconds: 1,
        ),
      ),
      setUp: () {
        when(() => soundRecoderService.close()).thenAnswer((_) async {});
      },
      expect: () => const <VoiceRecordEntryState>[
        VoiceRecordEntryState(
          recordingDuration: Duration(
            seconds: 1,
          ),
        ),
      ],
    );
  });

  group('Start recording', () {
    final today = DateTime(2024);

    blocTest<VoiceRecordEntryCubit, VoiceRecordEntryState>(
      'emits [recording] when start recording.',
      build: () => voiceRecordEntryCubit,
      act: (bloc) => withClock(
          Clock.fixed(today), () => voiceRecordEntryCubit.startRecording()),
      setUp: () {
        when(
          () => soundRecoderService.start(
              codec: Codec.aacMP4, file: '${today.toString()}.mp4'),
        ).thenAnswer((_) async {});
        when(() => soundRecoderService.close()).thenAnswer(
          (_) async {},
        );
      },
      expect: () => <VoiceRecordEntryState>[
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.recording,
          path: '${today.toString()}.mp4',
        ),
      ],
    );
  });

  group('Pause recording', () {
    blocTest<VoiceRecordEntryCubit, VoiceRecordEntryState>(
      'emits [paused] when pause recording.',
      build: () => voiceRecordEntryCubit,
      act: (bloc) => voiceRecordEntryCubit.pauseRecording(),
      setUp: () {
        when(
          () => soundRecoderService.pause(),
        ).thenAnswer((_) async {});
        when(() => soundRecoderService.close()).thenAnswer(
          (_) async {},
        );
      },
      expect: () => <VoiceRecordEntryState>[
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.paused,
        ),
      ],
    );
  });

  group('Resume recording', () {
    blocTest<VoiceRecordEntryCubit, VoiceRecordEntryState>(
      'emits [recording] when resume recording.',
      build: () => voiceRecordEntryCubit,
      act: (bloc) => voiceRecordEntryCubit.resumeRecording(),
      setUp: () {
        when(
          () => soundRecoderService.resume(),
        ).thenAnswer((_) async {});
        when(() => soundRecoderService.close()).thenAnswer(
          (_) async {},
        );
      },
      expect: () => <VoiceRecordEntryState>[
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.recording,
        ),
      ],
    );
  });

  group('Stop recording', () {
    blocTest<VoiceRecordEntryCubit, VoiceRecordEntryState>(
      'emits [stopped] when stop recording.',
      build: () => voiceRecordEntryCubit,
      act: (bloc) => voiceRecordEntryCubit.stopRecording(),
      setUp: () {
        when(
          () => soundRecoderService.stop(),
        ).thenAnswer((_) async {});
        when(() => soundRecoderService.close()).thenAnswer(
          (_) async {},
        );
      },
      expect: () => <VoiceRecordEntryState>[
        VoiceRecordEntryState(
          status: VoiceRecordEntryStatus.stopped,
        ),
      ],
    );
  });

  group('Delete recording', () {
    blocTest<VoiceRecordEntryCubit, VoiceRecordEntryState>(
      'remove recording from path.',
      build: () => voiceRecordEntryCubit,
      act: (bloc) => voiceRecordEntryCubit.deleteRecording(),
      setUp: () {
        when(
          () => soundRecoderService.delete('path'),
        ).thenAnswer((_) async {});
        when(() => soundRecoderService.close()).thenAnswer(
          (_) async {},
        );
      },
      seed: () => VoiceRecordEntryState(
        path: 'path',
      ),
      expect: () => <VoiceRecordEntryState>[],
    );
  });
}
