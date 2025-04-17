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
  });

  final int id;
  final String title;
  final DateTime date;
  final String path;
  final List<String> tags;
  final String transcription;

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        path,
        tags,
      ];

  RecordLocalEntity get localEntity => RecordLocalEntity(
        id: id,
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
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
      );
}
