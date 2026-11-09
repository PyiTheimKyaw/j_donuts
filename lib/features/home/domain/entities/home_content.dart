import 'package:equatable/equatable.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';
import 'package:j_donuts/features/home/domain/entities/product.dart';

/// Section titles are localised in the UI, so data carries only the kind.
enum SectionKind { seasonal, popular, orderAgain }

/// Visual treatment from data; the UI maps each to theme tokens.
enum BannerStyle { purple, cyan, orange }

final class PromoBanner extends Equatable {
  const PromoBanner({
    required this.id,
    required this.title,
    required this.image,
    required this.style,
    this.badge,
  });

  final String id;
  final String title;
  final ImageRef image;
  final BannerStyle style;
  final String? badge;

  @override
  List<Object?> get props => [id, title, image, style, badge];
}

/// A section with no products is kept so the UI can show its empty state.
final class HomeSection extends Equatable {
  const HomeSection({
    required this.id,
    required this.kind,
    required this.products,
  });

  final String id;
  final SectionKind kind;
  final List<Product> products;

  @override
  List<Object?> get props => [id, kind, products];
}

final class Shop extends Equatable {
  const Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
  });

  final String id;
  final String name;
  final String address;
  final ImageRef image;

  @override
  List<Object?> get props => [id, name, address, image];
}
