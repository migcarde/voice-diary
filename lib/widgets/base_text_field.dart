import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/widgets/click_detector.dart';

enum BaseTextFieldType {
  normal,
  password;

  bool get isPassword => this == BaseTextFieldType.password;
}

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    super.key,
    required this.hint,
    this.enabled = true,
    this.icon,
    this.errorText,
    this.controller,
    this.textType = BaseTextFieldType.normal,
    this.onSubmitted,
    this.onTapIcon,
  });

  final String hint;
  final bool enabled;

  final IconData? icon;
  final String? errorText;
  final TextEditingController? controller;
  final BaseTextFieldType textType;
  final Function(String)? onSubmitted;
  final VoidCallback? onTapIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      style: theme.textTheme.bodyLarge,
      obscureText: textType.isPassword,
      enableSuggestions: !textType.isPassword,
      autocorrect: !textType.isPassword,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hint,
        enabled: enabled,
        suffixIcon: ClickDetector(
          onTap: onTapIcon ?? () {},
          child: Icon(
            icon,
            color: theme.primaryColor,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppDimens.cardRadius,
            ),
          ),
        ),
        filled: true,
        fillColor: theme.colorScheme.primaryContainer,
        errorText: errorText,
        errorMaxLines: 6,
      ),
    );
  }
}
