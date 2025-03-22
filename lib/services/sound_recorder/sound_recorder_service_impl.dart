import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_diary/services/sound_recorder/sound_recoder_service.dart';

class SoundRecorderServiceImpl implements SoundRecoderService {
  const SoundRecorderServiceImpl({
    required this.recorder,
  });

  final FlutterSoundRecorder recorder;

  @override
  Future<void> close() async => await recorder.closeRecorder();

  @override
  Future<void> delete(String file) async =>
      await recorder.deleteRecord(fileName: file);

  @override
  Future<FlutterSoundRecorder?> open() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      await openAppSettings();
      throw RecordingPermissionException('Microphone permission not granted');
    }

    return await recorder.openRecorder();
  }

  @override
  Future<void> pause() async => await recorder.pauseRecorder();

  @override
  Stream<RecordingDisposition>? get progress => recorder.onProgress;

  @override
  Future<void> resume() async => await recorder.resumeRecorder();

  @override
  Future<void> setSubscriptionDuration(Duration duration) async =>
      await recorder.setSubscriptionDuration(duration);

  @override
  Future<void> start({required Codec codec, required String file}) async =>
      await recorder.startRecorder(
        codec: codec,
        toFile: file,
      );

  @override
  Future<void> stop() async => await recorder.stopRecorder();
}
