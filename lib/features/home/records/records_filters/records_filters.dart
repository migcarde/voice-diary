import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/features/home/records/records_filters/cubit/records_filters_cubit.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_chip.dart';

class RecordsFilters extends StatelessWidget {
  const RecordsFilters({
    super.key,
    required this.onSelectTag,
  });
  final Function(Set<String>) onSelectTag;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = context.theme;
    final searchTagsController = TextEditingController();

    return BlocBuilder<RecordsFiltersCubit, RecordsFiltersState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            left: AppDimens.screenPadding,
            right: AppDimens.screenPadding,
            top: AppDimens.cardPaddingVertical,
            bottom: AppDimens.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.filter_by_tag,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.s,
                ),
                child: BaseTextField(
                  hint: l10n.search_tag,
                  controller: searchTagsController,
                  icon: PhosphorIcons.magnifyingGlass(),
                  onTapIcon: () => context
                      .read<RecordsFiltersCubit>()
                      .searchTag(searchTagsController.text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.m,
                ),
                child: Text(
                  l10n.tap_a_tag_to_filter,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColor,
                      ),
                ),
              ),
              if (state.filteredTags.isNotEmpty ||
                  state.selectedTags.isNotEmpty)
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
                    children: [
                      ...state.selectedTags.map(
                        (tag) => PrimaryChip(
                          text: tag,
                          icon: PhosphorIcons.x(),
                          onTap: () {
                            final selectedTags = {...state.selectedTags};
                            selectedTags.remove(tag);
                            onSelectTag(selectedTags);

                            context.read<RecordsFiltersCubit>().removeTag(tag);
                          },
                        ),
                      ),
                      ...state.filteredTags.map(
                        (tag) => PrimaryChip(
                          text: tag,
                          onTap: () {
                            final selectedTags = {...state.selectedTags, tag};
                            onSelectTag(selectedTags);

                            context.read<RecordsFiltersCubit>().addTag(tag);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if (state.filteredTags.isEmpty && state.selectedTags.isEmpty)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.m,
                    ),
                    child: Text(
                      l10n.no_tags_found,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
