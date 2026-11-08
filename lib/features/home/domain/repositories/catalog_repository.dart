import 'package:j_donuts/core/result/result.dart';
import 'package:j_donuts/features/home/domain/entities/home_content.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';

/// Watch methods read only the local database, which is the single source of
/// truth; [refresh] is the only path that touches the network, and it writes
/// into the database rather than returning data to the caller.
abstract interface class CatalogRepository {
  Stream<List<PromoBanner>> watchBanners();

  Stream<List<HomeSection>> watchSections();

  Stream<List<Shop>> watchShops();

  /// Emits `null` when no product has [id].
  Stream<Product?> watchProduct(String id);

  /// Fails with `NetworkFailure` when offline; cached data is left untouched.
  FutureResult<DateTime> refresh();

  Future<DateTime?> lastSyncedAt();
}
