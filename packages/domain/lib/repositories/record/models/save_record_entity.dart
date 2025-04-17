import 'package:core/core.dart';
import 'package:local/local.dart';

class SaveRecordEntity extends Equatable {
  const SaveRecordEntity({
    required this.title,
    required this.date,
    required this.path,
    required this.tags,
    required this.transcription,
  });
  final String title;
  final DateTime date;
  final String path;
  final List<String> tags;
  final String transcription;

  @override
  List<Object?> get props => [
        title,
        date,
        path,
        tags,
        transcription,
      ];

  RecordLocalEntity get localEntity => RecordLocalEntity(
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
      );
}
