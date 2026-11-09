// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_models.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeBanners)
final homeBannersProvider = HomeBannersProvider._();

final class HomeBannersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PromoBanner>>,
          List<PromoBanner>,
          Stream<List<PromoBanner>>
        >
    with
        $FutureModifier<List<PromoBanner>>,
        $StreamProvider<List<PromoBanner>> {
  HomeBannersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeBannersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeBannersHash();

  @$internal
  @override
  $StreamProviderElement<List<PromoBanner>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<PromoBanner>> create(Ref ref) {
    return homeBanners(ref);
  }
}

String _$homeBannersHash() => r'377611343b2c9113facb0d1a9c9f49a6a3763b24';

@ProviderFor(homeSections)
final homeSectionsProvider = HomeSectionsProvider._();

final class HomeSectionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HomeSection>>,
          List<HomeSection>,
          Stream<List<HomeSection>>
        >
    with
        $FutureModifier<List<HomeSection>>,
        $StreamProvider<List<HomeSection>> {
  HomeSectionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeSectionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeSectionsHash();

  @$internal
  @override
  $StreamProviderElement<List<HomeSection>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HomeSection>> create(Ref ref) {
    return homeSections(ref);
  }
}

String _$homeSectionsHash() => r'1e2c36e559aaf2bf221d79f75286f15e86212b90';

@ProviderFor(nearbyShops)
final nearbyShopsProvider = NearbyShopsProvider._();

final class NearbyShopsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Shop>>,
          List<Shop>,
          Stream<List<Shop>>
        >
    with $FutureModifier<List<Shop>>, $StreamProvider<List<Shop>> {
  NearbyShopsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyShopsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyShopsHash();

  @$internal
  @override
  $StreamProviderElement<List<Shop>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Shop>> create(Ref ref) {
    return nearbyShops(ref);
  }
}

String _$nearbyShopsHash() => r'd5a50e688f8c8502def73da99f81293661845779';

/// Shared with Rewards so both screens always show the same tier and points.

@ProviderFor(currentMember)
final currentMemberProvider = CurrentMemberProvider._();

/// Shared with Rewards so both screens always show the same tier and points.

final class CurrentMemberProvider
    extends $FunctionalProvider<AsyncValue<Member?>, Member?, Stream<Member?>>
    with $FutureModifier<Member?>, $StreamProvider<Member?> {
  /// Shared with Rewards so both screens always show the same tier and points.
  CurrentMemberProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentMemberProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentMemberHash();

  @$internal
  @override
  $StreamProviderElement<Member?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Member?> create(Ref ref) {
    return currentMember(ref);
  }
}

String _$currentMemberHash() => r'217375b4381bd735d7f2df188576d9deb97dd751';

/// The signed-in user's first name, so a new registration is greeted by the
/// name they typed rather than the seeded loyalty record's name.

@ProviderFor(greetingName)
final greetingNameProvider = GreetingNameProvider._();

/// The signed-in user's first name, so a new registration is greeted by the
/// name they typed rather than the seeded loyalty record's name.

final class GreetingNameProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// The signed-in user's first name, so a new registration is greeted by the
  /// name they typed rather than the seeded loyalty record's name.
  GreetingNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'greetingNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$greetingNameHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return greetingName(ref);
  }
}

String _$greetingNameHash() => r'e445ff2c4db68cadb7f57dfb4c68f28fb26699a5';
