import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/features/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:voice_diary/features/bottom_bar/widgets/navigation_bar_icon.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/paths.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  static const _blur = 6.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _blur,
          sigmaY: _blur,
        ),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor.withAlpha(20),
          child: BlocBuilder<BottomBarCubit, BottomBarState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavigationBarIcon(
                    text: l10n.records,
                    icon: PhosphorIcons.musicNotesSimple(),
                    isSelected: state.selectedTab.isRecords,
                    onTap: () => context.read<BottomBarCubit>().selectTab(
                          selectedTab: BottomBarTabs.records,
                        ),
                  ),
                  NavigationBarIcon(
                    text: l10n.entry,
                    icon: PhosphorIcons.microphone(),
                    isSelected: false,
                    onTap: () => context.push(
                      Paths.voiceRecordEntry,
                    ),
                  ),
                  NavigationBarIcon(
                    text: l10n.settings,
                    icon: PhosphorIcons.gear(),
                    isSelected: state.selectedTab.isSettings,
                    onTap: () => context.read<BottomBarCubit>().selectTab(
                          selectedTab: BottomBarTabs.settings,
                        ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
