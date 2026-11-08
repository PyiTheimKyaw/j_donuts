# J'Donuts

A working slice of the J'Donuts customer app: onboarding with fake login and registration, an offline-first Home and
Product detail, and an animated Rewards screen.

> Status: Phase 0 (foundation). Sections marked _TBD_ are filled in as later phases land.
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

_TBD — rationale written in Phase 2._

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
