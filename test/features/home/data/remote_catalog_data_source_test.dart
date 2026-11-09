import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/home/data/datasources/remote_catalog_data_source.dart';

import '../../../helpers/catalog_fixtures.dart';

void main() {
  AssetRemoteCatalogDataSource source({String? body, bool online = true}) =>
      AssetRemoteCatalogDataSource(
        loadAsset: (key) async => body ?? remoteFixture,
        isOnline: () async => online,
        latency: Duration.zero,
      );

  group('AssetRemoteCatalogDataSource', () {
    test('unwraps the data of a /v1 envelope', () async {
      final payload = await source().fetchCatalog();

      expect(payload.products, hasLength(9));
      expect(payload.shops, hasLength(4));
    });

    test('refuses to answer while offline', () async {
      await expectLater(
        source(online: false).fetchCatalog(),
        throwsA(isA<NetworkFailure>()),
      );
    });

    test('turns an envelope error into a NetworkFailure', () async {
      final body = jsonEncode({
        'data': null,
        'error': {'code': 'unavailable', 'message': 'Try later'},
        'meta': {'version': 2},
      });

      await expectLater(
        source(body: body).fetchCatalog(),
        throwsA(
          isA<NetworkFailure>().having(
            (f) => f.message,
            'message',
            'Try later',
          ),
        ),
      );
    });

    test('turns malformed JSON into an UnexpectedFailure', () async {
      await expectLater(
        source(body: '{not json').fetchCatalog(),
        throwsA(isA<UnexpectedFailure>()),
      );
    });

    test('turns a wrong shape into an UnexpectedFailure', () async {
      final body = jsonEncode({
        'data': {'products': 'oops'},
        'meta': {'version': 2},
      });

      await expectLater(
        source(body: body).fetchCatalog(),
        throwsA(isA<UnexpectedFailure>()),
      );
    });
  });
}
