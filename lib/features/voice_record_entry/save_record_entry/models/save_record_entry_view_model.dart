import 'package:core/core.dart';
import 'package:domain/repositories/record/models/save_record_entity.dart';

class SaveRecordEntryViewModel extends Equatable {
  const SaveRecordEntryViewModel({
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

  SaveRecordEntity get entity => SaveRecordEntity(
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
      );

  SaveRecordEntryViewModel copyWith({
    String? title,
    DateTime? date,
    String? path,
    List<String>? tags,
    String? transcription,
  }) =>
      SaveRecordEntryViewModel(
        title: title ?? this.title,
        date: date ?? this.date,
        path: path ?? this.path,
        tags: tags ?? this.tags,
        transcription: transcription ?? this.transcription,
      );
}
