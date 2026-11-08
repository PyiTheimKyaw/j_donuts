// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => _ProductDto(
  id: json['id'] as String,
  code: json['code'] as String,
  name: json['name'] as String,
  priceMmk: (json['priceMmk'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
  description: json['description'] as String,
  isNew: json['isNew'] as bool? ?? false,
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductDtoToJson(_ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'priceMmk': instance.priceMmk,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'isNew': instance.isNew,
      'discountPercent': instance.discountPercent,
    };

_BannerDto _$BannerDtoFromJson(Map<String, dynamic> json) => _BannerDto(
  id: json['id'] as String,
  title: json['title'] as String,
  style: json['style'] as String,
  imageUrl: json['imageUrl'] as String,
  badge: json['badge'] as String?,
);

Map<String, dynamic> _$BannerDtoToJson(_BannerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'style': instance.style,
      'imageUrl': instance.imageUrl,
      'badge': instance.badge,
    };

_SectionDto _$SectionDtoFromJson(Map<String, dynamic> json) => _SectionDto(
  id: json['id'] as String,
  kind: json['kind'] as String,
  productIds: (json['productIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SectionDtoToJson(_SectionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'productIds': instance.productIds,
    };

_ShopDto _$ShopDtoFromJson(Map<String, dynamic> json) => _ShopDto(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$ShopDtoToJson(_ShopDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'imageUrl': instance.imageUrl,
};

_CatalogPayloadDto _$CatalogPayloadDtoFromJson(Map<String, dynamic> json) =>
    _CatalogPayloadDto(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      banners: (json['banners'] as List<dynamic>)
          .map((e) => BannerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      sections: (json['sections'] as List<dynamic>)
          .map((e) => SectionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      shops: (json['shops'] as List<dynamic>)
          .map((e) => ShopDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CatalogPayloadDtoToJson(_CatalogPayloadDto instance) =>
    <String, dynamic>{
      'products': instance.products,
      'banners': instance.banners,
      'sections': instance.sections,
      'shops': instance.shops,
    };

_MemberDto _$MemberDtoFromJson(Map<String, dynamic> json) => _MemberDto(
  id: json['id'] as String,
  name: json['name'] as String,
  photoUrl: json['photoUrl'] as String,
  tier: json['tier'] as String,
  totalPoints: (json['totalPoints'] as num).toInt(),
  pointsToNextTier: (json['pointsToNextTier'] as num).toInt(),
  notificationCount: (json['notificationCount'] as num).toInt(),
  rewardCount: (json['rewardCount'] as num).toInt(),
);

Map<String, dynamic> _$MemberDtoToJson(_MemberDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'tier': instance.tier,
      'totalPoints': instance.totalPoints,
      'pointsToNextTier': instance.pointsToNextTier,
      'notificationCount': instance.notificationCount,
      'rewardCount': instance.rewardCount,
    };

_ChallengeDto _$ChallengeDtoFromJson(Map<String, dynamic> json) =>
    _ChallengeDto(
      id: json['id'] as String,
      title: json['title'] as String,
      artwork: json['artwork'] as String,
      imageUrl: json['imageUrl'] as String,
      progress: (json['progress'] as num).toInt(),
      goal: (json['goal'] as num).toInt(),
      rewardPoints: (json['rewardPoints'] as num).toInt(),
      tab: json['tab'] as String,
    );

Map<String, dynamic> _$ChallengeDtoToJson(_ChallengeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artwork': instance.artwork,
      'imageUrl': instance.imageUrl,
      'progress': instance.progress,
      'goal': instance.goal,
      'rewardPoints': instance.rewardPoints,
      'tab': instance.tab,
    };

_SeedDto _$SeedDtoFromJson(Map<String, dynamic> json) => _SeedDto(
  version: (json['version'] as num).toInt(),
  catalog: CatalogPayloadDto.fromJson(json['catalog'] as Map<String, dynamic>),
  member: MemberDto.fromJson(json['member'] as Map<String, dynamic>),
  challenges: (json['challenges'] as List<dynamic>)
      .map((e) => ChallengeDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SeedDtoToJson(_SeedDto instance) => <String, dynamic>{
  'version': instance.version,
  'catalog': instance.catalog,
  'member': instance.member,
  'challenges': instance.challenges,
};

_ApiErrorDto _$ApiErrorDtoFromJson(Map<String, dynamic> json) => _ApiErrorDto(
  code: json['code'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$ApiErrorDtoToJson(_ApiErrorDto instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};

_ApiMetaDto _$ApiMetaDtoFromJson(Map<String, dynamic> json) => _ApiMetaDto(
  version: (json['version'] as num).toInt(),
  generatedAt: json['generatedAt'] as String?,
);

Map<String, dynamic> _$ApiMetaDtoToJson(_ApiMetaDto instance) =>
    <String, dynamic>{
      'version': instance.version,
      'generatedAt': instance.generatedAt,
    };

_ApiEnvelope<T> _$ApiEnvelopeFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _ApiEnvelope<T>(
  meta: ApiMetaDto.fromJson(json['meta'] as Map<String, dynamic>),
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  error: json['error'] == null
      ? null
      : ApiErrorDto.fromJson(json['error'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ApiEnvelopeToJson<T>(
  _ApiEnvelope<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'meta': instance.meta,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'error': instance.error,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
