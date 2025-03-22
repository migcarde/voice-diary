import 'package:core/core.dart';

class VoiceRecordEntryViewModel extends Equatable {
  const VoiceRecordEntryViewModel({
    required this.title,
    required this.tags,
    required this.recordingPath,
  });

  final String title;
  final List<String> tags;
  final String recordingPath;

  @override
  List<Object?> get props => [
        title,
        tags,
        recordingPath,
      ];
}
