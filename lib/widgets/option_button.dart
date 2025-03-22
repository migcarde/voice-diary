import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/core/container_decorators.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/widgets/button_type.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    super.key,
    required this.text,
    required this.onTap,
    this.type = ButtonType.initial,
  });

  final String text;
  final VoidCallback onTap;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = type.getOptionButtonStyle(theme);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimens.optionButtonHeight,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.l,
        ),
        decoration: ContainerDecorators.card(
          color: style.backgroundColor,
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: style.textColor,
          ),
        ),
      ),
    );
  }
}
