import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';
import 'package:voice_diary/features/snackbar/app_snackbar_type.dart';

class AppSnackbar {
  static Future<void> show({
    required String message,
    required AppSnackbarType type,
    required BuildContext context,
  }) async =>
      await Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: message,
        duration: const Duration(
          seconds: 3,
        ),
        backgroundColor: type.getBackgroundColor(context),
        borderRadius: BorderRadius.circular(
          AppDimens.cardRadius,
        ),
        margin: const EdgeInsets.all(
          AppDimens.screenPadding,
        ),
      ).show(context);
}
