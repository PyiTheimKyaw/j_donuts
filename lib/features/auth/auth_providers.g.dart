// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userLocalDataSource)
final userLocalDataSourceProvider = UserLocalDataSourceProvider._();

final class UserLocalDataSourceProvider
    extends
        $FunctionalProvider<
          UserLocalDataSource,
          UserLocalDataSource,
          UserLocalDataSource
        >
    with $Provider<UserLocalDataSource> {
  UserLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserLocalDataSource create(Ref ref) {
    return userLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserLocalDataSource>(value),
    );
  }
}

String _$userLocalDataSourceHash() =>
    r'1041c33608ca20b1f589e54839ef3bad2d9ed282';

@ProviderFor(sessionRepository)
final sessionRepositoryProvider = SessionRepositoryProvider._();

final class SessionRepositoryProvider
    extends
        $FunctionalProvider<
          SessionRepository,
          SessionRepository,
          SessionRepository
        >
    with $Provider<SessionRepository> {
  SessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<SessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SessionRepository create(Ref ref) {
    return sessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionRepository>(value),
    );
  }
}

String _$sessionRepositoryHash() => r'c8c44611b44d27a9853dcd24eb95959847fd3446';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'd1289daac6ba037a2a3ede34f3b894f3b22d437b';

@ProviderFor(requestOtp)
final requestOtpProvider = RequestOtpProvider._();

final class RequestOtpProvider
    extends $FunctionalProvider<RequestOtp, RequestOtp, RequestOtp>
    with $Provider<RequestOtp> {
  RequestOtpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestOtpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestOtpHash();

  @$internal
  @override
  $ProviderElement<RequestOtp> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RequestOtp create(Ref ref) {
    return requestOtp(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RequestOtp value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RequestOtp>(value),
    );
  }
}

String _$requestOtpHash() => r'6a6084720df1c15f54621be221c644b2a2001236';

@ProviderFor(verifyOtp)
final verifyOtpProvider = VerifyOtpProvider._();

final class VerifyOtpProvider
    extends $FunctionalProvider<VerifyOtp, VerifyOtp, VerifyOtp>
    with $Provider<VerifyOtp> {
  VerifyOtpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyOtpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyOtpHash();

  @$internal
  @override
  $ProviderElement<VerifyOtp> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VerifyOtp create(Ref ref) {
    return verifyOtp(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerifyOtp value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerifyOtp>(value),
    );
  }
}

String _$verifyOtpHash() => r'86e0f00388f2557d7efd59e18391142116cebdd8';

@ProviderFor(registerUser)
final registerUserProvider = RegisterUserProvider._();

final class RegisterUserProvider
    extends $FunctionalProvider<RegisterUser, RegisterUser, RegisterUser>
    with $Provider<RegisterUser> {
  RegisterUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerUserHash();

  @$internal
  @override
  $ProviderElement<RegisterUser> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RegisterUser create(Ref ref) {
    return registerUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterUser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterUser>(value),
    );
  }
}

String _$registerUserHash() => r'f86fe1558ae36fe7e1e7793575174fa85bdbadc8';

@ProviderFor(restoreSession)
final restoreSessionProvider = RestoreSessionProvider._();

final class RestoreSessionProvider
    extends $FunctionalProvider<RestoreSession, RestoreSession, RestoreSession>
    with $Provider<RestoreSession> {
  RestoreSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restoreSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restoreSessionHash();

  @$internal
  @override
  $ProviderElement<RestoreSession> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RestoreSession create(Ref ref) {
    return restoreSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestoreSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestoreSession>(value),
    );
  }
}

String _$restoreSessionHash() => r'db86765b1d10e9fa6b22e91b12438b31ff7f00ea';

@ProviderFor(getProfile)
final getProfileProvider = GetProfileProvider._();

final class GetProfileProvider
    extends $FunctionalProvider<GetProfile, GetProfile, GetProfile>
    with $Provider<GetProfile> {
  GetProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProfileHash();

  @$internal
  @override
  $ProviderElement<GetProfile> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetProfile create(Ref ref) {
    return getProfile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetProfile value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetProfile>(value),
    );
  }
}

String _$getProfileHash() => r'02ef26d5c8bf6220552b8146326a8b234e55bcb6';

@ProviderFor(logOut)
final logOutProvider = LogOutProvider._();

final class LogOutProvider extends $FunctionalProvider<LogOut, LogOut, LogOut>
    with $Provider<LogOut> {
  LogOutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logOutProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logOutHash();

  @$internal
  @override
  $ProviderElement<LogOut> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LogOut create(Ref ref) {
    return logOut(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogOut value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogOut>(value),
    );
  }
}

String _$logOutHash() => r'fad1e9baf7fd3e42ff287a803ff2efbc4e8166aa';
