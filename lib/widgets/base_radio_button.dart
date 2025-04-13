import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/core/container_decorators.dart';

class BaseRadioButton<T> extends StatelessWidget {
  const BaseRadioButton({
    super.key,
    required this.text,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final T value;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          left: AppDimens.m,
        ),
        decoration: ContainerDecorators.card(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
            ),
            AbsorbPointer(
              child: Radio(
                value: value,
                groupValue: isSelected ? value : null,
                onChanged: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
