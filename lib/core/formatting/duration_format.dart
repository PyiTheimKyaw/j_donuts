/// `m:ss`, the format the resend countdown uses (`4:58`).
String formatMinutesSeconds(Duration duration) {
  final clamped = duration.isNegative ? Duration.zero : duration;
  final minutes = clamped.inMinutes;
  final seconds = clamped.inSeconds.remainder(Duration.secondsPerMinute);
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}
