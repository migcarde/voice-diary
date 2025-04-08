import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.leftIcon,
  });

  final String text;
  final VoidCallback onTap;
  final IconData? leftIcon;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: AppDimens.buttonHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(
            AppDimens.buttonPadding,
          ),
          decoration: BoxDecoration(
            color: theme.buttonTheme.colorScheme?.primary,
            borderRadius: BorderRadius.circular(
              AppDimens.cardRadius,
            ),
          ),
          child: Row(
            children: [
              if (leftIcon != null)
                Padding(
                  padding: const EdgeInsets.only(
                    right: AppDimens.s,
                  ),
                  child: Icon(
                    leftIcon,
                    color: theme.buttonTheme.colorScheme?.surface,
                  ),
                ),
              Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.buttonTheme.colorScheme?.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
