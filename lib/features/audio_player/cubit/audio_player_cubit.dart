import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
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
    await soundPlayerService.seek(duration);
    setDuration(duration);
  }

  Future<void> start() async {
    try {
      await soundPlayerService.start(state.path);
    } catch (e) {
      rethrow;
    }

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
