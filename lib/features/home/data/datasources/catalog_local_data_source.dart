import 'package:drift/drift.dart';
import 'package:j_donuts/core/db/app_database.dart';
import 'package:j_donuts/core/db/tables/catalog_tables.dart';
import 'package:j_donuts/features/home/data/dto/catalog_dto.dart';
import 'package:j_donuts/features/home/data/mappers/catalog_mapper.dart';

part 'catalog_local_data_source.g.dart';

typedef SectionWithProduct = ({SectionRow section, ProductRow? product});

@DriftAccessor(
  tables: [Products, Banners, Sections, SectionProducts, Shops, SyncMeta],
)
class CatalogLocalDataSource extends DatabaseAccessor<AppDatabase>
    with _$CatalogLocalDataSourceMixin {
  CatalogLocalDataSource(super.attachedDatabase);

  static const String seedVersionKey = 'seed_version';
  static const String lastSyncedKey = 'catalog_last_synced';

  Stream<List<BannerRow>> watchBanners() => (select(
    banners,
  )..orderBy([(row) => OrderingTerm.asc(row.sortOrder)])).watch();

  Stream<List<ShopRow>> watchShops() => (select(
    shops,
  )..orderBy([(row) => OrderingTerm.asc(row.sortOrder)])).watch();

  Stream<ProductRow?> watchProduct(String id) =>
      (select(products)..where((row) => row.id.equals(id))).watchSingleOrNull();

  /// Left joins keep a section that has no products, so its empty state can
  /// render instead of the whole section vanishing.
  Stream<List<SectionWithProduct>> watchSectionProducts() {
    final query =
        select(sections).join([
          leftOuterJoin(
            sectionProducts,
            sectionProducts.sectionId.equalsExp(sections.id),
          ),
          leftOuterJoin(
            products,
            products.id.equalsExp(sectionProducts.productId),
          ),
        ])..orderBy([
          OrderingTerm.asc(sections.sortOrder),
          OrderingTerm.asc(sectionProducts.position),
        ]);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          (
            section: row.readTable(sections),
            product: row.readTableOrNull(products),
          ),
      ],
    );
  }

  /// Mirrors [payload] exactly: rows missing from it are deleted, the rest are
  /// upserted. Remote writes leave `assetFallback` untouched.
  Future<void> replaceCatalog(
    CatalogPayloadDto payload, {
    required bool fromSeed,
  }) => transaction(() async {
    await _replaceProducts(payload.products, fromSeed: fromSeed);
    await _replaceBanners(payload.banners, fromSeed: fromSeed);
    await _replaceShops(payload.shops, fromSeed: fromSeed);
    await _replaceSections(payload.sections);
  });

  Future<void> _replaceProducts(
    List<ProductDto> items, {
    required bool fromSeed,
  }) async {
    await (delete(
      products,
    )..where((row) => row.id.isNotIn(items.map((p) => p.id)))).go();
    await batch(
      (batch) => batch.insertAllOnConflictUpdate(products, [
        for (final item in items)
          CatalogMapper.productCompanion(item, fromSeed: fromSeed),
      ]),
    );
  }

  Future<void> _replaceBanners(
    List<BannerDto> items, {
    required bool fromSeed,
  }) async {
    await (delete(
      banners,
    )..where((row) => row.id.isNotIn(items.map((b) => b.id)))).go();
    await batch(
      (batch) => batch.insertAllOnConflictUpdate(banners, [
        for (final (index, item) in items.indexed)
          CatalogMapper.bannerCompanion(item, index, fromSeed: fromSeed),
      ]),
    );
  }

  Future<void> _replaceShops(
    List<ShopDto> items, {
    required bool fromSeed,
  }) async {
    await (delete(
      shops,
    )..where((row) => row.id.isNotIn(items.map((s) => s.id)))).go();
    await batch(
      (batch) => batch.insertAllOnConflictUpdate(shops, [
        for (final (index, item) in items.indexed)
          CatalogMapper.shopCompanion(item, index, fromSeed: fromSeed),
      ]),
    );
  }

  Future<void> _replaceSections(List<SectionDto> items) async {
    await delete(sectionProducts).go();
    await (delete(
      sections,
    )..where((row) => row.id.isNotIn(items.map((s) => s.id)))).go();
    await batch((batch) {
      for (final (index, section) in items.indexed) {
        batch.insert(
          sections,
          SectionsCompanion.insert(
            id: section.id,
            kind: section.kind,
            sortOrder: index,
          ),
          mode: InsertMode.insertOrReplace,
        );
        for (final (position, productId) in section.productIds.indexed) {
          batch.insert(
            sectionProducts,
            SectionProductsCompanion.insert(
              sectionId: section.id,
              productId: productId,
              position: position,
            ),
          );
        }
      }
    });
  }

  Future<String?> readMeta(String key) async => (await (select(
    syncMeta,
  )..where((row) => row.key.equals(key))).getSingleOrNull())?.value;

  Future<void> writeMeta(String key, String value) => into(syncMeta)
      .insertOnConflictUpdate(SyncMetaCompanion.insert(key: key, value: value));
}
