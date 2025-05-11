import 'package:flutter/widgets.dart';
import 'package:voice_diary/features/record_details/models/record_details_view_model.dart';
import 'package:voice_diary/features/record_details/record_details_mobile_layout.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/base_scaffold.dart';

class RecordDetailsPage extends StatelessWidget {
  const RecordDetailsPage({
    super.key,
    required this.recordDetailsViewModel,
  });

  final RecordDetailsViewModel recordDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BaseScaffold(
      title: l10n.record_details,
      child: RecordDetailsMobileLayout(
        recordDetailsViewModel: recordDetailsViewModel,
      ),
    );
  }
}
