import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';

class ContainerDecorators {
  static BoxDecoration card({
    Color color = Colors.white,
  }) =>
      BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          AppDimens.cardRadius,
        ),
      );

  static BoxDecoration circular({
    Color color = Colors.white,
  }) =>
      BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          AppDimens.circularRadius,
        ),
      );
}
