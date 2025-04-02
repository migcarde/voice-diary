import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/core/container_decorators.dart';
import 'package:voice_diary/features/home/settings/reauthentication/cubit/reauthentication_cubit.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_loading_button.dart';

class ReauthenticationDialog extends StatelessWidget {
  const ReauthenticationDialog({
    super.key,
    required this.parentContext,
    required this.onSuccess,
  });

  final BuildContext parentContext;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(parentContext);
    final theme = Theme.of(parentContext);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocConsumer<ReauthenticationCubit, ReauthenticationState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          onSuccess();
          context.pop();
        }
      },
      builder: (context, state) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.cardPaddingHorizontal,
                vertical: AppDimens.cardPaddingVertical,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimens.screenPadding,
              ),
              decoration: ContainerDecorators.card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.you_must_enter_your_credentials_again_to_delete_your_account,
                    style: theme.textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.m,
                    ),
                    child: BaseTextField(
                      hint: l10n.email,
                      controller: emailController,
                      errorText:
                          state.emailNotValid ? l10n.email_not_valid : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.m,
                    ),
                    child: BaseTextField(
                      hint: l10n.password,
                      controller: passwordController,
                      textType: BaseTextFieldType.password,
                      errorText: state.error.isInvalidCredentials
                          ? state.error.getMessage(parentContext)
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.m,
                    ),
                    child: PrimaryLoadingButton(
                      text: l10n.login,
                      isLoading: state.status.isLoading,
                      onTap: () =>
                          context.read<ReauthenticationCubit>().reauthenticate(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TextFieldType {}
