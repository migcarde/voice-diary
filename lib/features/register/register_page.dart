import 'package:core/services/get_it_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/features/register/cubit/register_cubit.dart';
import 'package:voice_diary/features/register/register_mobile_layout.dart';
import 'package:voice_diary/widgets/base_scaffold.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: BlocProvider<RegisterCubit>(
        create: (context) => getIt<RegisterCubit>(),
        child: RegisterMobileLayout(),
      ),
    );
  }
}
