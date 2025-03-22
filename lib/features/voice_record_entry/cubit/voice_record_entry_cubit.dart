import 'package:bloc/bloc.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:voice_diary/services/sound_recorder/sound_recoder_service.dart';

part 'voice_record_entry_state.dart';

class VoiceRecordEntryCubit extends Cubit<VoiceRecordEntryState> {
  VoiceRecordEntryCubit({
    required this.soundRecoderService,
  }) : super(const VoiceRecordEntryState());

  final SoundRecoderService soundRecoderService;

  Future<void> init() async {
    await _openRecorder();

    soundRecoderService.progress?.listen((event) {
      setDuration(
        const Duration(
          seconds: 1,
        ),
      );
    });

    emit(
      state.copyWith(
        status: VoiceRecordEntryStatus.ready,
        date: clock.now(),
      ),
    );
  }

  Future<void> _openRecorder() async {
    await Future.wait(
      [
        soundRecoderService.open(),
        soundRecoderService.setSubscriptionDuration(
          const Duration(
            seconds: 1,
          ),
        ),
      ],
    );
  }

  Future<void> setDuration(Duration duration) async => emit(
        state.copyWith(
          recordingDuration: state.recordingDuration + duration,
        ),
      );

  Future<void> startRecording() async {
    final today = clock.now();
    final file = '${today.toString()}.mp4';
    await soundRecoderService.start(
      codec: Codec.aacMP4,
      file: file,
    );

    emit(
      state.copyWith(
        status: VoiceRecordEntryStatus.recording,
        path: file,
      ),
    );
  }

  Future<void> pauseRecording() async {
    await soundRecoderService.pause();

    emit(
      state.copyWith(
        status: VoiceRecordEntryStatus.paused,
      ),
    );
  }

  Future<void> resumeRecording() async {
    await soundRecoderService.resume();

    emit(
      state.copyWith(
        status: VoiceRecordEntryStatus.recording,
      ),
    );
  }

  Future<void> stopRecording() async {
    await soundRecoderService.stop();

    emit(
      state.copyWith(
        status: VoiceRecordEntryStatus.stopped,
      ),
    );
  }

  Future<void> deleteRecording() async => await soundRecoderService.delete(
        state.path,
      );

  @override
  Future<void> close() {
    soundRecoderService.close();

    return super.close();
  }
}
