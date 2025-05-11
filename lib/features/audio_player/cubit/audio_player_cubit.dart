import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:voice_diary/services/sound_player/sound_player_service.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit({
    required this.soundPlayerService,
  }) : super(const AudioPlayerState());

  final SoundPlayerService soundPlayerService;

  Future<void> init({
    required String path,
    required Duration recordDuration,
  }) async {
    await soundPlayerService.open();
    await soundPlayerService.setSubscriptionDuration(
      const Duration(
        seconds: 1,
      ),
    );

    soundPlayerService.progress?.listen((e) {
      setDuration(
        state.position +
            const Duration(
              seconds: 1,
            ),
      );
      debugPrint(state.position.toString());
      debugPrint(state.recordDuration.toString());

      if (state.position == Duration.zero) {
        debugPrint('initial');
        emit(
          state.copyWith(
            status: AudioPlayerStatus.initial,
          ),
        );
      } else if (state.position == state.recordDuration) {
        debugPrint('finished');
        emit(
          state.copyWith(
            position: Duration.zero,
            status: AudioPlayerStatus.ready,
          ),
        );
      }
    });

    emit(
      state.copyWith(
        path: path,
        recordDuration: recordDuration,
        status: AudioPlayerStatus.ready,
      ),
    );
  }

  Future<void> setDuration(Duration duration) async => emit(
        state.copyWith(
          position: duration,
        ),
      );

  Future<void> updateDuration(Duration duration) async {
    await soundPlayerService.seekToPlayer(duration);
    setDuration(duration);
  }

  Future<void> start() async {
    await soundPlayerService.start(
      codec: Codec.aacMP4,
      file: state.path,
    );
    emit(
      state.copyWith(
        position: Duration.zero,
        status: AudioPlayerStatus.playing,
      ),
    );
  }

  Future<void> pause() async {
    await soundPlayerService.pause();
    emit(
      state.copyWith(
        status: AudioPlayerStatus.paused,
      ),
    );
  }

  Future<void> resume() async {
    await soundPlayerService.resume();
    emit(
      state.copyWith(
        status: AudioPlayerStatus.playing,
      ),
    );
  }

  @override
  Future<void> close() {
    soundPlayerService.close();
    return super.close();
  }
}
