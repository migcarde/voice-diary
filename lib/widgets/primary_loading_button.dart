import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';

class PrimaryLoadingButton extends StatelessWidget {
  const PrimaryLoadingButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isLoading,
  });

  final String text;
  final VoidCallback onTap;
  final bool isLoading;

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
          child: isLoading
              ? FittedBox(
                  child: CircularProgressIndicator(
                    color: theme.buttonTheme.colorScheme?.surface,
                  ),
                )
              : Text(
                  text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.buttonTheme.colorScheme?.surface,
                  ),
                ),
        ),
      ),
    );
  }
}
