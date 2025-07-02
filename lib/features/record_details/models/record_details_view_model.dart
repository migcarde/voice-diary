import 'package:core/core.dart';
import 'package:voice_diary/features/home/records/models/record_view_model.dart';

class RecordDetailsViewModel extends Equatable {
  const RecordDetailsViewModel({
    required this.id,
    required this.title,
    required this.date,
    required this.path,
    required this.tags,
    required this.transcription,
    required this.duration,
  });

  final int id;
  final String title;
  final DateTime date;
  final String path;
  final List<String> tags;
  final String transcription;
  final Duration duration;

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        path,
        tags,
        transcription,
        duration,
      ];
}

extension RecordViewModelExtensions on RecordViewModel {
  RecordDetailsViewModel get recordDetailsViewModel => RecordDetailsViewModel(
        id: id,
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
        duration: duration,
      );
}
