import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/core/images/image_cache.dart';
import 'package:j_donuts/core/widgets/skeleton.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';

/// Resolution order for a network image: disk cache, then network, then the
/// bundled fallback, then an error tile. Offline after a refresh therefore
/// still shows a photo for every seeded item.
class AppImage extends StatelessWidget {
  const AppImage(
    this.image, {
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.semanticLabel,
    this.cacheManager,
    super.key,
  });

  final ImageRef image;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String? semanticLabel;

  /// Overridable for tests; defaults to [AppImageCache.manager].
  final BaseCacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    if (image.isBundled) return _asset(image.assetPath);

    return CachedNetworkImage(
      imageUrl: image.url,
      cacheManager: cacheManager ?? AppImageCache.manager,
      fit: fit,
      width: width,
      height: height,
      fadeInDuration: AppMotion.scaled(context, AppDurations.medium),
      placeholder: (context, url) => Skeleton(width: width, height: height),
      errorWidget: (context, url, error) {
        final fallback = image.fallbackAsset;
        return fallback == null ? const ImageErrorTile() : _asset(fallback);
      },
    );
  }

  Widget _asset(String path) => Image.asset(
    'assets/$path',
    fit: fit,
    width: width,
    height: height,
    semanticLabel: semanticLabel,
    errorBuilder: (context, error, stackTrace) => const ImageErrorTile(),
  );
}

class ImageErrorTile extends StatelessWidget {
  const ImageErrorTile({super.key});

  static const double _iconSize = 28;

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.surfaceMuted,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.inkTertiary,
          size: _iconSize,
        ),
      ),
    );
  }
}
