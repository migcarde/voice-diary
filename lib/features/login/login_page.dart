import 'package:core/services/get_it_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';
import 'package:voice_diary/features/login/login_mobile_layout.dart';
import 'package:voice_diary/widgets/base_scaffold.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: BaseScaffold(
        child: LoginMobileLayout(),
      ),
    );
  }
}
