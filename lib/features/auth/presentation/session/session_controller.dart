import 'package:j_donuts/features/auth/auth_providers.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_controller.g.dart';

/// Drives the router redirect: loading while secure storage is read, then
/// `null` (signed out) or the session.
@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  @override
  Future<AuthSession?> build() async {
    final result = await ref.watch(restoreSessionProvider).call();
    // Unreadable storage must not block launch; treat it as signed out.
    return result.fold<AuthSession?>((_) => null, (session) => session);
  }

  void signedIn(AuthSession session) => state = AsyncData(session);

  Future<void> logOut() async {
    await ref.read(logOutProvider).call();
    state = const AsyncData(null);
  }
}
