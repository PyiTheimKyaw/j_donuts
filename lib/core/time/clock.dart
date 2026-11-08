import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

typedef Clock = DateTime Function();

/// Injected so date rules (minimum age) are deterministic under test.
@Riverpod(keepAlive: true)
Clock clock(Ref ref) => DateTime.now;
