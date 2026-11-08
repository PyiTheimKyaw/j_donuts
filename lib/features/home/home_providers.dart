import 'package:flutter/services.dart';
import 'package:j_donuts/core/db/database_provider.dart';
import 'package:j_donuts/core/network/network_providers.dart';
import 'package:j_donuts/core/time/clock.dart';
import 'package:j_donuts/features/home/data/datasources/catalog_local_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/member_local_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/remote_catalog_data_source.dart';
import 'package:j_donuts/features/home/data/datasources/seed_loader.dart';
import 'package:j_donuts/features/home/data/repositories/catalog_repository_impl.dart';
import 'package:j_donuts/features/home/data/repositories/member_repository_impl.dart';
import 'package:j_donuts/features/home/domain/repositories/catalog_repository.dart';
import 'package:j_donuts/features/home/domain/repositories/member_repository.dart';
import 'package:j_donuts/features/home/domain/usecases/usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_providers.g.dart';

// Composition root: the only file binding catalogue interfaces to
// implementations. A Dio-backed remote replaces `remoteCatalogDataSource` here.

@Riverpod(keepAlive: true)
AssetLoader assetLoader(Ref ref) => rootBundle.loadString;

@Riverpod(keepAlive: true)
SeedLoader seedLoader(Ref ref) => SeedLoader(
  database: ref.watch(appDatabaseProvider),
  loadAsset: ref.watch(assetLoaderProvider),
);

@Riverpod(keepAlive: true)
RemoteCatalogDataSource remoteCatalogDataSource(Ref ref) =>
    AssetRemoteCatalogDataSource(
      loadAsset: ref.watch(assetLoaderProvider),
      isOnline: ref.watch(connectivityServiceProvider).isOnline,
    );

@Riverpod(keepAlive: true)
CatalogRepository catalogRepository(Ref ref) => CatalogRepositoryImpl(
  local: CatalogLocalDataSource(ref.watch(appDatabaseProvider)),
  remote: ref.watch(remoteCatalogDataSourceProvider),
  seed: ref.watch(seedLoaderProvider),
  clock: ref.watch(clockProvider),
);

@Riverpod(keepAlive: true)
MemberRepository memberRepository(Ref ref) => MemberRepositoryImpl(
  local: MemberLocalDataSource(ref.watch(appDatabaseProvider)),
  seed: ref.watch(seedLoaderProvider),
);

@riverpod
WatchBanners watchBanners(Ref ref) =>
    WatchBanners(ref.watch(catalogRepositoryProvider));

@riverpod
WatchHomeSections watchHomeSections(Ref ref) =>
    WatchHomeSections(ref.watch(catalogRepositoryProvider));

@riverpod
WatchShops watchShops(Ref ref) =>
    WatchShops(ref.watch(catalogRepositoryProvider));

@riverpod
WatchProduct watchProduct(Ref ref) =>
    WatchProduct(ref.watch(catalogRepositoryProvider));

@riverpod
RefreshCatalog refreshCatalog(Ref ref) =>
    RefreshCatalog(ref.watch(catalogRepositoryProvider));

@riverpod
WatchMember watchMember(Ref ref) =>
    WatchMember(ref.watch(memberRepositoryProvider));
