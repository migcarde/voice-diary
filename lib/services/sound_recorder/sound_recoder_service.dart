import 'package:flutter_sound/flutter_sound.dart';

abstract class SoundRecoderService {
  Future<FlutterSoundRecorder?> open();
  Future<void> close();
  Stream<RecordingDisposition>? get progress;
  Future<void> setSubscriptionDuration(Duration duration);
  Future<void> start({
    required Codec codec,
    required String file,
  });
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  Future<void> delete(String file);
}
