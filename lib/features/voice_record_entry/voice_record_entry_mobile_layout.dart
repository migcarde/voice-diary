import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/features/voice_record_entry/cubit/voice_record_entry_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/models/save_record_entry_view_model.dart';
import 'package:voice_diary/features/voice_record_entry/widget/voice_record_entry_buttons.dart';
import 'package:voice_diary/features/voice_record_entry/widget/voice_record_entry_stopped_buttons.dart';
import 'package:voice_diary/features/voice_record_entry/widget/voice_record_entry_timer.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/widgets/base_dialog.dart';
import 'package:voice_diary/widgets/primary_circular_icon_button.dart';

class VoiceRecordEntryMobileLayout extends StatelessWidget {
  const VoiceRecordEntryMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = context.theme;

    return BlocBuilder<VoiceRecordEntryCubit, VoiceRecordEntryState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (state.status.isInitialized || state.status.isStopped) ...[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VoiceRecordEntryTimer(
                        duration: state.recordingDuration,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimens.s,
                        ),
                        child: Icon(
                          PhosphorIcons.microphone(),
                          size: AppDimens.iconButtonSize,
                          color: theme.primaryColor,
                        ),
                      ),
                      if (state.status.isRecording)
                        Text(
                          l10n.recording_dots,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      if (state.status.isStopped)
                        Text(
                          l10n.did_you_want_to_save_this_recording,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
              if (state.status.isReady) ...[
                PrimaryCircularIconButton(
                  icon: PhosphorIcons.microphone(),
                  onTap: () async => await context
                      .read<VoiceRecordEntryCubit>()
                      .startRecording(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimens.m,
                  ),
                  child: Text(
                    l10n.tap_to_begin_your_voice_recor_entry,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
              if (state.status.isInitialized)
                VoiceRecordEntryButtons(
                  isRecording: state.status.isRecording,
                  onTapStop: () async => await context
                      .read<VoiceRecordEntryCubit>()
                      .stopRecording(),
                  onTapPlayer: () async => state.status.isRecording
                      ? await context
                          .read<VoiceRecordEntryCubit>()
                          .pauseRecording()
                      : await context
                          .read<VoiceRecordEntryCubit>()
                          .resumeRecording(),
                ),
              if (state.status.isStopped)
                VoiceRecordEntryStoppedButtons(
                  onTapDelete: () => showDialog(
                    context: context,
                    builder: (dialogContext) => BaseDialog(
                      title: l10n.are_you_sure,
                      content: l10n.this_action_cannot_be_undone,
                      primaryButtonText: l10n.delete,
                      secondaryButtonText: l10n.cancel,
                      onTapPrimaryButton: () {
                        context.read<VoiceRecordEntryCubit>().deleteRecording();
                        dialogContext.pop();
                        context.pop();
                      },
                      onTapSecondaryButton: () => dialogContext.pop(),
                    ),
                  ),
                  onTapSave: () {
                    if (state.date != null) {
                      context.push(
                        Paths.saveRecordEntry,
                        extra: SaveRecordEntryViewModel(
                          title: '',
                          date: state.date!,
                          tags: [],
                          path: state.path,
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
