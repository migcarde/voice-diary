import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';
import 'package:voice_diary/features/home/settings/change_language/cubit/change_language_cubit.dart';
import 'package:voice_diary/features/snackbar/app_snackbar.dart';
import 'package:voice_diary/features/snackbar/app_snackbar_type.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/base_radio_button.dart';
import 'package:voice_diary/widgets/primary_loading_button.dart';

class ChangeLanguageMobileLayout extends StatelessWidget {
  const ChangeLanguageMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocConsumer<ChangeLanguageCubit, ChangeLanguageState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<AppCubit>().changeLanguage(state.selectedLocale!);
          context.pop();
        } else if (state.status.isError) {
          AppSnackbar.show(
            message: l10n.sorry_we_have_problems_please_try_again_later,
            type: AppSnackbarType.negative,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            BaseRadioButton(
              text: l10n.english,
              value: const Locale('en'),
              isSelected: state.selectedLocale == const Locale('en'),
              onTap: () => context.read<ChangeLanguageCubit>().changeLanguage(
                    const Locale('en'),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.m,
              ),
              child: BaseRadioButton(
                text: l10n.spanish,
                value: const Locale('es'),
                isSelected: state.selectedLocale == const Locale('es'),
                onTap: () => context.read<ChangeLanguageCubit>().changeLanguage(
                      const Locale('es'),
                    ),
              ),
            ),
            const Spacer(),
            PrimaryLoadingButton(
              text: l10n.save,
              isLoading: state.status.isLoading,
              onTap: () {
                if (state.selectedLocale != null) {
                  context.read<ChangeLanguageCubit>().saveLanguage();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
