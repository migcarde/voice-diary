import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/cubit/save_record_entry_cubit.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_chip.dart';
import 'package:voice_diary/widgets/primary_loading_button.dart';

class SaveRecordEntryMobileLayout extends StatelessWidget {
  const SaveRecordEntryMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = context.theme;

    final titleController = TextEditingController();
    final tagsController = TextEditingController();
    return BlocConsumer<SaveRecordEntryCubit, SaveRecordEntryState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.pushReplacement(Paths.home);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextField(
              controller: titleController,
              hint: l10n.title,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.m,
              ),
              child: BaseTextField(
                  controller: tagsController,
                  hint: l10n.tags,
                  icon: PhosphorIcons.plus(),
                  onTapIcon: () => _addTag(context, tagsController),
                  onSubmitted: (_) => _addTag(context, tagsController)),
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
                children: state.viewModel?.tags
                        .map(
                          (tag) => PrimaryChip(
                            text: tag,
                            icon: PhosphorIcons.x(),
                            onTap: () => context
                                .read<SaveRecordEntryCubit>()
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
              child: Text(
                l10n.set_tags_to_your_record,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            PrimaryLoadingButton(
              text: l10n.save,
              onTap: () => context.read<SaveRecordEntryCubit>().save(
                    titleController.text,
                  ),
              isLoading: state.status.isLoading,
            ),
          ],
        );
      },
    );
  }

  void _addTag(BuildContext context, TextEditingController tagsController) {
    context.read<SaveRecordEntryCubit>().addTag(tagsController.text);
    tagsController.clear();
  }
}
