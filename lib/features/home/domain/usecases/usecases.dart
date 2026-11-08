import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';
import 'package:j_donuts/features/home/domain/repositories/catalog_repository.dart';
import 'package:j_donuts/features/home/domain/repositories/member_repository.dart';

final class WatchBanners {
  const WatchBanners(this._repository);

  final CatalogRepository _repository;

  Stream<List<PromoBanner>> call() => _repository.watchBanners();
}

final class WatchHomeSections {
  const WatchHomeSections(this._repository);

  final CatalogRepository _repository;

  Stream<List<HomeSection>> call() => _repository.watchSections();
}

final class WatchShops {
  const WatchShops(this._repository);

  final CatalogRepository _repository;

  Stream<List<Shop>> call() => _repository.watchShops();
}

final class WatchProduct {
  const WatchProduct(this._repository);

  final CatalogRepository _repository;

  Stream<Product?> call(String id) => _repository.watchProduct(id);
}

final class RefreshCatalog {
  const RefreshCatalog(this._repository);

  final CatalogRepository _repository;

  FutureResult<DateTime> call() => _repository.refresh();
}

final class WatchMember {
  const WatchMember(this._repository);

  final MemberRepository _repository;

  Stream<Member?> call() => _repository.watchMember();
}
