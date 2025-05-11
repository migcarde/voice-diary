import 'package:core/core.dart';
import 'package:voice_diary/features/home/records/models/record_view_model.dart';

class RecordDetailsViewModel extends Equatable {
  const RecordDetailsViewModel({
    required this.title,
    required this.path,
    required this.tags,
    required this.transcription,
    required this.duration,
  });

  final String title;
  final String path;
  final List<String> tags;
  final String transcription;
  final Duration duration;

  @override
  List<Object?> get props => [
        title,
        path,
        tags,
        transcription,
      ];
}

extension RecordViewModelExtensions on RecordViewModel {
  RecordDetailsViewModel get recordDetailsViewModel => RecordDetailsViewModel(
        title: title,
        path: path,
        tags: tags,
        transcription: transcription,
        duration: duration,
      );
}
