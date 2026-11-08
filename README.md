# J'Donuts

A working slice of the J'Donuts customer app: onboarding with fake login and registration, an offline-first Home and
Product detail, and an animated Rewards screen.

> Status: auth domain and data layers done; screens start next. Sections marked _TBD_ are filled in as later phases land.
> The roadmap is in [`docs/IMPLEMENTATION_PLAN.md`](docs/IMPLEMENTATION_PLAN.md).

## Versions

| Tool | Version |
|---|---|
| Flutter | 3.47.9 (stable) |
| Dart | 3.13.7 |

## How to run

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run            # pick an iOS Simulator or Android emulator
```

Quality gates, also run by CI on every pull request:

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos
flutter test
```

Generated files (`*.g.dart`, `*.freezed.dart`, `lib/l10n/generated/`) are committed so the
project opens cleanly in an IDE, and CI regenerates them to make sure they are in sync.

## Fake OTP

The one-time code is always **`123456`**. Any other six digits fail; three wrong codes lock
the boxes until you tap **Resend**.

## Architecture

Feature-first folders, each split into `presentation`, `domain` and `data`. The domain layer
is pure Dart with no Flutter imports. Presentation depends on domain; data implements the
domain's repository interfaces, so swapping the fake auth or adding a real API never touches
the UI.

```
lib/
  app/        MaterialApp, go_router, theme tokens, motion constants
  core/       Result/Failure types, database, connectivity, shared widgets
  features/
    auth/     onboarding, phone, OTP, name, date of birth
    home/     welcome, home sections, member header
    product/  product detail
    rewards/  rewards screen and painters
    shell/    bottom navigation, placeholder tabs, settings
  l10n/       ARB files (en, my) and generated localizations
```

### State management: Riverpod

Riverpod 3 with code generation (`riverpod_annotation` + `riverpod_generator`) handles both
state and dependency injection:

- **One composition root per feature.** `lib/features/auth/auth_providers.dart` is the only
  file that knows `AuthRepository` is backed by `FakeAuthRepository`. Swapping in a real API
  is a one-line change there and touches no screen.
- **No services created inside widgets.** Repositories, data sources and use cases are all
  providers; widgets read them through `ref`.
- **Testable by override.** Widget and integration tests pass `ProviderScope(overrides: ...)`
  with an in-memory Drift database, an in-memory key-value store and zero fake latency
  (see `test/helpers/test_overrides.dart`). Nothing in the tests touches a device plugin.
- **Session as a single async source of truth.** `SessionController` is a keep-alive
  `AsyncNotifier<AuthSession?>`: loading while secure storage is read at launch, then
  `null` or a session. go_router's `refreshListenable` is driven by it, and the redirect rule
  itself (`lib/app/router/auth_redirect.dart`) is a pure function with its own unit tests.


### Offline strategy

_TBD — written in Phase 4._

### Animations

_TBD — written in Phase 7._

## Tests

_TBD — written in Phase 8._

## Image credits

_TBD — written in Phase 4._

## Known gaps

_TBD_

## Time spent

_TBD_
