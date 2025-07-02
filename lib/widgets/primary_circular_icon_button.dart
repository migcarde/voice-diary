import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/core/container_decorators.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/widgets/click_detector.dart';

class PrimaryCircularIconButton extends StatelessWidget {
  const PrimaryCircularIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClickDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          AppDimens.m,
        ),
        decoration: ContainerDecorators.circular(
          color: theme.colorScheme.primaryContainer,
        ),
        child: Icon(
          icon,
          color: theme.primaryColor,
          size: AppDimens.iconButtonSize,
        ),
      ),
    );
  }
}
