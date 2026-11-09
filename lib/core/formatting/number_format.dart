import 'package:intl/intl.dart';

/// Thousands-separated integer in the given locale (`680,000`). Burmese
/// renders Myanmar digits, which is what a Burmese reader expects.
String formatGrouped(int value, {String? locale}) =>
    NumberFormat.decimalPattern(locale).format(value);
