import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/features/bottom_bar/bottom_bar.dart';
import 'package:voice_diary/features/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:voice_diary/features/home/home_mobile_layout.dart';
import 'package:voice_diary/widgets/base_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomBarCubit>(
      create: (context) => getIt<BottomBarCubit>(),
      child: Scaffold(
        bottomNavigationBar: BottomBar(),
        body: BaseScreen(
          child: HomeMobileLayout(),
        ),
      ),
    );
  }
}
