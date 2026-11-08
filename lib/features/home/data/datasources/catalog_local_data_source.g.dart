// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_local_data_source.dart';

// ignore_for_file: type=lint
mixin _$CatalogLocalDataSourceMixin on DatabaseAccessor<AppDatabase> {
  $ProductsTable get products => attachedDatabase.products;
  $BannersTable get banners => attachedDatabase.banners;
  $SectionsTable get sections => attachedDatabase.sections;
  $SectionProductsTable get sectionProducts => attachedDatabase.sectionProducts;
  $ShopsTable get shops => attachedDatabase.shops;
  $SyncMetaTable get syncMeta => attachedDatabase.syncMeta;
  CatalogLocalDataSourceManager get managers =>
      CatalogLocalDataSourceManager(this);
}

class CatalogLocalDataSourceManager {
  final _$CatalogLocalDataSourceMixin _db;
  CatalogLocalDataSourceManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$BannersTableTableManager get banners =>
      $$BannersTableTableManager(_db.attachedDatabase, _db.banners);
  $$SectionsTableTableManager get sections =>
      $$SectionsTableTableManager(_db.attachedDatabase, _db.sections);
  $$SectionProductsTableTableManager get sectionProducts =>
      $$SectionProductsTableTableManager(
        _db.attachedDatabase,
        _db.sectionProducts,
      );
  $$ShopsTableTableManager get shops =>
      $$ShopsTableTableManager(_db.attachedDatabase, _db.shops);
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db.attachedDatabase, _db.syncMeta);
}
