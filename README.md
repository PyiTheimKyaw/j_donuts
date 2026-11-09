# J'Donuts

A working slice of the J'Donuts customer app: onboarding with fake login and registration, an offline-first Home and
Product detail, and an animated Rewards screen.

> Status: all three tasks built (registration, Home and Product detail, Rewards); final polish, builds and the integration test next. Sections marked _TBD_ are filled in as later phases land.
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

The local Drift database is the single source of truth. Screens only ever read it, through
streams, so anything written to it shows up everywhere at once.

- **First launch works in airplane mode.** `assets/seed/seed.json` is loaded into the database
  the first time anything reads it, and every seed image is bundled under `assets/images/`.
  Seeding runs once per seed version, so later launches never overwrite local changes.
- **The network only refreshes.** `CatalogRepository.refresh()` fetches `/v1/catalog`, writes the
  result into the database and records the sync time. It never hands data to a screen directly.
  If it fails, the cached data is left exactly as it was and the failure is returned as a typed
  `NetworkFailure`.
- **Refresh triggers.** `CatalogSyncController` refreshes when the app starts online, whenever the
  device goes from offline to online, and on pull-to-refresh. Overlapping requests share one
  call.
- **Online means reachable.** `connectivity_plus` only says a network interface is up, so it is
  paired with a DNS reachability probe. Wi-Fi with no internet counts as offline.
- **No server, same seam.** `AssetRemoteCatalogDataSource` serves a bundled `/v1` response in the
  `{data, error, meta}` envelope, waits like a network call and refuses to answer while offline.
  A Dio implementation of `RemoteCatalogDataSource` replaces it in `home_providers.dart` without
  touching anything else.
- **Images.** After a refresh, catalogue images point at the Unsplash CDN and load through
  `cached_network_image` with a dedicated disk cache (30 days, 300 files). If a photo is neither
  cached nor reachable, the bundled seed copy is shown instead, then an error tile as a last
  resort. Loading shows a shimmer skeleton.
- **Public versus private data.** Products, banners, sections and shops are public and refreshed.
  The member record and challenges are private to the user, so they come only from the seed.
  Home and Rewards read the same single member record.
- **Schema versions.** v1 held `users`. v2 adds the catalogue, loyalty and `sync_meta` tables
  through an additive migration, covered by a test that upgrades a real v1 database.

### Animations

All durations and curves are named constants in `lib/app/motion/app_motion.dart`. Every
animation goes through one helper that returns a zero duration when the system's Reduce Motion
setting is on, so the final frame shows immediately. Purely decorative motion, such as the
carousel auto-play, the skeleton shimmer and the Earn pulse, is switched off entirely.

| Where | What moves |
|---|---|
| Onboarding | Donut circles drift in from the corners; title, buttons and footer enter staggered |
| Registration steps | Shared-axis slide between steps; the progress ring sweeps 25% → 50% → 75% → 100% across screens (it is a Hero) and morphs into a check |
| Inputs | Focus and error borders animate; error text slides in and out |
| Buttons | Scale on press; Continue morphs into a spinner while loading and ignores a second tap |
| OTP | Each digit pops into its box; a wrong code shakes and clears the boxes |
| Welcome | Photo tiles slide in staggered from alternating sides, then the title and button rise |
| Home | Skeleton shimmer while loading; sections enter staggered; the banner carousel auto-plays and pauses on touch; the offline banner collapses away |
| Bottom nav | The pill slides to the selected tab while the slots resize around it |
| Product tile → detail | Hero flight of the product image; the stepper pops in; the quantity slides up or down with the change; the total cross-fades; Add to cart confirms with a check |
| Rewards | The points ring sweeps to the member's tier progress while the total counts up to 680,000 (one controller, so both land together); tiers enter in order and the connector to the next tier fills; the Rewards badge pops in; the tab indicator slides and resizes between the two tabs while the card list cross-fades; cards enter staggered; the donut colours in by quarters and the coffee arc fills; Earn pulses only when a challenge is complete |

The points ring, ladder connectors, tier shields, donut quarters, coffee arc, progress ring and
shops scenery are all drawn with `CustomPainter`. The points ring is shaded as an inflated donut
(a cross-section gradient across the tube, a glossy highlight, a contact shadow and shaded
sprinkles). It is painted once into a cached layer and revealed by a growing clip, so the
blurs and gradients are not repainted on every frame of the sweep; only the two rounded ends
redraw.

## Tests

```sh
flutter test                                   # unit and widget tests (CI runs these on every PR)
flutter test integration_test -d <device-id>   # end-to-end on a simulator, emulator or phone
```

| Layer | What is covered |
|---|---|
| Domain (unit) | Every validation rule (phone normalisation, OTP shape, names incl. Myanmar script, real calendar dates, leap years, minimum age 13); use cases; tier ladder and tier progress |
| Data (unit) | Fake auth (OTP lockout after 3, per-number counters, register and session), secure session store, seed loader (once per version, retry on failure), catalogue repository (offline reads, refresh, removals, empty sections), remote envelope parsing, connectivity, schema migrations v1→v3 and v2→v3 against real old schemas |
| Widgets | Each registration step's validation and loading states; Home sections, offline banner and pull-to-refresh; product detail stepper and live total; Rewards ring, ladder, tabs and challenge cards; bottom nav; Settings log out; layout on a 360×640 phone with the keyboard open and 1.3× text |
| App | Session lifecycle: register, relaunch → Home, log out, relaunch → Onboarding |
| Integration | `integration_test/register_to_product_test.dart`: a new member registers through every step, lands on Home and opens a product, on a real device |

Widget tests run against a fixed seed in `test/fixtures/seed_v1.json`, so editing the app's
seed content never breaks a behaviour test. They use an in-memory database, an in-memory secure
store, offline connectivity and zero fake latency (`test/helpers/test_overrides.dart`).

The integration test needs a device, so CI does not run it; run it locally on the iOS Simulator
and an Android emulator before a release.

## Image credits

All product, banner, shop, avatar and reward photos are from [Unsplash](https://unsplash.com)
and used under the [Unsplash License](https://unsplash.com/license). The onboarding donuts are
painted in code. The design screenshots from the brief are not in this repository.

## Known gaps

_TBD_

## Time spent

_TBD_
