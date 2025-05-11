import 'package:flutter_sound/flutter_sound.dart';

abstract class SoundPlayerService {
  Future<FlutterSoundPlayer?> open();
  Future<void> close();
  Stream<PlaybackDisposition>? get progress;
  Future<void> setSubscriptionDuration(Duration duration);
  Future<void> start({
    required Codec codec,
    required String file,
  });
  Future<void> pause();
  Future<void> resume();
  Future<void> seekToPlayer(Duration duration);
}
