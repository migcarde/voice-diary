import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/features/home/records/cubit/records_cubit.dart';
import 'package:voice_diary/features/home/records/widgets/record_tile.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/message_screen.dart';

class RecordsMobileLayout extends StatelessWidget {
  const RecordsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<RecordsCubit, RecordsState>(
      builder: (context, state) {
        switch (state.status) {
          case RecordsStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RecordsStatus.error:
            return MessageScreen(
              message: l10n.sorry_we_have_problems_please_try_again_later,
              icon: PhosphorIcons.smileySad(),
            );
          case RecordsStatus.empty:
            return MessageScreen(
              message: l10n.you_have_not_added_any_record_yet,
              icon: PhosphorIcons.microphoneSlash(),
            );
          case RecordsStatus.data:
            return ListView.separated(
              itemCount: state.records.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: AppDimens.m,
              ),
              itemBuilder: (context, index) => RecordTile(
                recordViewModel: state.records[index],
              ),
            );
        }
      },
    );
  }
}
