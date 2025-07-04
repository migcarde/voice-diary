import 'package:core/services/get_it_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/core/container_decorators.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/features/audio_player/audio_player.dart';
import 'package:voice_diary/features/audio_player/cubit/audio_player_cubit.dart';
import 'package:voice_diary/features/record_details/cubit/record_details_cubit.dart';
import 'package:voice_diary/features/record_details/edit_record_details/models/edit_record_details_view_model.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/widgets/primary_button.dart';
import 'package:voice_diary/widgets/primary_chip.dart';

class RecordDetailsMobileLayout extends StatelessWidget {
  const RecordDetailsMobileLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = context.theme;

    return BlocBuilder<RecordDetailsCubit, RecordDetailsState>(
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocProvider<AudioPlayerCubit>(
                    create: (context) => getIt<AudioPlayerCubit>()
                      ..init(
                        path: state.recordDetailsViewModel!.path,
                        recordDuration: state.recordDetailsViewModel!.duration,
                      ),
                    child: Container(
                      decoration: ContainerDecorators.card(
                        color: theme.colorScheme.surfaceContainer,
                      ),
                      padding: const EdgeInsets.all(
                        AppDimens.m,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.recordDetailsViewModel!.title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                          AudioPlayer(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.m,
                    ),
                    child: Wrap(
                      children: state.recordDetailsViewModel!.tags
                          .map(
                            (tag) => PrimaryChip(
                              text: tag,
                              onTap: () {},
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.m,
                    ),
                    child: Text(
                      l10n.transcription,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.m,
                    ),
                    child: Text(
                      state.recordDetailsViewModel!.transcription,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryButton(
                text: l10n.edit,
                onTap: () async {
                  final result = await context.push(
                    Paths.editRecordDetails,
                    extra: state
                        .recordDetailsViewModel!.editRecordDetailsViewModel,
                  ) as EditRecordDetailsViewModel?;

                  if (result != null && context.mounted) {
                    context.read<RecordDetailsCubit>().init(
                          result.detailsViewModel,
                        );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
