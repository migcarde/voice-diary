import 'package:flutter/material.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';

class VoiceRecordEntryTimer extends StatelessWidget {
  const VoiceRecordEntryTimer({
    super.key,
    required this.duration,
  });
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final seconds = duration.inSeconds.remainder(60);
    final minutes = duration.inMinutes.remainder(60);
    final hours = duration.inHours;
    final timerSeconds = seconds < 10 ? '0$seconds' : '$seconds';
    final timerMinutes = minutes < 10 ? '0$minutes' : '$minutes';
    final timerHours = hours < 10 ? '0$hours' : '$hours';

    return Text(
      '$timerHours:$timerMinutes:$timerSeconds',
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.primaryColor,
      ),
    );
  }
}
