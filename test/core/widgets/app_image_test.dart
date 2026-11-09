import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/widgets/app_image.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';
import 'package:mocktail/mocktail.dart';

class _UnreachableCache extends Mock implements BaseCacheManager;

void main() {
  late _UnreachableCache cache;

  setUp(() {
    cache = _UnreachableCache();
    when(
      () => cache.getFileStream(
        any(),
        key: any(named: 'key'),
        headers: any(named: 'headers'),
        withProgress: any(named: 'withProgress'),
      ),
    ).thenAnswer((_) => Stream.error(const HttpExceptionWithStatus(503, '')));
  });

  Future<void> pump(WidgetTester tester, ImageRef image) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox.square(
          dimension: 100,
          child: AppImage(image, cacheManager: cache),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  AssetImage? shownAsset(WidgetTester tester) {
    final images = tester.widgetList<Image>(find.byType(Image));
    for (final image in images) {
      final provider = image.image;
      if (provider is AssetImage) return provider;
    }
    return null;
  }

  group('AppImage', () {
    testWidgets('loads a bundled image straight from assets', (tester) async {
      await pump(tester, const ImageRef('asset://images/products/x.jpg'));

      expect(find.byType(CachedNetworkImage), findsNothing);
      expect(shownAsset(tester)?.assetName, 'assets/images/products/x.jpg');
    });

    testWidgets('falls back to the bundled copy when the network fails', (
      tester,
    ) async {
      await pump(
        tester,
        const ImageRef(
          'https://cdn.example/x.jpg',
          fallbackAsset: 'images/products/x.jpg',
        ),
      );

      expect(shownAsset(tester)?.assetName, 'assets/images/products/x.jpg');
    });

    testWidgets('shows the error tile when there is no fallback', (
      tester,
    ) async {
      await pump(tester, const ImageRef('https://cdn.example/x.jpg'));

      expect(find.byType(ImageErrorTile), findsOneWidget);
    });
  });
}
