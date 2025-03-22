import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/core/container_decorators.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/widgets/button_type.dart';
import 'package:voice_diary/widgets/option_button.dart';
import 'package:voice_diary/widgets/primary_link.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    required this.title,
    required this.content,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onTapPrimaryButton,
    required this.onTapSecondaryButton,
  });

  final String title;
  final String content;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onTapPrimaryButton;
  final VoidCallback onTapSecondaryButton;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Center(
      child: Container(
        decoration: ContainerDecorators.card(
          color: theme.colorScheme.surface,
        ),
        padding: const EdgeInsets.all(
          AppDimens.screenPadding,
        ),
        margin: const EdgeInsets.all(
          AppDimens.screenPadding,
        ),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.s,
              ),
              child: Text(
                content,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.l,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryLink(
                    text: secondaryButtonText,
                    onTap: onTapSecondaryButton,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppDimens.m,
                    ),
                    child: OptionButton(
                      text: primaryButtonText,
                      onTap: onTapPrimaryButton,
                      type: ButtonType.alternative,
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
