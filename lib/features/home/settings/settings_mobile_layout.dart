import 'package:core/services/get_it_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';
import 'package:voice_diary/features/home/settings/cubit/settings_cubit.dart';
import 'package:voice_diary/features/home/settings/reauthentication/cubit/reauthentication_cubit.dart';
import 'package:voice_diary/features/home/settings/reauthentication/reauthentication_dialog.dart';
import 'package:voice_diary/features/home/settings/widgets/delete_user_dialog.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/widgets/primary_button.dart';

class SettingsMobileLayout extends StatelessWidget {
  const SettingsMobileLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryButton(
          text: l10n.change_language,
          leftIcon: PhosphorIcons.globe(),
          onTap: () async => context.push(
            Paths.changeLanguage,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: AppDimens.l,
          ),
          child: GestureDetector(
            onTap: () => getIt<AppCubit>().logout(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.signOut(),
                  color: theme.primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimens.s,
                  ),
                  child: Text(
                    l10n.logout,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: AppDimens.l),
          child: PrimaryButton(
            text: l10n.delete_account,
            leftIcon: PhosphorIcons.trash(),
            onTap: () => showDialog(
              context: context,
              builder: (deleteUserDialogContext) => DeleteUserDialog(
                parentContext: context,
                onTapDelete: () => showDialog(
                  context: context,
                  builder: (reauthenticationDialogContext) =>
                      BlocProvider<ReauthenticationCubit>(
                    create: (context) => getIt<ReauthenticationCubit>(),
                    child: ReauthenticationDialog(
                      parentContext: context,
                      onSuccess: () =>
                          context.read<SettingsCubit>().removeUser(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
