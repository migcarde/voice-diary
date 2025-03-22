import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/features/voice_record_entry/cubit/voice_record_entry_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/voice_record_entry_mobile_layout.dart';
import 'package:voice_diary/widgets/base_scaffold.dart';

class VoiceRecordEntryPage extends StatelessWidget {
  const VoiceRecordEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VoiceRecordEntryCubit>(
      create: (context) => getIt<VoiceRecordEntryCubit>()..init(),
      child: BaseScaffold(
        child: const VoiceRecordEntryMobileLayout(),
      ),
    );
  }
}
