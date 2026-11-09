import 'package:j_donuts/features/auth/auth_providers.dart';
import 'package:j_donuts/features/auth/presentation/session/session_controller.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/features/home/home_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_models.g.dart';

// One stream per Home section so each can load, fail and be empty on its own
// instead of the whole screen sharing one spinner.

@riverpod
Stream<List<PromoBanner>> homeBanners(Ref ref) =>
    ref.watch(watchBannersProvider).call();

@riverpod
Stream<List<HomeSection>> homeSections(Ref ref) =>
    ref.watch(watchHomeSectionsProvider).call();

@riverpod
Stream<List<Shop>> nearbyShops(Ref ref) => ref.watch(watchShopsProvider).call();

/// Shared with Rewards so both screens always show the same tier and points.
@Riverpod(keepAlive: true)
Stream<Member?> currentMember(Ref ref) => ref.watch(watchMemberProvider).call();

/// The signed-in user's first name, so a new registration is greeted by the
/// name they typed rather than the seeded loyalty record's name.
@riverpod
Future<String?> greetingName(Ref ref) async {
  final session = ref.watch(sessionControllerProvider).value;
  if (session == null) return null;
  final profile = await ref.watch(getProfileProvider).call(session.phone);
  return profile.valueOrNull?.name.firstName;
}
