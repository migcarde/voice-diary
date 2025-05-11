import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart';
import 'package:voice_diary/services/sound_player/sound_player_service.dart';

class SoundPlayerServiceImpl implements SoundPlayerService {
  const SoundPlayerServiceImpl({
    required this.player,
  });

  final FlutterSoundPlayer player;

  @override
  Future<void> close() async => await player.closePlayer();

  @override
  Future<FlutterSoundPlayer?> open() async => await player.openPlayer();

  @override
  Future<void> pause() async => await player.pausePlayer();

  @override
  Stream<PlaybackDisposition>? get progress => player.onProgress;

  @override
  Future<void> resume() async => await player.resumePlayer();

  @override
  Future<void> setSubscriptionDuration(Duration duration) async =>
      await player.setSubscriptionDuration(duration);

  @override
  Future<void> start({required Codec codec, required String file}) async =>
      await player.startPlayer(
        codec: codec,
        fromURI: file,
      );

  @override
  Future<void> seekToPlayer(Duration duration) async =>
      await player.seekToPlayer(duration);
}
