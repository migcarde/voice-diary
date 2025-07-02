import 'package:core/core.dart';
import 'package:domain/repositories/record/models/record_entity.dart';

class RecordViewModel extends Equatable {
  const RecordViewModel({
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
}

extension RecordEntityExtensions on RecordEntity {
  RecordViewModel get viewModel => RecordViewModel(
        id: id,
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
        duration: duration,
      );
}
