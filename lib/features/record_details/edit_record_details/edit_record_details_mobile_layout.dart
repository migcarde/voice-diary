import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/features/home/records/cubit/records_cubit.dart';
import 'package:voice_diary/features/record_details/edit_record_details/cubit/edit_record_details_cubit.dart';
import 'package:voice_diary/features/record_details/edit_record_details/models/edit_record_details_view_model.dart';
import 'package:voice_diary/features/snackbar/app_snackbar.dart';
import 'package:voice_diary/features/snackbar/app_snackbar_type.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_button.dart';
import 'package:voice_diary/widgets/primary_chip.dart';

class EditRecordDetailsMobileLayout extends StatelessWidget {
  const EditRecordDetailsMobileLayout({
    super.key,
    required this.editRecordDetailsViewModel,
  });

  final EditRecordDetailsViewModel editRecordDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController()
      ..text = editRecordDetailsViewModel.title;
    final tagsController = TextEditingController();
    final transcriptionController = TextEditingController()
      ..text = editRecordDetailsViewModel.transcription;

    final l10n = AppLocalizations.of(context);

    return BlocConsumer<EditRecordDetailsCubit, EditRecordDetailsState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.pop(
            state.editRecordDetailsViewModel,
          );
          context.read<RecordsCubit>().init();
          AppSnackbar.show(
            message: l10n.record_updated_successfully,
            type: AppSnackbarType.positive,
            context: context,
          );
        } else if (state.status.isFailure) {
          AppSnackbar.show(
            message: l10n.sorry_we_have_problems_please_try_again_later,
            type: AppSnackbarType.negative,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseTextField(
                  controller: titleController,
                  hint: l10n.title,
                  errorText:
                      state.hasTitleRequiredError ? l10n.required_field : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimens.m,
                  ),
                  child: BaseTextField(
                    controller: tagsController,
                    hint: l10n.tags,
                    icon: PhosphorIcons.plus(),
                    onTapIcon: () => context
                        .read<EditRecordDetailsCubit>()
                        .addTag(tagsController.text),
                    onSubmitted: (_) => context
                        .read<EditRecordDetailsCubit>()
                        .addTag(tagsController.text),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimens.s,
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: AppDimens.s,
                    runSpacing: AppDimens.s,
                    children: state.editRecordDetailsViewModel?.tags
                            .map(
                              (tag) => PrimaryChip(
                                text: tag,
                                icon: PhosphorIcons.x(),
                                onTap: () => context
                                    .read<EditRecordDetailsCubit>()
                                    .removeTag(tag),
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimens.m,
                  ),
                  child: BaseTextField(
                    controller: transcriptionController,
                    hint: l10n.transcription,
                    errorText: state.hasTranscriptionRequiredError
                        ? l10n.required_field
                        : null,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryButton(
                text: l10n.save,
                onTap: () => context.read<EditRecordDetailsCubit>().saveRecord(
                      title: titleController.text,
                      text: transcriptionController.text,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
