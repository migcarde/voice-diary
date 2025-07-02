part of 'voice_record_entry_cubit.dart';

enum VoiceRecordEntryStatus {
  recording,
  paused,
  stopped,
  ready;

  bool get isRecording => this == recording;
  bool get isPaused => this == paused;
  bool get isStopped => this == stopped;
  bool get isReady => this == ready;
  bool get isInitialized => this == recording || this == paused;
}

class VoiceRecordEntryState extends Equatable {
  const VoiceRecordEntryState({
    this.status = VoiceRecordEntryStatus.ready,
    this.recordingDuration = Duration.zero,
    this.path = '',
    this.date,
    this.recordingTranscription = '',
    this.transcription = '',
  });

  final VoiceRecordEntryStatus status;
  final Duration recordingDuration;
  final String path;
  final DateTime? date;
  final String recordingTranscription;
  final String transcription;

  VoiceRecordEntryState copyWith({
    VoiceRecordEntryStatus? status,
    Duration? recordingDuration,
    String? path,
    DateTime? date,
    String? recordingTranscription,
    String? transcription,
  }) =>
      VoiceRecordEntryState(
        status: status ?? this.status,
        recordingDuration: recordingDuration ?? this.recordingDuration,
        path: path ?? this.path,
        date: date ?? this.date,
        recordingTranscription:
            recordingTranscription ?? this.recordingTranscription,
        transcription: transcription ?? this.transcription,
      );

  @override
  List<Object?> get props => [
        status,
        recordingDuration,
        path,
        date,
        recordingTranscription,
        transcription,
      ];
}
