part of 'audio_player_cubit.dart';

enum AudioPlayerStatus {
  initial,
  ready,
  paused,
  stopped,
  playing;

  bool get isInitial => this == initial;
  bool get isReady => this == ready;
  bool get isPaused => this == paused;
  bool get isStopped => this == stopped;
  bool get isPlaying => this == playing;
  bool get isInitialized => this == playing || this == paused;
}

class AudioPlayerState extends Equatable {
  const AudioPlayerState({
    this.status = AudioPlayerStatus.initial,
    this.position = Duration.zero,
    this.path = '',
    this.recordDuration = Duration.zero,
  });

  final AudioPlayerStatus status;
  final String path;
  final Duration position;
  final Duration recordDuration;

  AudioPlayerState copyWith({
    AudioPlayerStatus? status,
    String? path,
    Duration? position,
    Duration? recordDuration,
  }) =>
      AudioPlayerState(
        status: status ?? this.status,
        path: path ?? this.path,
        position: position ?? this.position,
        recordDuration: recordDuration ?? this.recordDuration,
      );

  @override
  List<Object?> get props => [
        status,
        path,
        position,
        recordDuration,
      ];
}
