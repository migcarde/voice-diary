import 'package:core/core.dart';
import 'package:local/local.dart';

class SaveRecordEntity extends Equatable {
  const SaveRecordEntity({
    required this.title,
    required this.date,
    required this.path,
    required this.tags,
  });
  final String title;
  final DateTime date;
  final String path;
  final List<String> tags;

  @override
  List<Object?> get props => [
        title,
        date,
        path,
        tags,
      ];

  RecordLocalEntity get localEntity => RecordLocalEntity(
        title: title,
        date: date,
        path: path,
        tags: tags,
      );
}
