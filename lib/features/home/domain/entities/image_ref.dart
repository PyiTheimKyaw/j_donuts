import 'package:equatable/equatable.dart';

/// Where an image comes from. [url] is either `asset://<path>` for a bundled
/// file or an https URL; [fallbackAsset] is the bundled copy shown when a
/// network image is neither reachable nor in the disk cache.
final class ImageRef extends Equatable {
  const ImageRef(this.url, {this.fallbackAsset});

  static const String assetScheme = 'asset://';

  final String url;
  final String? fallbackAsset;

  bool get isBundled => url.startsWith(assetScheme);

  String get assetPath => url.substring(assetScheme.length);

  @override
  List<Object?> get props => [url, fallbackAsset];
}
