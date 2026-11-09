import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';

import '../../../helpers/catalog_fixtures.dart';

void main() {
  late CatalogHarness harness;

  setUp(() => harness = CatalogHarness());
  tearDown(() => harness.dispose());

  group('CatalogRepository reads (offline-first)', () {
    test(
      'serves seeded sections in order with products in position order',
      () async {
        final sections = await harness.repository.watchSections().first;

        expect(sections.map((s) => s.kind), [
          SectionKind.seasonal,
          SectionKind.popular,
          SectionKind.orderAgain,
        ]);
        expect(sections[1].products.map((p) => p.id), [
          'p_strawberry_choc',
          'p_dalgona',
          'p_coconut',
          'p_glazed',
        ]);
      },
    );

    test('maps the reference product exactly', () async {
      final coconut = await harness.repository.watchProduct('p_coconut').first;

      expect(coconut?.code, 'JD022123');
      expect(coconut?.name, 'Coconut Donut');
      expect(coconut?.priceMmk, 3200);
      expect(coconut?.isNew, isTrue);
      expect(coconut?.image.isBundled, isTrue);
    });

    test('emits null for an unknown product', () async {
      expect(await harness.repository.watchProduct('nope').first, isNull);
    });

    test('serves banners and shops in seed order', () async {
      final banners = await harness.repository.watchBanners().first;
      final shops = await harness.repository.watchShops().first;

      expect(banners.first.style, BannerStyle.purple);
      expect(banners.first.badge, 'New shop');
      expect(shops, hasLength(4));
    });

    test('never calls the network to read', () async {
      await harness.repository.watchSections().first;
      await harness.repository.watchShops().first;

      expect(harness.remote.calls, 0);
    });
  });

  group('CatalogRepository.refresh', () {
    test(
      'writes remote data into the database and records the sync time',
      () async {
        final result = await harness.repository.refresh();

        expect(result.valueOrNull, harness.now);
        expect(await harness.repository.lastSyncedAt(), harness.now);
        final coconut = await harness.repository
            .watchProduct('p_coconut')
            .first;
        expect(coconut?.image.url, startsWith('https://'));
      },
    );

    test('keeps the bundled image as fallback after a remote update', () async {
      await harness.repository.refresh();

      final coconut = await harness.repository.watchProduct('p_coconut').first;
      expect(coconut?.image.fallbackAsset, 'images/products/coconut_donut.jpg');
    });

    test('pushes changes to existing watchers', () async {
      final updates = harness.repository.watchProduct('p_coconut');
      final emitted = expectLater(
        updates.map((p) => p?.image.isBundled),
        emitsInOrder([true, false]),
      );

      await Future<void>.delayed(Duration.zero);
      await harness.repository.refresh();

      await emitted;
    });

    test('offline: returns NetworkFailure and keeps cached data', () async {
      harness.remote.failure = const NetworkFailure(message: 'offline');

      final result = await harness.repository.refresh();

      expect(result.failureOrNull, isA<NetworkFailure>());
      expect(await harness.repository.watchSections().first, hasLength(3));
      expect(await harness.repository.lastSyncedAt(), isNull);
    });

    test('removes products the server no longer lists', () async {
      final payload = remotePayload();
      harness.remote.payload = payload.copyWith(
        products: payload.products.where((p) => p.id != 'p_glazed').toList(),
        sections: [
          for (final s in payload.sections)
            s.copyWith(
              productIds: s.productIds.where((id) => id != 'p_glazed').toList(),
            ),
        ],
      );

      await harness.repository.refresh();

      expect(await harness.repository.watchProduct('p_glazed').first, isNull);
    });

    test('keeps a section that has no products so it can show empty', () async {
      final payload = remotePayload();
      harness.remote.payload = payload.copyWith(
        sections: [
          for (final s in payload.sections)
            if (s.kind == 'orderAgain') s.copyWith(productIds: []) else s,
        ],
      );

      await harness.repository.refresh();

      final sections = await harness.repository.watchSections().first;
      final orderAgain = sections.singleWhere(
        (s) => s.kind == SectionKind.orderAgain,
      );
      expect(orderAgain.products, isEmpty);
    });
  });
}
