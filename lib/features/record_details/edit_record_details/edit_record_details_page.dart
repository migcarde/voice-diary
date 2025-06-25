import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/features/record_details/edit_record_details/cubit/edit_record_details_cubit.dart';
import 'package:voice_diary/features/record_details/edit_record_details/edit_record_details_mobile_layout.dart';
import 'package:voice_diary/features/record_details/edit_record_details/models/edit_record_details_view_model.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/base_scaffold.dart';

class EditRecordDetailsPage extends StatelessWidget {
  const EditRecordDetailsPage({
    super.key,
    required this.editRecordDetailsViewModel,
  });

  final EditRecordDetailsViewModel editRecordDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => getIt<EditRecordDetailsCubit>()
        ..init(
          editRecordDetailsViewModel,
        ),
      child: BaseScaffold(
        title: l10n.edit,
        child: EditRecordDetailsMobileLayout(
          editRecordDetailsViewModel: editRecordDetailsViewModel,
        ),
      ),
    );
  }
}
