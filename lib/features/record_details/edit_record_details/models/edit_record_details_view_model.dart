import 'package:core/core.dart';
import 'package:domain/repositories/record/models/record_entity.dart';
import 'package:voice_diary/features/record_details/models/record_details_view_model.dart';

class EditRecordDetailsViewModel extends Equatable {
  const EditRecordDetailsViewModel({
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

  EditRecordDetailsViewModel copyWith({
    int? id,
    String? title,
    DateTime? date,
    String? path,
    List<String>? tags,
    String? transcription,
    Duration? duration,
  }) =>
      EditRecordDetailsViewModel(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        duration: duration ?? this.duration,
        path: path ?? this.path,
        tags: tags ?? this.tags,
        transcription: transcription ?? this.transcription,
      );

  RecordEntity get entity => RecordEntity(
        id: id,
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
        duration: duration,
      );

  RecordDetailsViewModel get detailsViewModel => RecordDetailsViewModel(
        id: id,
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
        duration: duration,
      );
}

extension RecordDetailsExtensions on RecordDetailsViewModel {
  EditRecordDetailsViewModel get editRecordDetailsViewModel =>
      EditRecordDetailsViewModel(
        id: id,
        title: title,
        date: date,
        path: path,
        tags: tags,
        transcription: transcription,
        duration: duration,
      );
}
