import 'package:core/core.dart';
import 'package:local/local.dart';

class RecordEntity extends Equatable {
  const RecordEntity({
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
        duration,
      ];

  RecordLocalEntity get localEntity => RecordLocalEntity(
        id: id,
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
        durationInSeconds: duration.inSeconds,
      );
}

extension RecordLcalEntityExtensions on RecordLocalEntity {
  RecordEntity get entity => RecordEntity(
        id: id,
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
        duration: Duration(
          seconds: durationInSeconds,
        ),
      );
}
