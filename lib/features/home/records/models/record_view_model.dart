import 'package:core/core.dart';
import 'package:domain/repositories/record/models/record_entity.dart';

class RecordViewModel extends Equatable {
  const RecordViewModel({
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
}

extension RecordEntityExtensions on RecordEntity {
  RecordViewModel get viewModel => RecordViewModel(
        title: title,
        date: date,
        path: path,
        tags: tags,
      );
}
