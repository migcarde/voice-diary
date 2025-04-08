import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/core/container_decorators.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/button_type.dart';
import 'package:voice_diary/widgets/option_button.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({
    super.key,
    required this.parentContext,
    required this.onTapDelete,
  });

  final BuildContext parentContext;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(parentContext);
    final theme = Theme.of(parentContext);

    return Center(
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
              l10n.are_you_sure,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.s,
              ),
              child: Text(
                l10n.all_data_related_to_this_account_will_be_deleted_and_cannot_be_recovered,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppDimens.l),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      l10n.cancel,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppDimens.m,
                    ),
                    child: OptionButton(
                      type: ButtonType.negative,
                      text: l10n.delete,
                      onTap: () {
                        context.pop();
                        onTapDelete();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
