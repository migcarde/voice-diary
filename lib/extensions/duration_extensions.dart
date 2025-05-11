extension DurationExtensions on Duration {
  String get toFormattedString {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    final timerSeconds = seconds < 10 ? '0$seconds' : '$seconds';
    final timerMinutes = minutes < 10 ? '0$minutes' : '$minutes';
    final timerHours = hours < 10 ? '0$hours' : '$hours';

    return '$timerHours:$timerMinutes:$timerSeconds';
  }
}
