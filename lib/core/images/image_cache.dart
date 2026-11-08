import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// A dedicated disk cache, separate from the plugin's shared default, so its
/// size and lifetime are ours to choose and clearing it touches nothing else.
abstract final class AppImageCache {
  static const String key = 'jdonuts_images';
  static const Duration stalePeriod = Duration(days: 30);
  static const int maxObjects = 300;

  static final CacheManager manager = CacheManager(
    Config(key, stalePeriod: stalePeriod, maxNrOfCacheObjects: maxObjects),
  );
}
