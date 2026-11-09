import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/router/app_routes.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/app_button.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/features/auth/presentation/session/welcome_pending.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  static final int tileCount = WelcomeTile.values.length;

  void _explore(BuildContext context, WidgetRef ref) {
    ref.read(welcomePendingProvider.notifier).clear();
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.authBackground),
        child: Stack(
          children: [
            const Positioned.fill(child: _DonutTiles()),
            _WelcomeFooter(onExplore: () => _explore(context, ref)),
          ],
        ),
      ),
    );
  }
}

class _WelcomeFooter extends StatelessWidget {
  const _WelcomeFooter({required this.onExplore});

  final VoidCallback onExplore;

  static const EdgeInsets _padding = EdgeInsets.fromLTRB(
    AppSpacing.gutter,
    AppSpacing.xl,
    AppSpacing.gutter,
    AppSpacing.xl,
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: _padding,
          child: _TitleAndExplore(onExplore: onExplore),
        ),
      ),
    );
  }
}

class _TitleAndExplore extends StatelessWidget {
  const _TitleAndExplore({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _AfterTilesEntrance(
          order: 0,
          child: Text(
            l10n.welcomeTitle,
            style: AppTypography.headline,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _AfterTilesEntrance(
          order: 1,
          child: AppButton(
            key: const Key('welcome-explore'),
            label: l10n.letsExplore,
            onPressed: onExplore,
          ),
        ),
      ],
    );
  }
}

/// Continues the tiles' stagger so the footer lands once the grid is in.
class _AfterTilesEntrance extends StatelessWidget {
  const _AfterTilesEntrance({required this.order, required this.child});

  final int order;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EntranceAnimation(
      index: WelcomeScreen.tileCount + order,
      gap: AppDurations.sectionStaggerGap,
      child: child,
    );
  }
}

/// Two columns of tiles at different vertical offsets: the left column starts
/// above the screen edge and the right one drops lower, so the grid reads as
/// asymmetric rather than as a uniform 2x2. A [ShaderMask] fades the bottom
/// into the background so the title sits on the tiles without a hard edge.
class _DonutTiles extends StatelessWidget {
  const _DonutTiles();

  static const double _gap = AppSpacing.lg;

  /// Each column is slightly wider than half the screen, so the outer edges
  /// bleed off left and right as in the design.
  static const double _columnWidthFraction = 0.53;
  static const double _tileHeightFraction = 0.36;
  static const double _leftColumnRise = 0.12;
  static const double _rightColumnDrop = 0.14;

  /// The title block occupies roughly the bottom third; tiles stay solid
  /// above it and are fully faded out by the time they reach the button.
  static const double _fadeStart = 0.5;
  static const double _fadeEnd = 0.78;

  static Rect _tileRect(WelcomeTile tile, BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final columnWidth = width * _columnWidthFraction;
    final tileHeight = constraints.maxHeight * _tileHeightFraction;
    final bleed = (columnWidth * 2 + _gap - width) / 2;
    final leftX = -bleed;
    final rightX = leftX + columnWidth + _gap;
    final leftTop = -tileHeight * _leftColumnRise;
    final rightTop = tileHeight * _rightColumnDrop;
    final top =
        (tile.isLeftColumn ? leftTop : rightTop) +
        tile.row * (tileHeight + _gap);
    return Rect.fromLTWH(
      tile.isLeftColumn ? leftX : rightX,
      top,
      columnWidth,
      tileHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (bounds) => const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white, Colors.transparent],
          stops: [0, _fadeStart, _fadeEnd],
        ).createShader(bounds),
        child: ClipRect(
          child: Stack(
            children: [
              for (final tile in WelcomeTile.values)
                Positioned.fromRect(
                  rect: _tileRect(tile, constraints),
                  child: _DriftingTile(tile: tile),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DriftingTile extends StatelessWidget {
  const _DriftingTile({required this.tile});

  final WelcomeTile tile;

  @override
  Widget build(BuildContext context) {
    return EntranceAnimation(
      index: tile.index,
      gap: AppDurations.sectionStaggerGap,
      duration: AppDurations.emphasis,
      curve: AppCurves.emphasized,
      offset: Offset(
        (tile.isLeftColumn ? -1 : 1) * AppMotionOffsets.driftIn,
        0,
      ),
      child: _DonutTile(tile: tile),
    );
  }
}

/// Entrance order follows the eye: top-left, top-right, then the second row.
enum WelcomeTile {
  topLeft(
    'assets/images/welcome/tile_1.jpg',
    isLeftColumn: true,
    row: 0,
    focus: Alignment(0, 0.35),
  ),
  topRight(
    'assets/images/welcome/tile_2.jpg',
    isLeftColumn: false,
    row: 0,
    focus: Alignment.center,
  ),
  bottomLeft(
    'assets/images/welcome/tile_3.jpg',
    isLeftColumn: true,
    row: 1,
    focus: Alignment.center,
  ),
  bottomRight(
    'assets/images/welcome/tile_4.jpg',
    isLeftColumn: false,
    row: 1,
    focus: Alignment(0.2, 0),
  );

  WelcomeTile(
    this.asset, {
    required this.isLeftColumn,
    required this.row,
    required this.focus,
  });

  final String asset;
  final bool isLeftColumn;
  final int row;

  /// Where the donut sits in the photo, so a portrait crop keeps it in view.
  final Alignment focus;
}

class _DonutTile extends StatelessWidget {
  const _DonutTile({required this.tile});

  final WelcomeTile tile;

  static const double _shadowBlur = 24;
  static const Offset _shadowOffset = Offset(0, 12);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: const [
          BoxShadow(
            color: AppColors.tileShadow,
            blurRadius: _shadowBlur,
            offset: _shadowOffset,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Image.asset(
          tile.asset,
          fit: BoxFit.cover,
          alignment: tile.focus,
          errorBuilder: (context, error, stackTrace) =>
              const ColoredBox(color: AppColors.pastelPink),
        ),
      ),
    );
  }
}
