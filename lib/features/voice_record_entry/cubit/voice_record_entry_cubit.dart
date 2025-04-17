import 'package:bloc/bloc.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_diary/services/sound_recorder/sound_recoder_service.dart';

part 'voice_record_entry_state.dart';

class VoiceRecordEntryCubit extends Cubit<VoiceRecordEntryState> {
  VoiceRecordEntryCubit({
    required this.soundRecoderService,
    required this.speechToText,
  }) : super(const VoiceRecordEntryState());

  final SoundRecoderService soundRecoderService;
  final SpeechToText speechToText;

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
    await speechToText.initialize();
    await soundRecoderService.open();
    await soundRecoderService.setSubscriptionDuration(
      const Duration(
        seconds: 1,
      ),
    );
    // await Future.wait(
    //   [
    //     soundRecoderService.open(),
    //     soundRecoderService.setSubscriptionDuration(
    //       const Duration(
    //         seconds: 1,
    //       ),
    //     ),
    //   ],
    // );
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

    await _initTranscription();

    emit(
      state.copyWith(
        status: VoiceRecordEntryStatus.recording,
        path: file,
      ),
    );
  }

  Future<void> pauseRecording() async {
    Future.wait(
      [
        if (speechToText.isListening) speechToText.stop(),
        soundRecoderService.pause(),
      ],
    );

    emit(
      state.copyWith(
        status: VoiceRecordEntryStatus.paused,
        transcription: speechToText.isListening
            ? '${state.transcription} ${state.recordingTranscription}'
            : state.transcription,
      ),
    );
  }

  Future<void> resumeRecording() async {
    await Future.wait(
      [
        _initTranscription(),
        soundRecoderService.resume(),
      ],
    );

    emit(
      state.copyWith(
        status: VoiceRecordEntryStatus.recording,
      ),
    );
  }

  Future<void> stopRecording() async {
    await Future.wait(
      [
        if (speechToText.isListening) speechToText.stop(),
        soundRecoderService.stop(),
      ],
    );

    emit(
      state.copyWith(
        status: VoiceRecordEntryStatus.stopped,
        transcription: speechToText.isListening
            ? '${state.transcription} ${state.recordingTranscription}'
            : state.transcription,
      ),
    );
  }

  Future<void> deleteRecording() async => await soundRecoderService.delete(
        state.path,
      );

  @override
  Future<void> close() {
    soundRecoderService.close();
    speechToText.stop();

    return super.close();
  }

  Future<void> _initTranscription() async {
    final locale = await speechToText.systemLocale();

    await speechToText.listen(
      localeId: locale?.localeId,
      onResult: (result) {
        emit(
          state.copyWith(
            recordingTranscription: result.recognizedWords,
          ),
        );
      },
    );
  }
}
