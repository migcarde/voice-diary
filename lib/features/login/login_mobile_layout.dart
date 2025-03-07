import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/routes.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_button.dart';
import 'package:voice_diary/widgets/primary_link.dart';

class LoginMobileLayout extends StatelessWidget {
  const LoginMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseTextField(
              hint: l10n.email,
              controller: emailController,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.m,
              ),
              child: BaseTextField(
                hint: l10n.password,
                controller: passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.m,
              ),
              child: PrimaryButton(
                text: l10n.login,
                onTap: () => context.read<LoginCubit>().login(
                      email: emailController.text,
                      password: emailController.text,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.m,
              ),
              child: PrimaryLink(
                text: l10n.are_you_not_registered_question,
                onTap: () => context.push(
                  Routes.register,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
