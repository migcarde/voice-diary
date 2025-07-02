import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/features/home/settings/cubit/settings_cubit.dart';
import 'package:voice_diary/features/home/settings/settings_mobile_layout.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => getIt<SettingsCubit>(),
      child: SettingsMobileLayout(),
    );
  }
}
