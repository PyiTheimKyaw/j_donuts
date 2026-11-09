import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_dto.freezed.dart';
part 'catalog_dto.g.dart';

@freezed
abstract class ProductDto with _$ProductDto {
  const factory ProductDto({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    required String imageUrl,
    required String description,
    @Default(false) bool isNew,
    int? discountPercent,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
}

@freezed
abstract class BannerDto with _$BannerDto {
  const factory BannerDto({
    required String id,
    required String title,
    required String style,
    required String imageUrl,
    String? badge,
  }) = _BannerDto;

  factory BannerDto.fromJson(Map<String, dynamic> json) =>
      _$BannerDtoFromJson(json);
}

@freezed
abstract class SectionDto with _$SectionDto {
  const factory SectionDto({
    required String id,
    required String kind,
    required List<String> productIds,
  }) = _SectionDto;

  factory SectionDto.fromJson(Map<String, dynamic> json) =>
      _$SectionDtoFromJson(json);
}

@freezed
abstract class ShopDto with _$ShopDto {
  const factory ShopDto({
    required String id,
    required String name,
    required String address,
    required String imageUrl,
  }) = _ShopDto;

  factory ShopDto.fromJson(Map<String, dynamic> json) =>
      _$ShopDtoFromJson(json);
}

/// The public catalogue: what a server would serve to every member.
@freezed
abstract class CatalogPayloadDto with _$CatalogPayloadDto {
  const factory CatalogPayloadDto({
    required List<ProductDto> products,
    required List<BannerDto> banners,
    required List<SectionDto> sections,
    required List<ShopDto> shops,
  }) = _CatalogPayloadDto;

  factory CatalogPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$CatalogPayloadDtoFromJson(json);
}

@freezed
abstract class MemberDto with _$MemberDto {
  const factory MemberDto({
    required String id,
    required String name,
    required String photoUrl,
    required String tier,
    required int totalPoints,
    required int pointsToNextTier,
    required int notificationCount,
    required int rewardCount,
    @Default(0) int tierStartPoints,
  }) = _MemberDto;

  factory MemberDto.fromJson(Map<String, dynamic> json) =>
      _$MemberDtoFromJson(json);
}

@freezed
abstract class ChallengeDto with _$ChallengeDto {
  const factory ChallengeDto({
    required String id,
    required String title,
    required String artwork,
    required String imageUrl,
    required int progress,
    required int goal,
    required int rewardPoints,
    required String tab,
  }) = _ChallengeDto;

  factory ChallengeDto.fromJson(Map<String, dynamic> json) =>
      _$ChallengeDtoFromJson(json);
}

/// Bundled first-launch data. Member and challenges are private to the user,
/// so unlike the catalogue they are never refreshed from the remote source.
@freezed
abstract class SeedDto with _$SeedDto {
  const factory SeedDto({
    required int version,
    required CatalogPayloadDto catalog,
    required MemberDto member,
    required List<ChallengeDto> challenges,
  }) = _SeedDto;

  factory SeedDto.fromJson(Map<String, dynamic> json) =>
      _$SeedDtoFromJson(json);
}

@freezed
abstract class ApiErrorDto with _$ApiErrorDto {
  const factory ApiErrorDto({required String code, required String message}) =
      _ApiErrorDto;

  factory ApiErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorDtoFromJson(json);
}

@freezed
abstract class ApiMetaDto with _$ApiMetaDto {
  const factory ApiMetaDto({required int version, String? generatedAt}) =
      _ApiMetaDto;

  factory ApiMetaDto.fromJson(Map<String, dynamic> json) =>
      _$ApiMetaDtoFromJson(json);
}

/// `{data, error, meta}` envelope used by every `/v1` response.
@Freezed(genericArgumentFactories: true)
abstract class ApiEnvelope<T> with _$ApiEnvelope<T> {
  const factory ApiEnvelope({
    required ApiMetaDto meta,
    T? data,
    ApiErrorDto? error,
  }) = _ApiEnvelope<T>;

  factory ApiEnvelope.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiEnvelopeFromJson(json, fromJsonT);
}
