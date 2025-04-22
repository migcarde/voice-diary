import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/core/container_decorators.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/widgets/click_detector.dart';

class PrimaryChip extends StatelessWidget {
  const PrimaryChip({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
  });

  final String text;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClickDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.s,
          vertical: AppDimens.xs,
        ),
        decoration: ContainerDecorators.circular(
          color: theme.colorScheme.primaryContainer,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.primaryColor,
              ),
            ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(
                  left: AppDimens.s,
                ),
                child: Icon(
                  icon,
                  size: AppDimens.m,
                  color: theme.primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
