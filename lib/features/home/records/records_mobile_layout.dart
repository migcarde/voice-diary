import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/features/home/records/cubit/records_cubit.dart';
import 'package:voice_diary/features/home/records/records_filters/cubit/records_filters_cubit.dart';
import 'package:voice_diary/features/home/records/widgets/record_tile.dart';
import 'package:voice_diary/features/home/records/records_filters/records_filters.dart';
import 'package:voice_diary/features/record_details/models/record_details_view_model.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/widgets/message_screen.dart';

class RecordsMobileLayout extends StatelessWidget {
  const RecordsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RecordsCubit, RecordsState>(
      bloc: context.read<RecordsCubit>()..init(),
      builder: (context, state) {
        return Stack(
          children: [
            switch (state.status) {
              RecordsStatus.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
              RecordsStatus.error => MessageScreen(
                  message: l10n.sorry_we_have_problems_please_try_again_later,
                  icon: PhosphorIcons.smileySad(),
                ),
              RecordsStatus.empty => MessageScreen(
                  message: l10n.you_have_not_added_any_record_yet,
                  icon: PhosphorIcons.microphoneSlash(),
                ),
              RecordsStatus.data => ListView.separated(
                  itemCount: state.filteredRecords.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppDimens.m,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      final refresh = await context.push(
                        Paths.voiceRecordDetails,
                        extra:
                            state.filteredRecords[index].recordDetailsViewModel,
                      );

                      if (refresh == true && context.mounted) {
                        context.read<RecordsCubit>().init();
                      }
                    },
                    child: RecordTile(
                      recordViewModel: state.filteredRecords[index],
                    ),
                  ),
                ),
            },
            if (!state.status.isLoading)
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  elevation: 0.0,
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    builder: (BuildContext modalBottomSheetContext) {
                      return BlocProvider(
                        create: (context) =>
                            getIt<RecordsFiltersCubit>()..init(state.tags),
                        child: RecordsFilters(
                          onSelectTag: (selectedTags) => context
                              .read<RecordsCubit>()
                              .searchByTag(selectedTags),
                        ),
                      );
                    },
                  ),
                  child: Icon(
                    PhosphorIcons.funnelSimple(),
                    size: AppDimens.l,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
