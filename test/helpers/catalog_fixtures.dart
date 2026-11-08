import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/home/data/datasources/catalog_local_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/remote_catalog_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/seed_loader.dart';
import 'package:j_donuts/features/home/data/dto/catalog_dto.dart';
import 'package:j_donuts/features/home/data/repositories/catalog_repository_impl.dart';

final String seedFixture = File('test/fixtures/seed_v1.json')
    .readAsStringSync();

final String remoteFixture = File('test/fixtures/remote_catalog_v1.json')
    .readAsStringSync();

Map<String, dynamic> decodeFixture(String raw) =>
    jsonDecode(raw) as Map<String, dynamic>;

CatalogPayloadDto remotePayload() => CatalogPayloadDto.fromJson(
  decodeFixture(remoteFixture)['data'] as Map<String, dynamic>,
);

/// Serves a [SeedLoader.seedAsset] request with the given seed JSON.
AssetLoader seedAssetLoader([String? seed]) =>
    (key) async => seed ?? seedFixture;

/// Remote double whose answer the test controls per call.
class FakeRemoteCatalog implements RemoteCatalogDataSource {
  FakeRemoteCatalog([CatalogPayloadDto? payload])
    : payload = payload ?? remotePayload();

  CatalogPayloadDto payload;
  Failure? failure;
  int calls = 0;

  @override
  Future<CatalogPayloadDto> fetchCatalog() async {
    calls++;
    final failure = this.failure;
    if (failure != null) throw failure;
    return payload;
  }
}

class CatalogHarness {
  CatalogHarness({FakeRemoteCatalog? remote, DateTime? now})
    : database = AppDatabase(NativeDatabase.memory()),
      remote = remote ?? FakeRemoteCatalog(),
      now = now ?? DateTime(2026, 11, 8, 9) {
    seed = SeedLoader(database: database, loadAsset: seedAssetLoader());
    repository = CatalogRepositoryImpl(
      local: CatalogLocalDataSource(database),
      remote: this.remote,
      seed: seed,
      clock: () => this.now,
    );
  }

  final AppDatabase database;
  final FakeRemoteCatalog remote;
  DateTime now;
  late final SeedLoader seed;
  late final CatalogRepositoryImpl repository;

  Future<void> dispose() => database.close();
}
