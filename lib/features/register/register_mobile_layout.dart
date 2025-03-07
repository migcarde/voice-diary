import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/features/register/cubit/register_cubit.dart';
import 'package:voice_diary/features/snackbar/app_snackbar.dart';
import 'package:voice_diary/features/snackbar/app_snackbar_type.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_loading_button.dart';

class RegisterMobileLayout extends StatelessWidget {
  const RegisterMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final repeatPasswordController = TextEditingController();

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        switch (state.status) {
          case RegisterStatus.initial:
            break;
          case RegisterStatus.error:
            AppSnackbar.show(
              message: l10n.sorry_we_have_problems_please_try_again_later,
              type: AppSnackbarType.negative,
              context: context,
            );
          case RegisterStatus.success:
          case RegisterStatus.loading:
            break;
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseTextField(
                    hint: l10n.email,
                    controller: emailController,
                    errorText: state.errors.hasEmailErrors
                        ? state.errors.getEmailErrorMessage(context)
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.m,
                    ),
                    child: BaseTextField(
                      hint: l10n.password,
                      textType: BaseTextFieldType.password,
                      errorText: state.errors
                              .contains(RegisterError.passwordMustBeStronger)
                          ? l10n.passwords_is_weak
                          : null,
                      controller: passwordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.m,
                    ),
                    child: BaseTextField(
                      hint: l10n.repeat_password,
                      textType: BaseTextFieldType.password,
                      errorText:
                          state.errors.contains(RegisterError.passwordNotMatch)
                              ? l10n.password_does_not_match
                              : null,
                      controller: repeatPasswordController,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryLoadingButton(
                text: l10n.register,
                isLoading: state.status.isLoading,
                onTap: () => context.read<RegisterCubit>().register(
                      email: emailController.text,
                      password: passwordController.text,
                      repeatPassword: repeatPasswordController.text,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
