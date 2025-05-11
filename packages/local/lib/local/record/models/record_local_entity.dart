import 'package:core/core.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
// ignore: must_be_immutable
class RecordLocalEntity extends Equatable {
  RecordLocalEntity({
    this.id = 0,
    required this.title,
    required this.date,
    required this.path,
    required this.tags,
    required this.transcription,
    required this.durationInSeconds,
  });

  @Id()
  int id;
  final String title;
  final DateTime date;
  final String path;
  final List<String> tags;
  final String transcription;
  final int durationInSeconds;

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        path,
        tags,
        transcription,
        durationInSeconds,
      ];
}
