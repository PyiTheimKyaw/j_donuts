import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';

/// Shield with the tier's initial and one to three stars, as in the design.
class TierShield extends StatelessWidget {
  const TierShield({required this.tier, this.isCurrent = false, super.key});

  final LoyaltyTier tier;
  final bool isCurrent;

  static const double size = 40;
  static const double _topInset = size * 0.14;

  (Color, Color) get _colors => switch (tier) {
    LoyaltyTier.bronze => (AppColors.tierBronze, AppColors.tierBronze),
    LoyaltyTier.silver => (AppColors.tierSilver, AppColors.tierSilverShade),
    LoyaltyTier.gold => (AppColors.tierGold, AppColors.tierGoldShade),
    LoyaltyTier.platinum => (
      AppColors.tierPlatinum,
      AppColors.tierPlatinumShade,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final (fill, shade) = _colors;

    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _ShieldPainter(fill: fill, shade: shade, glow: isCurrent),
        child: Padding(
          padding: const EdgeInsets.only(top: _topInset),
          child: _ShieldLabel(tier: tier, color: shade),
        ),
      ),
    );
  }
}

class _ShieldLabel extends StatelessWidget {
  const _ShieldLabel({required this.tier, required this.color});

  final LoyaltyTier tier;
  final Color color;

  static const double _starSize = TierShield.size * 0.18;

  @override
  Widget build(BuildContext context) {
    final stars = math.max(1, tier.index);

    return Column(
      children: [
        Text(
          '★' * stars,
          style: AppTypography.caption.copyWith(
            color: color,
            fontSize: _starSize,
            height: 1,
          ),
        ),
        Text(
          tier.name[0].toUpperCase(),
          style: AppTypography.subtitle.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class _ShieldPainter extends CustomPainter {
  const _ShieldPainter({
    required this.fill,
    required this.shade,
    required this.glow,
  });

  final Color fill;
  final Color shade;
  final bool glow;

  static const Offset _glowOffset = Offset(0, 2);
  static const double _glowBlur = 4;
  static const double _glowAlpha = 0.4;
  static const double _highlightMix = 0.45;
  static const double _outlineWidth = 1.5;
  static const double _outlineAlpha = 0.6;

  @override
  void paint(Canvas canvas, Size size) {
    final shield = _shieldPath(size);
    if (glow) {
      canvas.drawPath(
        shield.shift(_glowOffset),
        Paint()
          ..color = shade.withValues(alpha: _glowAlpha)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, _glowBlur),
      );
    }
    canvas
      ..drawPath(
        shield,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.lerp(fill, AppColors.surface, _highlightMix)!, fill],
          ).createShader(Offset.zero & size),
      )
      ..drawPath(
        shield,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _outlineWidth
          ..color = shade.withValues(alpha: _outlineAlpha),
      );
  }

  /// Control points are fractions of the badge, traced from the design.
  Path _shieldPath(Size size) {
    final w = size.width;
    final h = size.height;
    return Path()
      ..moveTo(w * 0.5, 0)
      ..cubicTo(w * 0.72, h * 0.1, w * 0.88, h * 0.1, w, h * 0.12)
      ..lineTo(w, h * 0.5)
      ..cubicTo(w, h * 0.78, w * 0.72, h * 0.92, w * 0.5, h)
      ..cubicTo(w * 0.28, h * 0.92, 0, h * 0.78, 0, h * 0.5)
      ..lineTo(0, h * 0.12)
      ..cubicTo(w * 0.12, h * 0.1, w * 0.28, h * 0.1, w * 0.5, 0)
      ..close();
  }

  @override
  bool shouldRepaint(_ShieldPainter oldDelegate) =>
      oldDelegate.fill != fill ||
      oldDelegate.shade != shade ||
      oldDelegate.glow != glow;
}
