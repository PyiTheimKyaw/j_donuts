# Implementation plan

How I'm approaching the J'Donuts build, what I decided up front, and the order the work
lands in. Each phase is one PR into `develop`; `develop` goes to `main` when the whole slice
is done. Status is updated as PRs merge.

## Decisions

**Riverpod 3 with code generation.** Riverpod gives me state and dependency injection in one
tool, so there is no separate `get_it` wiring to keep in sync. Providers are easy to override
in widget and integration tests, which matters for a fake auth layer and an in-memory
database. BLoC would add event/state ceremony across ten screens without buying anything the
brief asks for.

**Drift as the single source of truth.** Every screen reads the local SQLite database through
Drift streams. Seed JSON populates it on first launch, so the app works in airplane mode from
the first open. Refreshing (background or pull-to-refresh) writes into the database; the UI
never reads a network response directly. Migrations are versioned from day one: auth tables
ship in schema v1 and catalogue tables arrive in v2, so there is a real migration to show.

**No mock server, but the seam is there.** A `RemoteCatalogDataSource` interface sits in
front of a bundled-asset implementation that simulates latency and the `{data, error, meta}`
envelope. Swapping in Dio means writing one class. I chose to spend the time on motion and UI
fidelity instead, which carry more weight.

**Typed failures, no exceptions across layers.** Repositories return `Result<T>`, which is
either `Success` or `Error(Failure)`. Validators return the same type with a
`ValidationFailure` carrying a per-field enum, so screens map errors with an exhaustive
switch rather than string codes.

**Domain layer is pure Dart.** `lib/features/*/domain` has no Flutter imports. A test
(`test/features/auth/domain/domain_purity_test.dart`) enforces this.

**Design tokens and motion constants live in one place each.** `lib/app/theme` holds colours,
type, spacing and radii; `lib/app/motion` holds every duration and curve. Widgets never
contain a hex value or a millisecond literal. All animations respect Reduce Motion by reading
`MediaQuery.disableAnimations` through a single helper.

**Fonts and images are bundled.** Lexend ships as a variable font asset so first launch
renders correctly offline. Product and reward photos are royalty-free stock images bundled
under `assets/images` (credits in the README). The design screenshots belong to the client
and are gitignored.

**English and Burmese.** All strings go through ARB files and gen-l10n. The Burmese locale
also exercises the Myanmar-script name validation and the text-scale layout checks.

## Phases

| # | Branch | Scope | Status |
|---|---|---|---|
| 0 | `feat/foundation` | pubspec, lints, CI, theme tokens, motion constants, `Result`/`Failure`, router skeleton, l10n (en, my) | merged |
| 1 | `feat/auth-domain` | entities, validators, repository contracts, use cases, unit tests | merged |
| 2 | `feat/auth-data-session` | Drift v1 with `Users`, `FakeAuthRepository`, secure session store, router redirect guard | merged |
| 3a | `feat/onboarding-phone` | shared auth scaffold, button, text field, progress ring; onboarding and phone screens | merged |
| 3b | `feat/otp` | OTP boxes, shake, lockout, resend countdown | merged |
| 3c | `feat/name-dob` | name and date-of-birth steps, ring to check morph, registration completes | merged |
| 4 | `feat/offline-data` | Drift v2 catalogue tables, seed JSON and images, connectivity with reachability, image widget | merged |
| 5 | `feat/home-shell` | bottom nav with sliding pill, welcome, home sections with skeletons, settings log out | in review |
| 6 | `feat/product-detail` | hero transition, MMK formatting, animated quantity stepper, live total | |
| 7 | `feat/rewards` | points ring, tier ladder, tabs, challenge art with CustomPainter, badge pop | |
| 8 | `test/widget-integration-tests` | remaining widget tests, register-to-product integration test | |
| 9 | `chore/polish-readme-builds` | reduce motion and text scale pass, profile run, README, release builds | |

### Phase notes

**Auth (1 to 3).** Validators are pure functions tested in isolation before any UI exists.
The fake repository waits about a second, stores users in Drift, and keeps a wrong-attempt
counter that locks OTP entry after three failures until a new code is requested. The session
is held in `flutter_secure_storage`; go_router's redirect reads it so a relaunch lands on
Home or Onboarding. A registration-flow notifier keeps everything typed so Back preserves
input. Continue buttons guard against double taps by ignoring presses while a request is in
flight.

**Data (4).** Products, banners, sections, shops, the member record and challenges are all
seeded from `assets/seed`. One member record feeds both Home and Rewards; the mock-ups
disagree on tier and points, and the brief says to pick one source. Connectivity combines
`connectivity_plus` with a real reachability probe, because a connected Wi-Fi network with no
internet is the common failure case. Image URLs use an `asset://` scheme for bundled seed
images and fall back to `cached_network_image` for anything remote.

**Presentation (5 to 7).** Home loads with per-section skeletons, staggered section
entrances and an auto-playing banner carousel. Product tiles share a Hero with the detail
page. Rewards is where the motion budget goes: the sprinkled ring and all progress art are
CustomPainters, the tier ladder reveals in sequence, tabs slide, cards stagger in, and the
Earn button pulses only when a challenge is complete.

**Tests (8).** Unit tests cover validators, use cases and repositories (in-memory Drift).
Widget tests cover login and registration validation. One integration test runs
Register → Home → Product detail with provider overrides for zero latency.

## Folder map

```
lib/
  main.dart
  app/            app widget, router, theme tokens, motion constants
  core/           Result/Failure, database, connectivity, storage, formatting, shared widgets
  features/
    auth/         domain · data · presentation
    home/         domain · data · presentation
    product/      domain · data · presentation
    rewards/      domain · data · presentation
    shell/        bottom nav, placeholder tabs, settings
  l10n/           ARB files and generated localizations
assets/
  fonts/ images/ seed/
test/             unit and widget tests, mirrors lib/
integration_test/
```

## Done means

- `dart format`, `flutter analyze --fatal-infos` and `flutter test` pass locally and in CI.
- Fresh install opens Onboarding; register with `09254135592` and OTP `123456`; relaunch opens
  Home; log out from Settings; relaunch opens Onboarding.
- Log in with an unknown number shows the inline message and Register link.
- Airplane mode: Home, Product detail and Rewards render with images; the offline banner shows;
  reconnecting hides it and refreshes in the background.
- Home header and Rewards show the same tier and points.
- Reduce Motion on: animations skip to their final frame. Text scale 1.3: no overflow on a
  4.7-inch phone.
- `flutter build apk --release` and `flutter build ios --simulator` succeed from the README
  steps.
