import 'package:core/services/get_it_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/cubit/save_record_entry_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/models/save_record_entry_view_model.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/save_record_entry_mobile_layout.dart';
import 'package:voice_diary/widgets/base_scaffold.dart';

class SaveRecordEntryPage extends StatelessWidget {
  const SaveRecordEntryPage({
    super.key,
    required this.viewModel,
  });

  final SaveRecordEntryViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SaveRecordEntryCubit>()..init(viewModel),
      child: BaseScaffold(
        child: SaveRecordEntryMobileLayout(),
      ),
    );
  }
}
