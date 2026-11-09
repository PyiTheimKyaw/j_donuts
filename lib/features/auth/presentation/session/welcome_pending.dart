import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'welcome_pending.g.dart';

/// Set just before a new account's session starts so the redirect sends the
/// user to Welcome instead of Home. Not persisted: a relaunch skips Welcome.
@Riverpod(keepAlive: true)
class WelcomePending extends _$WelcomePending {
  @override
  bool build() => false;

  void markPending() => state = true;

  void clear() => state = false;
}
