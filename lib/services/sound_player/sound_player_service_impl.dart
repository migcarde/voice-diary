import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_diary/services/sound_player/sound_player_service.dart';

class SoundPlayerServiceImpl implements SoundPlayerService {
  const SoundPlayerServiceImpl({
    required this.player,
  });

  final AudioPlayer player;

  @override
  Future<void> close() async => await player.dispose();

  @override
  Future<void> pause() async => await player.pause();

  @override
  Future<Duration?> getDuration() => player.getDuration();

  @override
  Future<void> resume() async => await player.resume();

  @override
  Stream<Duration> get onDurationChanged => player.onDurationChanged;

  @override
  Future<void> start(String path) async {
    final status = await Permission.audio.request();

    if (status.isGranted) {
      await player.play(
        DeviceFileSource(path),
      );
    }
  }

  @override
  Future<void> seek(Duration duration) async => await player.seek(duration);
}
