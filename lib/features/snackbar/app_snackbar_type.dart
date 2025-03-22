import 'package:flutter/material.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';

enum AppSnackbarType {
  positive,
  negative;

  Color getBackgroundColor(BuildContext context) {
    final theme = context.theme;

    switch (this) {
      case AppSnackbarType.positive:
        return theme.colorScheme.tertiaryContainer;
      case AppSnackbarType.negative:
        return theme.colorScheme.error;
    }
  }
}
