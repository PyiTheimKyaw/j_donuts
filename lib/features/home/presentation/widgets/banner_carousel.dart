import 'dart:async';

import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/app_image.dart';
import 'package:j_donuts/core/widgets/skeleton.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';

/// Auto-plays, but pauses while the user is touching it and does not move at
/// all under Reduce Motion, where an unprompted slide is unwanted motion.
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({required this.banners, super.key});

  final List<PromoBanner> banners;

  static const double height = 180;
  static const double viewportFraction = 0.86;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController(
    viewportFraction: BannerCarousel.viewportFraction,
  );
  Timer? _autoPlay;
  int _page = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _restartAutoPlay();
  }

  @override
  void dispose() {
    _autoPlay?.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// A plain [Timer] ignores [TickerMode], so it is checked explicitly: the
  /// carousel stops while its tab is in the background instead of animating
  /// pages nobody can see.
  void _restartAutoPlay() {
    _autoPlay?.cancel();
    final isVisible = TickerMode.valuesOf(context).enabled;
    if (!isVisible || AppMotion.reduceMotion(context)) return;
    if (widget.banners.length < 2) return;
    _autoPlay = Timer.periodic(AppDurations.bannerAutoPlay, (_) => _advance());
  }

  void _advance() {
    if (!_controller.hasClients) return;
    final next = (_page + 1) % widget.banners.length;
    _controller.animateToPage(
      next,
      duration: AppDurations.slow,
      curve: AppCurves.emphasized,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: BannerCarousel.height,
          child: Listener(
            onPointerDown: (_) => _autoPlay?.cancel(),
            onPointerUp: (_) => _restartAutoPlay(),
            child: PageView.builder(
              controller: _controller,
              padEnds: false,
              itemCount: widget.banners.length,
              onPageChanged: (page) => setState(() => _page = page),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? AppSpacing.gutter : AppSpacing.sm,
                  right: AppSpacing.sm,
                ),
                child: _BannerCard(banner: widget.banners[index]),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _PageDots(count: widget.banners.length, current: _page),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner});

  final PromoBanner banner;

  Color get _background => switch (banner.style) {
    BannerStyle.purple => AppColors.purple,
    BannerStyle.cyan => AppColors.primary,
    BannerStyle.orange => AppColors.warning,
  };

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      child: ColoredBox(
        color: _background,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _BannerImage(image: banner.image),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: _BannerText(banner: banner),
            ),
          ],
        ),
      ),
    );
  }
}

class _BannerImage extends StatelessWidget {
  const _BannerImage({required this.image});

  final ImageRef image;

  static const double _widthFraction = 0.7;
  static const double _heightFraction = 0.5;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: _widthFraction,
        heightFactor: _heightFraction,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadii.lg),
          ),
          child: AppImage(image),
        ),
      ),
    );
  }
}

class _BannerText extends StatelessWidget {
  const _BannerText({required this.banner});

  final PromoBanner banner;

  @override
  Widget build(BuildContext context) {
    final badge = banner.badge;

    return Column(
      children: [
        if (badge != null) _Badge(text: badge),
        const SizedBox(height: AppSpacing.sm),
        Text(
          banner.title,
          style: AppTypography.title.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.onPrimary),
      ),
      child: Text(
        text,
        style: AppTypography.caption.copyWith(color: AppColors.onPrimary),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  static const double _dotSize = 6;
  static const double _activeWidth = 18;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < count; index++)
          AnimatedContainer(
            duration: AppMotion.scaled(context, AppDurations.medium),
            curve: AppCurves.standard,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            width: index == current ? _activeWidth : _dotSize,
            height: _dotSize,
            decoration: BoxDecoration(
              color: index == current ? AppColors.accent : AppColors.divider,
              borderRadius: BorderRadius.circular(AppRadii.pill),
            ),
          ),
      ],
    );
  }
}

class BannerCarouselSkeleton extends StatelessWidget {
  const BannerCarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      child: Skeleton(height: BannerCarousel.height, radius: AppRadii.xl),
    );
  }
}
