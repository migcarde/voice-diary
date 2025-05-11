import 'package:flutter/material.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/extensions/duration_extensions.dart';

class VoiceRecordEntryTimer extends StatelessWidget {
  const VoiceRecordEntryTimer({
    super.key,
    required this.duration,
  });
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Text(
      duration.toFormattedString,
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.primaryColor,
      ),
    );
  }
}
