abstract class SoundPlayerService {
  Future<void> close();
  Future<Duration?> getDuration();
  Stream<Duration> get onDurationChanged;
  Future<void> start(String path);
  Future<void> pause();
  Future<void> resume();
  Future<void> seek(Duration duration);
}
