import 'package:equatable/equatable.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';

final class Product extends Equatable {
  const Product({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.image,
    required this.description,
    this.isNew = false,
    this.discountPercent,
  });

  final String id;
  final String code;
  final String name;

  /// Whole kyat; MMK has no minor unit in everyday pricing.
  final int priceMmk;
  final ImageRef image;
  final String description;
  final bool isNew;
  final int? discountPercent;

  bool get hasDiscount => (discountPercent ?? 0) > 0;

  @override
  List<Object?> get props => [
    id,
    code,
    name,
    priceMmk,
    image,
    description,
    isNew,
    discountPercent,
  ];
}
