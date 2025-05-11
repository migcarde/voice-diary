import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_diary/features/audio_player/cubit/audio_player_cubit.dart';
import 'package:voice_diary/services/sound_player/sound_player_service.dart';

class MockSoundPlayerService extends Mock implements SoundPlayerService {}

void main() {
  late MockSoundPlayerService soundPlayerService;
  late AudioPlayerCubit cubit;

  setUp(() {
    soundPlayerService = MockSoundPlayerService();
    cubit = AudioPlayerCubit(
      soundPlayerService: soundPlayerService,
    );
  });

  group('Init', () {
    blocTest<AudioPlayerCubit, AudioPlayerState>(
      'emits [ready] when init is success.',
      build: () => cubit,
      act: (bloc) => cubit.init(
        path: 'path',
        recordDuration: const Duration(seconds: 10),
      ),
      setUp: () {
        when(() => soundPlayerService.open()).thenAnswer((_) async => null);
        when(() => soundPlayerService.setSubscriptionDuration(
            const Duration(seconds: 1))).thenAnswer((_) async {});
        when(() => soundPlayerService.close()).thenAnswer((_) async {});
      },
      expect: () => const <AudioPlayerState>[
        AudioPlayerState(
          path: 'path',
          recordDuration: Duration(seconds: 10),
          status: AudioPlayerStatus.ready,
        ),
      ],
    );
  });

  group('Set Duration', () {
    blocTest<AudioPlayerCubit, AudioPlayerState>(
      'emits updated position on call.',
      build: () => cubit,
      act: (bloc) => cubit.setDuration(
        const Duration(seconds: 10),
      ),
      setUp: () {
        when(() => soundPlayerService.close()).thenAnswer((_) async {});
      },
      expect: () => const <AudioPlayerState>[
        AudioPlayerState(
          position: Duration(seconds: 10),
        ),
      ],
    );
  });

  group('Update Duration', () {
    blocTest<AudioPlayerCubit, AudioPlayerState>(
      'emits updated position on call.',
      build: () => cubit,
      act: (bloc) => cubit.updateDuration(
        const Duration(seconds: 10),
      ),
      setUp: () {
        when(() => soundPlayerService.seekToPlayer(const Duration(seconds: 10)))
            .thenAnswer((_) async {});
        when(() => soundPlayerService.close()).thenAnswer((_) async {});
      },
      expect: () => const <AudioPlayerState>[
        AudioPlayerState(
          position: Duration(seconds: 10),
        ),
      ],
    );
  });

  group('Start', () {
    blocTest<AudioPlayerCubit, AudioPlayerState>(
      'emits [playing] when start is success.',
      build: () => cubit,
      act: (bloc) => cubit.start(),
      seed: () => const AudioPlayerState(
        path: 'path',
      ),
      setUp: () {
        when(() => soundPlayerService.start(codec: Codec.aacMP4, file: 'path'))
            .thenAnswer((_) async {});
        when(() => soundPlayerService.close()).thenAnswer((_) async {});
      },
      expect: () => const <AudioPlayerState>[
        AudioPlayerState(
          path: 'path',
          position: Duration.zero,
          status: AudioPlayerStatus.playing,
        ),
      ],
    );
  });

  group('Pause', () {
    blocTest<AudioPlayerCubit, AudioPlayerState>(
      'emits [paused] when pause is success.',
      build: () => cubit,
      act: (bloc) => cubit.pause(),
      setUp: () {
        when(() => soundPlayerService.pause()).thenAnswer((_) async {});
        when(() => soundPlayerService.close()).thenAnswer((_) async {});
      },
      expect: () => const <AudioPlayerState>[
        AudioPlayerState(
          status: AudioPlayerStatus.paused,
        ),
      ],
    );
  });

  group('Resume', () {
    blocTest<AudioPlayerCubit, AudioPlayerState>(
      'emits [playing] when resume is success.',
      build: () => cubit,
      act: (bloc) => cubit.resume(),
      setUp: () {
        when(() => soundPlayerService.resume()).thenAnswer((_) async {});
        when(() => soundPlayerService.close()).thenAnswer((_) async {});
      },
      expect: () => const <AudioPlayerState>[
        AudioPlayerState(
          status: AudioPlayerStatus.playing,
        ),
      ],
    );
  });
}
