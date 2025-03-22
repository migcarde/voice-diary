import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/widgets/primary_button.dart';

class HomeMobileLayout extends StatelessWidget {
  const HomeMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          text: 'Go to player',
          onTap: () => context.push(
            Paths.voiceRecordEntry,
          ),
        ),
        PrimaryButton(
          text: 'Logout',
          onTap: () => context.read<AppCubit>().logout(),
        ),
      ],
    );
  }
}
