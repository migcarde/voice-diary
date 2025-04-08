import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/features/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:voice_diary/features/home/records/records_page.dart';
import 'package:voice_diary/features/home/settings/settings_page.dart';
import 'package:voice_diary/routing/paths.dart';

class HomeMobileLayout extends StatefulWidget {
  const HomeMobileLayout({super.key});

  @override
  State<HomeMobileLayout> createState() => _HomeMobileLayoutState();
}

class _HomeMobileLayoutState extends State<HomeMobileLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomBarCubit, BottomBarState>(
      listener: (context, state) {
        switch (state.selectedTab) {
          case BottomBarTabs.records:
            _tabController.index = 0;
            break;
          case BottomBarTabs.settings:
            _tabController.index = 1;
            break;
        }
      },
      child: SafeArea(
        child: Stack(
          children: [
            TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                RecordsPage(),
                SettingsPage(),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () => context.push(
                  Paths.voiceRecordEntry,
                ),
                child: Icon(
                  PhosphorIcons.funnelSimple(),
                  size: AppDimens.l,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
