import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/core/time/clock.dart';
import 'package:j_donuts/features/home/data/datasources/catalog_local_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/remote_catalog_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/seed_loader.dart';
import 'package:j_donuts/features/home/data/mappers/catalog_mapper.dart';
import 'package:j_donuts/features/home/data/repositories/seeded_stream.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';
import 'package:j_donuts/features/home/domain/repositories/catalog_repository.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({
    required this._local,
    required this._remote,
    required this._seed,
    required this._clock,
  });

  final CatalogLocalDataSource _local;
  final RemoteCatalogDataSource _remote;
  final SeedLoader _seed;
  final Clock _clock;

  @override
  Stream<List<PromoBanner>> watchBanners() => seededStream(
    _seed,
    () => _local.watchBanners().map(
      (rows) => rows.map(CatalogMapper.banner).toList(),
    ),
  );

  @override
  Stream<List<Shop>> watchShops() => seededStream(
    _seed,
    () => _local.watchShops().map(
      (rows) => rows.map(CatalogMapper.shop).toList(),
    ),
  );

  @override
  Stream<Product?> watchProduct(String id) => seededStream(
    _seed,
    () => _local
        .watchProduct(id)
        .map((row) => row == null ? null : CatalogMapper.product(row)),
  );

  @override
  Stream<List<HomeSection>> watchSections() => seededStream(
    _seed,
    () => _local.watchSectionProducts().map(_groupBySection),
  );

  @override
  FutureResult<DateTime> refresh() async {
    try {
      await _seed.ensureSeeded();
      final payload = await _remote.fetchCatalog();
      await _local.replaceCatalog(payload, fromSeed: false);
      final syncedAt = _clock();
      await _local.writeMeta(
        CatalogLocalDataSource.lastSyncedKey,
        syncedAt.toUtc().toIso8601String(),
      );
      return Result.success(syncedAt);
    } on Failure catch (failure) {
      return Result.failure(failure);
    } on Exception catch (error) {
      return Result.failure(StorageFailure(message: '$error'));
    }
  }

  @override
  Future<DateTime?> lastSyncedAt() async {
    final stored = await _local.readMeta(CatalogLocalDataSource.lastSyncedKey);
    return stored == null ? null : DateTime.tryParse(stored)?.toLocal();
  }

  static List<HomeSection> _groupBySection(List<SectionWithProduct> rows) {
    // Map literals preserve insertion order, which is the section order.
    final grouped = <String, (SectionRow, List<Product>)>{};
    for (final (:section, :product) in rows) {
      final entry = grouped.putIfAbsent(section.id, () => (section, []));
      if (product != null) entry.$2.add(CatalogMapper.product(product));
    }
    return [
      for (final (section, products) in grouped.values)
        HomeSection(
          id: section.id,
          kind: CatalogMapper.sectionKind(section.kind),
          products: List.unmodifiable(products),
        ),
    ];
  }
}
