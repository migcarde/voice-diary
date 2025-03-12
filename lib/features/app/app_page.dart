import 'package:core/services/get_it_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/features/app/app_mobile_layout.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => getIt<AppCubit>()..init(),
      child: const AppMobileLayout(),
    );
  }
}
