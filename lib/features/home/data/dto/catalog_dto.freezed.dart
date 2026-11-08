// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductDto {

 String get id; String get code; String get name; int get priceMmk; String get imageUrl; String get description; bool get isNew; int? get discountPercent;
/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDtoCopyWith<ProductDto> get copyWith => _$ProductDtoCopyWithImpl<ProductDto>(this as ProductDto, _$identity);

  /// Serializes this ProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProductDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.priceMmk, _this.priceMmk) || other.priceMmk == _this.priceMmk)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.isNew, _this.isNew) || other.isNew == _this.isNew)&&(identical(other.discountPercent, _this.discountPercent) || other.discountPercent == _this.discountPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProductDto;
  return Object.hash(runtimeType,_this.id,_this.code,_this.name,_this.priceMmk,_this.imageUrl,_this.description,_this.isNew,_this.discountPercent);
}

@override
String toString() {
  final _this = this as ProductDto;
  return 'ProductDto(id: ${_this.id}, code: ${_this.code}, name: ${_this.name}, priceMmk: ${_this.priceMmk}, imageUrl: ${_this.imageUrl}, description: ${_this.description}, isNew: ${_this.isNew}, discountPercent: ${_this.discountPercent})';
}


}

/// @nodoc
abstract mixin class $ProductDtoCopyWith<$Res>  {
  factory $ProductDtoCopyWith(ProductDto value, $Res Function(ProductDto) _then) = _$ProductDtoCopyWithImpl;
@useResult
$Res call({
 String id, String code, String name, int priceMmk, String imageUrl, String description, bool isNew, int? discountPercent
});




}
/// @nodoc
class _$ProductDtoCopyWithImpl<$Res>
    implements $ProductDtoCopyWith<$Res> {
  _$ProductDtoCopyWithImpl(this._self, this._then);

  final ProductDto _self;
  final $Res Function(ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? priceMmk = null,Object? imageUrl = null,Object? description = null,Object? isNew = null,Object? discountPercent = freezed,}) {
  return _then(ProductDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceMmk: null == priceMmk ? _self.priceMmk : priceMmk // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDto].
extension ProductDtoPatterns on ProductDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String name,  int priceMmk,  String imageUrl,  String description,  bool isNew,  int? discountPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.priceMmk,_that.imageUrl,_that.description,_that.isNew,_that.discountPercent);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String name,  int priceMmk,  String imageUrl,  String description,  bool isNew,  int? discountPercent)  $default,) {final _that = this;
switch (_that) {
case _ProductDto():
return $default(_that.id,_that.code,_that.name,_that.priceMmk,_that.imageUrl,_that.description,_that.isNew,_that.discountPercent);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String name,  int priceMmk,  String imageUrl,  String description,  bool isNew,  int? discountPercent)?  $default,) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.priceMmk,_that.imageUrl,_that.description,_that.isNew,_that.discountPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDto implements ProductDto {
  const _ProductDto({required this.id, required this.code, required this.name, required this.priceMmk, required this.imageUrl, required this.description, this.isNew = false, this.discountPercent});
  factory _ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);

@override final  String id;
@override final  String code;
@override final  String name;
@override final  int priceMmk;
@override final  String imageUrl;
@override final  String description;
@override@JsonKey() final  bool isNew;
@override final  int? discountPercent;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDtoCopyWith<_ProductDto> get copyWith => __$ProductDtoCopyWithImpl<_ProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.priceMmk, priceMmk) || other.priceMmk == priceMmk)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,code,name,priceMmk,imageUrl,description,isNew,discountPercent);
}

@override
String toString() {
    return 'ProductDto(id: $id, code: $code, name: $name, priceMmk: $priceMmk, imageUrl: $imageUrl, description: $description, isNew: $isNew, discountPercent: $discountPercent)';
}


}

/// @nodoc
abstract mixin class _$ProductDtoCopyWith<$Res> implements $ProductDtoCopyWith<$Res> {
  factory _$ProductDtoCopyWith(_ProductDto value, $Res Function(_ProductDto) _then) = __$ProductDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String name, int priceMmk, String imageUrl, String description, bool isNew, int? discountPercent
});




}
/// @nodoc
class __$ProductDtoCopyWithImpl<$Res>
    implements _$ProductDtoCopyWith<$Res> {
  __$ProductDtoCopyWithImpl(this._self, this._then);

  final _ProductDto _self;
  final $Res Function(_ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? priceMmk = null,Object? imageUrl = null,Object? description = null,Object? isNew = null,Object? discountPercent = freezed,}) {
  return _then(_ProductDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceMmk: null == priceMmk ? _self.priceMmk : priceMmk // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$BannerDto {

 String get id; String get title; String get style; String get imageUrl; String? get badge;
/// Create a copy of BannerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BannerDtoCopyWith<BannerDto> get copyWith => _$BannerDtoCopyWithImpl<BannerDto>(this as BannerDto, _$identity);

  /// Serializes this BannerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BannerDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BannerDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.style, _this.style) || other.style == _this.style)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.badge, _this.badge) || other.badge == _this.badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BannerDto;
  return Object.hash(runtimeType,_this.id,_this.title,_this.style,_this.imageUrl,_this.badge);
}

@override
String toString() {
  final _this = this as BannerDto;
  return 'BannerDto(id: ${_this.id}, title: ${_this.title}, style: ${_this.style}, imageUrl: ${_this.imageUrl}, badge: ${_this.badge})';
}


}

/// @nodoc
abstract mixin class $BannerDtoCopyWith<$Res>  {
  factory $BannerDtoCopyWith(BannerDto value, $Res Function(BannerDto) _then) = _$BannerDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String style, String imageUrl, String? badge
});




}
/// @nodoc
class _$BannerDtoCopyWithImpl<$Res>
    implements $BannerDtoCopyWith<$Res> {
  _$BannerDtoCopyWithImpl(this._self, this._then);

  final BannerDto _self;
  final $Res Function(BannerDto) _then;

/// Create a copy of BannerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? style = null,Object? imageUrl = null,Object? badge = freezed,}) {
  return _then(BannerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BannerDto].
extension BannerDtoPatterns on BannerDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BannerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BannerDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BannerDto value)  $default,){
final _that = this;
switch (_that) {
case _BannerDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BannerDto value)?  $default,){
final _that = this;
switch (_that) {
case _BannerDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String style,  String imageUrl,  String? badge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BannerDto() when $default != null:
return $default(_that.id,_that.title,_that.style,_that.imageUrl,_that.badge);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String style,  String imageUrl,  String? badge)  $default,) {final _that = this;
switch (_that) {
case _BannerDto():
return $default(_that.id,_that.title,_that.style,_that.imageUrl,_that.badge);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String style,  String imageUrl,  String? badge)?  $default,) {final _that = this;
switch (_that) {
case _BannerDto() when $default != null:
return $default(_that.id,_that.title,_that.style,_that.imageUrl,_that.badge);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BannerDto implements BannerDto {
  const _BannerDto({required this.id, required this.title, required this.style, required this.imageUrl, this.badge});
  factory _BannerDto.fromJson(Map<String, dynamic> json) => _$BannerDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String style;
@override final  String imageUrl;
@override final  String? badge;

/// Create a copy of BannerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BannerDtoCopyWith<_BannerDto> get copyWith => __$BannerDtoCopyWithImpl<_BannerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BannerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BannerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.style, style) || other.style == style)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.badge, badge) || other.badge == badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,style,imageUrl,badge);
}

@override
String toString() {
    return 'BannerDto(id: $id, title: $title, style: $style, imageUrl: $imageUrl, badge: $badge)';
}


}

/// @nodoc
abstract mixin class _$BannerDtoCopyWith<$Res> implements $BannerDtoCopyWith<$Res> {
  factory _$BannerDtoCopyWith(_BannerDto value, $Res Function(_BannerDto) _then) = __$BannerDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String style, String imageUrl, String? badge
});




}
/// @nodoc
class __$BannerDtoCopyWithImpl<$Res>
    implements _$BannerDtoCopyWith<$Res> {
  __$BannerDtoCopyWithImpl(this._self, this._then);

  final _BannerDto _self;
  final $Res Function(_BannerDto) _then;

/// Create a copy of BannerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? style = null,Object? imageUrl = null,Object? badge = freezed,}) {
  return _then(_BannerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SectionDto {

 String get id; String get kind; List<String> get productIds;
/// Create a copy of SectionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionDtoCopyWith<SectionDto> get copyWith => _$SectionDtoCopyWithImpl<SectionDto>(this as SectionDto, _$identity);

  /// Serializes this SectionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SectionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&const DeepCollectionEquality().equals(other.productIds, _this.productIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SectionDto;
  return Object.hash(runtimeType,_this.id,_this.kind,const DeepCollectionEquality().hash(_this.productIds));
}

@override
String toString() {
  final _this = this as SectionDto;
  return 'SectionDto(id: ${_this.id}, kind: ${_this.kind}, productIds: ${_this.productIds})';
}


}

/// @nodoc
abstract mixin class $SectionDtoCopyWith<$Res>  {
  factory $SectionDtoCopyWith(SectionDto value, $Res Function(SectionDto) _then) = _$SectionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String kind, List<String> productIds
});




}
/// @nodoc
class _$SectionDtoCopyWithImpl<$Res>
    implements $SectionDtoCopyWith<$Res> {
  _$SectionDtoCopyWithImpl(this._self, this._then);

  final SectionDto _self;
  final $Res Function(SectionDto) _then;

/// Create a copy of SectionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? productIds = null,}) {
  return _then(SectionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,productIds: null == productIds ? _self.productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SectionDto].
extension SectionDtoPatterns on SectionDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectionDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectionDto value)  $default,){
final _that = this;
switch (_that) {
case _SectionDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectionDto value)?  $default,){
final _that = this;
switch (_that) {
case _SectionDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String kind,  List<String> productIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectionDto() when $default != null:
return $default(_that.id,_that.kind,_that.productIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String kind,  List<String> productIds)  $default,) {final _that = this;
switch (_that) {
case _SectionDto():
return $default(_that.id,_that.kind,_that.productIds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String kind,  List<String> productIds)?  $default,) {final _that = this;
switch (_that) {
case _SectionDto() when $default != null:
return $default(_that.id,_that.kind,_that.productIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SectionDto implements SectionDto {
  const _SectionDto({required this.id, required this.kind, required  List<String> productIds}): _productIds = productIds;
  factory _SectionDto.fromJson(Map<String, dynamic> json) => _$SectionDtoFromJson(json);

@override final  String id;
@override final  String kind;
 final  List<String> _productIds;
@override List<String> get productIds {
  if (_productIds is EqualUnmodifiableListView) return _productIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_productIds);
}


/// Create a copy of SectionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectionDtoCopyWith<_SectionDto> get copyWith => __$SectionDtoCopyWithImpl<_SectionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SectionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.productIds, _productIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,const DeepCollectionEquality().hash(_productIds));
}

@override
String toString() {
    return 'SectionDto(id: $id, kind: $kind, productIds: $productIds)';
}


}

/// @nodoc
abstract mixin class _$SectionDtoCopyWith<$Res> implements $SectionDtoCopyWith<$Res> {
  factory _$SectionDtoCopyWith(_SectionDto value, $Res Function(_SectionDto) _then) = __$SectionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String kind, List<String> productIds
});




}
/// @nodoc
class __$SectionDtoCopyWithImpl<$Res>
    implements _$SectionDtoCopyWith<$Res> {
  __$SectionDtoCopyWithImpl(this._self, this._then);

  final _SectionDto _self;
  final $Res Function(_SectionDto) _then;

/// Create a copy of SectionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? productIds = null,}) {
  return _then(_SectionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,productIds: null == productIds ? _self._productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ShopDto {

 String get id; String get name; String get address; String get imageUrl;
/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopDtoCopyWith<ShopDto> get copyWith => _$ShopDtoCopyWithImpl<ShopDto>(this as ShopDto, _$identity);

  /// Serializes this ShopDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ShopDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ShopDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.address,_this.imageUrl);
}

@override
String toString() {
  final _this = this as ShopDto;
  return 'ShopDto(id: ${_this.id}, name: ${_this.name}, address: ${_this.address}, imageUrl: ${_this.imageUrl})';
}


}

/// @nodoc
abstract mixin class $ShopDtoCopyWith<$Res>  {
  factory $ShopDtoCopyWith(ShopDto value, $Res Function(ShopDto) _then) = _$ShopDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, String imageUrl
});




}
/// @nodoc
class _$ShopDtoCopyWithImpl<$Res>
    implements $ShopDtoCopyWith<$Res> {
  _$ShopDtoCopyWithImpl(this._self, this._then);

  final ShopDto _self;
  final $Res Function(ShopDto) _then;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? imageUrl = null,}) {
  return _then(ShopDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopDto].
extension ShopDtoPatterns on ShopDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.imageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ShopDto():
return $default(_that.id,_that.name,_that.address,_that.imageUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopDto implements ShopDto {
  const _ShopDto({required this.id, required this.name, required this.address, required this.imageUrl});
  factory _ShopDto.fromJson(Map<String, dynamic> json) => _$ShopDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String address;
@override final  String imageUrl;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopDtoCopyWith<_ShopDto> get copyWith => __$ShopDtoCopyWithImpl<_ShopDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,address,imageUrl);
}

@override
String toString() {
    return 'ShopDto(id: $id, name: $name, address: $address, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ShopDtoCopyWith<$Res> implements $ShopDtoCopyWith<$Res> {
  factory _$ShopDtoCopyWith(_ShopDto value, $Res Function(_ShopDto) _then) = __$ShopDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, String imageUrl
});




}
/// @nodoc
class __$ShopDtoCopyWithImpl<$Res>
    implements _$ShopDtoCopyWith<$Res> {
  __$ShopDtoCopyWithImpl(this._self, this._then);

  final _ShopDto _self;
  final $Res Function(_ShopDto) _then;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? imageUrl = null,}) {
  return _then(_ShopDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CatalogPayloadDto {

 List<ProductDto> get products; List<BannerDto> get banners; List<SectionDto> get sections; List<ShopDto> get shops;
/// Create a copy of CatalogPayloadDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogPayloadDtoCopyWith<CatalogPayloadDto> get copyWith => _$CatalogPayloadDtoCopyWithImpl<CatalogPayloadDto>(this as CatalogPayloadDto, _$identity);

  /// Serializes this CatalogPayloadDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CatalogPayloadDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogPayloadDto&&const DeepCollectionEquality().equals(other.products, _this.products)&&const DeepCollectionEquality().equals(other.banners, _this.banners)&&const DeepCollectionEquality().equals(other.sections, _this.sections)&&const DeepCollectionEquality().equals(other.shops, _this.shops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CatalogPayloadDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.products),const DeepCollectionEquality().hash(_this.banners),const DeepCollectionEquality().hash(_this.sections),const DeepCollectionEquality().hash(_this.shops));
}

@override
String toString() {
  final _this = this as CatalogPayloadDto;
  return 'CatalogPayloadDto(products: ${_this.products}, banners: ${_this.banners}, sections: ${_this.sections}, shops: ${_this.shops})';
}


}

/// @nodoc
abstract mixin class $CatalogPayloadDtoCopyWith<$Res>  {
  factory $CatalogPayloadDtoCopyWith(CatalogPayloadDto value, $Res Function(CatalogPayloadDto) _then) = _$CatalogPayloadDtoCopyWithImpl;
@useResult
$Res call({
 List<ProductDto> products, List<BannerDto> banners, List<SectionDto> sections, List<ShopDto> shops
});




}
/// @nodoc
class _$CatalogPayloadDtoCopyWithImpl<$Res>
    implements $CatalogPayloadDtoCopyWith<$Res> {
  _$CatalogPayloadDtoCopyWithImpl(this._self, this._then);

  final CatalogPayloadDto _self;
  final $Res Function(CatalogPayloadDto) _then;

/// Create a copy of CatalogPayloadDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? banners = null,Object? sections = null,Object? shops = null,}) {
  return _then(CatalogPayloadDto(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>,banners: null == banners ? _self.banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerDto>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<SectionDto>,shops: null == shops ? _self.shops : shops // ignore: cast_nullable_to_non_nullable
as List<ShopDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogPayloadDto].
extension CatalogPayloadDtoPatterns on CatalogPayloadDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogPayloadDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogPayloadDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogPayloadDto value)  $default,){
final _that = this;
switch (_that) {
case _CatalogPayloadDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogPayloadDto value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogPayloadDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductDto> products,  List<BannerDto> banners,  List<SectionDto> sections,  List<ShopDto> shops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogPayloadDto() when $default != null:
return $default(_that.products,_that.banners,_that.sections,_that.shops);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductDto> products,  List<BannerDto> banners,  List<SectionDto> sections,  List<ShopDto> shops)  $default,) {final _that = this;
switch (_that) {
case _CatalogPayloadDto():
return $default(_that.products,_that.banners,_that.sections,_that.shops);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductDto> products,  List<BannerDto> banners,  List<SectionDto> sections,  List<ShopDto> shops)?  $default,) {final _that = this;
switch (_that) {
case _CatalogPayloadDto() when $default != null:
return $default(_that.products,_that.banners,_that.sections,_that.shops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogPayloadDto implements CatalogPayloadDto {
  const _CatalogPayloadDto({required  List<ProductDto> products, required  List<BannerDto> banners, required  List<SectionDto> sections, required  List<ShopDto> shops}): _products = products,_banners = banners,_sections = sections,_shops = shops;
  factory _CatalogPayloadDto.fromJson(Map<String, dynamic> json) => _$CatalogPayloadDtoFromJson(json);

 final  List<ProductDto> _products;
@override List<ProductDto> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<BannerDto> _banners;
@override List<BannerDto> get banners {
  if (_banners is EqualUnmodifiableListView) return _banners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_banners);
}

 final  List<SectionDto> _sections;
@override List<SectionDto> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

 final  List<ShopDto> _shops;
@override List<ShopDto> get shops {
  if (_shops is EqualUnmodifiableListView) return _shops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shops);
}


/// Create a copy of CatalogPayloadDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogPayloadDtoCopyWith<_CatalogPayloadDto> get copyWith => __$CatalogPayloadDtoCopyWithImpl<_CatalogPayloadDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogPayloadDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogPayloadDto&&const DeepCollectionEquality().equals(other.products, _products)&&const DeepCollectionEquality().equals(other.banners, _banners)&&const DeepCollectionEquality().equals(other.sections, _sections)&&const DeepCollectionEquality().equals(other.shops, _shops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_banners),const DeepCollectionEquality().hash(_sections),const DeepCollectionEquality().hash(_shops));
}

@override
String toString() {
    return 'CatalogPayloadDto(products: $products, banners: $banners, sections: $sections, shops: $shops)';
}


}

/// @nodoc
abstract mixin class _$CatalogPayloadDtoCopyWith<$Res> implements $CatalogPayloadDtoCopyWith<$Res> {
  factory _$CatalogPayloadDtoCopyWith(_CatalogPayloadDto value, $Res Function(_CatalogPayloadDto) _then) = __$CatalogPayloadDtoCopyWithImpl;
@override @useResult
$Res call({
 List<ProductDto> products, List<BannerDto> banners, List<SectionDto> sections, List<ShopDto> shops
});




}
/// @nodoc
class __$CatalogPayloadDtoCopyWithImpl<$Res>
    implements _$CatalogPayloadDtoCopyWith<$Res> {
  __$CatalogPayloadDtoCopyWithImpl(this._self, this._then);

  final _CatalogPayloadDto _self;
  final $Res Function(_CatalogPayloadDto) _then;

/// Create a copy of CatalogPayloadDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? banners = null,Object? sections = null,Object? shops = null,}) {
  return _then(_CatalogPayloadDto(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>,banners: null == banners ? _self._banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerDto>,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<SectionDto>,shops: null == shops ? _self._shops : shops // ignore: cast_nullable_to_non_nullable
as List<ShopDto>,
  ));
}


}


/// @nodoc
mixin _$MemberDto {

 String get id; String get name; String get photoUrl; String get tier; int get totalPoints; int get pointsToNextTier; int get notificationCount; int get rewardCount;
/// Create a copy of MemberDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberDtoCopyWith<MemberDto> get copyWith => _$MemberDtoCopyWithImpl<MemberDto>(this as MemberDto, _$identity);

  /// Serializes this MemberDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MemberDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.tier, _this.tier) || other.tier == _this.tier)&&(identical(other.totalPoints, _this.totalPoints) || other.totalPoints == _this.totalPoints)&&(identical(other.pointsToNextTier, _this.pointsToNextTier) || other.pointsToNextTier == _this.pointsToNextTier)&&(identical(other.notificationCount, _this.notificationCount) || other.notificationCount == _this.notificationCount)&&(identical(other.rewardCount, _this.rewardCount) || other.rewardCount == _this.rewardCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MemberDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.photoUrl,_this.tier,_this.totalPoints,_this.pointsToNextTier,_this.notificationCount,_this.rewardCount);
}

@override
String toString() {
  final _this = this as MemberDto;
  return 'MemberDto(id: ${_this.id}, name: ${_this.name}, photoUrl: ${_this.photoUrl}, tier: ${_this.tier}, totalPoints: ${_this.totalPoints}, pointsToNextTier: ${_this.pointsToNextTier}, notificationCount: ${_this.notificationCount}, rewardCount: ${_this.rewardCount})';
}


}

/// @nodoc
abstract mixin class $MemberDtoCopyWith<$Res>  {
  factory $MemberDtoCopyWith(MemberDto value, $Res Function(MemberDto) _then) = _$MemberDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String photoUrl, String tier, int totalPoints, int pointsToNextTier, int notificationCount, int rewardCount
});




}
/// @nodoc
class _$MemberDtoCopyWithImpl<$Res>
    implements $MemberDtoCopyWith<$Res> {
  _$MemberDtoCopyWithImpl(this._self, this._then);

  final MemberDto _self;
  final $Res Function(MemberDto) _then;

/// Create a copy of MemberDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? photoUrl = null,Object? tier = null,Object? totalPoints = null,Object? pointsToNextTier = null,Object? notificationCount = null,Object? rewardCount = null,}) {
  return _then(MemberDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,pointsToNextTier: null == pointsToNextTier ? _self.pointsToNextTier : pointsToNextTier // ignore: cast_nullable_to_non_nullable
as int,notificationCount: null == notificationCount ? _self.notificationCount : notificationCount // ignore: cast_nullable_to_non_nullable
as int,rewardCount: null == rewardCount ? _self.rewardCount : rewardCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberDto].
extension MemberDtoPatterns on MemberDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String photoUrl,  String tier,  int totalPoints,  int pointsToNextTier,  int notificationCount,  int rewardCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberDto() when $default != null:
return $default(_that.id,_that.name,_that.photoUrl,_that.tier,_that.totalPoints,_that.pointsToNextTier,_that.notificationCount,_that.rewardCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String photoUrl,  String tier,  int totalPoints,  int pointsToNextTier,  int notificationCount,  int rewardCount)  $default,) {final _that = this;
switch (_that) {
case _MemberDto():
return $default(_that.id,_that.name,_that.photoUrl,_that.tier,_that.totalPoints,_that.pointsToNextTier,_that.notificationCount,_that.rewardCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String photoUrl,  String tier,  int totalPoints,  int pointsToNextTier,  int notificationCount,  int rewardCount)?  $default,) {final _that = this;
switch (_that) {
case _MemberDto() when $default != null:
return $default(_that.id,_that.name,_that.photoUrl,_that.tier,_that.totalPoints,_that.pointsToNextTier,_that.notificationCount,_that.rewardCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberDto implements MemberDto {
  const _MemberDto({required this.id, required this.name, required this.photoUrl, required this.tier, required this.totalPoints, required this.pointsToNextTier, required this.notificationCount, required this.rewardCount});
  factory _MemberDto.fromJson(Map<String, dynamic> json) => _$MemberDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String photoUrl;
@override final  String tier;
@override final  int totalPoints;
@override final  int pointsToNextTier;
@override final  int notificationCount;
@override final  int rewardCount;

/// Create a copy of MemberDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberDtoCopyWith<_MemberDto> get copyWith => __$MemberDtoCopyWithImpl<_MemberDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.pointsToNextTier, pointsToNextTier) || other.pointsToNextTier == pointsToNextTier)&&(identical(other.notificationCount, notificationCount) || other.notificationCount == notificationCount)&&(identical(other.rewardCount, rewardCount) || other.rewardCount == rewardCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,photoUrl,tier,totalPoints,pointsToNextTier,notificationCount,rewardCount);
}

@override
String toString() {
    return 'MemberDto(id: $id, name: $name, photoUrl: $photoUrl, tier: $tier, totalPoints: $totalPoints, pointsToNextTier: $pointsToNextTier, notificationCount: $notificationCount, rewardCount: $rewardCount)';
}


}

/// @nodoc
abstract mixin class _$MemberDtoCopyWith<$Res> implements $MemberDtoCopyWith<$Res> {
  factory _$MemberDtoCopyWith(_MemberDto value, $Res Function(_MemberDto) _then) = __$MemberDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String photoUrl, String tier, int totalPoints, int pointsToNextTier, int notificationCount, int rewardCount
});




}
/// @nodoc
class __$MemberDtoCopyWithImpl<$Res>
    implements _$MemberDtoCopyWith<$Res> {
  __$MemberDtoCopyWithImpl(this._self, this._then);

  final _MemberDto _self;
  final $Res Function(_MemberDto) _then;

/// Create a copy of MemberDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? photoUrl = null,Object? tier = null,Object? totalPoints = null,Object? pointsToNextTier = null,Object? notificationCount = null,Object? rewardCount = null,}) {
  return _then(_MemberDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,pointsToNextTier: null == pointsToNextTier ? _self.pointsToNextTier : pointsToNextTier // ignore: cast_nullable_to_non_nullable
as int,notificationCount: null == notificationCount ? _self.notificationCount : notificationCount // ignore: cast_nullable_to_non_nullable
as int,rewardCount: null == rewardCount ? _self.rewardCount : rewardCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ChallengeDto {

 String get id; String get title; String get artwork; String get imageUrl; int get progress; int get goal; int get rewardPoints; String get tab;
/// Create a copy of ChallengeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeDtoCopyWith<ChallengeDto> get copyWith => _$ChallengeDtoCopyWithImpl<ChallengeDto>(this as ChallengeDto, _$identity);

  /// Serializes this ChallengeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChallengeDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.artwork, _this.artwork) || other.artwork == _this.artwork)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.goal, _this.goal) || other.goal == _this.goal)&&(identical(other.rewardPoints, _this.rewardPoints) || other.rewardPoints == _this.rewardPoints)&&(identical(other.tab, _this.tab) || other.tab == _this.tab));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChallengeDto;
  return Object.hash(runtimeType,_this.id,_this.title,_this.artwork,_this.imageUrl,_this.progress,_this.goal,_this.rewardPoints,_this.tab);
}

@override
String toString() {
  final _this = this as ChallengeDto;
  return 'ChallengeDto(id: ${_this.id}, title: ${_this.title}, artwork: ${_this.artwork}, imageUrl: ${_this.imageUrl}, progress: ${_this.progress}, goal: ${_this.goal}, rewardPoints: ${_this.rewardPoints}, tab: ${_this.tab})';
}


}

/// @nodoc
abstract mixin class $ChallengeDtoCopyWith<$Res>  {
  factory $ChallengeDtoCopyWith(ChallengeDto value, $Res Function(ChallengeDto) _then) = _$ChallengeDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String artwork, String imageUrl, int progress, int goal, int rewardPoints, String tab
});




}
/// @nodoc
class _$ChallengeDtoCopyWithImpl<$Res>
    implements $ChallengeDtoCopyWith<$Res> {
  _$ChallengeDtoCopyWithImpl(this._self, this._then);

  final ChallengeDto _self;
  final $Res Function(ChallengeDto) _then;

/// Create a copy of ChallengeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? artwork = null,Object? imageUrl = null,Object? progress = null,Object? goal = null,Object? rewardPoints = null,Object? tab = null,}) {
  return _then(ChallengeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,artwork: null == artwork ? _self.artwork : artwork // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChallengeDto].
extension ChallengeDtoPatterns on ChallengeDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChallengeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChallengeDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChallengeDto value)  $default,){
final _that = this;
switch (_that) {
case _ChallengeDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChallengeDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChallengeDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String artwork,  String imageUrl,  int progress,  int goal,  int rewardPoints,  String tab)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChallengeDto() when $default != null:
return $default(_that.id,_that.title,_that.artwork,_that.imageUrl,_that.progress,_that.goal,_that.rewardPoints,_that.tab);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String artwork,  String imageUrl,  int progress,  int goal,  int rewardPoints,  String tab)  $default,) {final _that = this;
switch (_that) {
case _ChallengeDto():
return $default(_that.id,_that.title,_that.artwork,_that.imageUrl,_that.progress,_that.goal,_that.rewardPoints,_that.tab);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String artwork,  String imageUrl,  int progress,  int goal,  int rewardPoints,  String tab)?  $default,) {final _that = this;
switch (_that) {
case _ChallengeDto() when $default != null:
return $default(_that.id,_that.title,_that.artwork,_that.imageUrl,_that.progress,_that.goal,_that.rewardPoints,_that.tab);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChallengeDto implements ChallengeDto {
  const _ChallengeDto({required this.id, required this.title, required this.artwork, required this.imageUrl, required this.progress, required this.goal, required this.rewardPoints, required this.tab});
  factory _ChallengeDto.fromJson(Map<String, dynamic> json) => _$ChallengeDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String artwork;
@override final  String imageUrl;
@override final  int progress;
@override final  int goal;
@override final  int rewardPoints;
@override final  String tab;

/// Create a copy of ChallengeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChallengeDtoCopyWith<_ChallengeDto> get copyWith => __$ChallengeDtoCopyWithImpl<_ChallengeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChallengeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChallengeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.artwork, artwork) || other.artwork == artwork)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.rewardPoints, rewardPoints) || other.rewardPoints == rewardPoints)&&(identical(other.tab, tab) || other.tab == tab));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,artwork,imageUrl,progress,goal,rewardPoints,tab);
}

@override
String toString() {
    return 'ChallengeDto(id: $id, title: $title, artwork: $artwork, imageUrl: $imageUrl, progress: $progress, goal: $goal, rewardPoints: $rewardPoints, tab: $tab)';
}


}

/// @nodoc
abstract mixin class _$ChallengeDtoCopyWith<$Res> implements $ChallengeDtoCopyWith<$Res> {
  factory _$ChallengeDtoCopyWith(_ChallengeDto value, $Res Function(_ChallengeDto) _then) = __$ChallengeDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String artwork, String imageUrl, int progress, int goal, int rewardPoints, String tab
});




}
/// @nodoc
class __$ChallengeDtoCopyWithImpl<$Res>
    implements _$ChallengeDtoCopyWith<$Res> {
  __$ChallengeDtoCopyWithImpl(this._self, this._then);

  final _ChallengeDto _self;
  final $Res Function(_ChallengeDto) _then;

/// Create a copy of ChallengeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? artwork = null,Object? imageUrl = null,Object? progress = null,Object? goal = null,Object? rewardPoints = null,Object? tab = null,}) {
  return _then(_ChallengeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,artwork: null == artwork ? _self.artwork : artwork // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SeedDto {

 int get version; CatalogPayloadDto get catalog; MemberDto get member; List<ChallengeDto> get challenges;
/// Create a copy of SeedDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeedDtoCopyWith<SeedDto> get copyWith => _$SeedDtoCopyWithImpl<SeedDto>(this as SeedDto, _$identity);

  /// Serializes this SeedDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SeedDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeedDto&&(identical(other.version, _this.version) || other.version == _this.version)&&(identical(other.catalog, _this.catalog) || other.catalog == _this.catalog)&&(identical(other.member, _this.member) || other.member == _this.member)&&const DeepCollectionEquality().equals(other.challenges, _this.challenges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SeedDto;
  return Object.hash(runtimeType,_this.version,_this.catalog,_this.member,const DeepCollectionEquality().hash(_this.challenges));
}

@override
String toString() {
  final _this = this as SeedDto;
  return 'SeedDto(version: ${_this.version}, catalog: ${_this.catalog}, member: ${_this.member}, challenges: ${_this.challenges})';
}


}

/// @nodoc
abstract mixin class $SeedDtoCopyWith<$Res>  {
  factory $SeedDtoCopyWith(SeedDto value, $Res Function(SeedDto) _then) = _$SeedDtoCopyWithImpl;
@useResult
$Res call({
 int version, CatalogPayloadDto catalog, MemberDto member, List<ChallengeDto> challenges
});


$CatalogPayloadDtoCopyWith<$Res> get catalog;$MemberDtoCopyWith<$Res> get member;

}
/// @nodoc
class _$SeedDtoCopyWithImpl<$Res>
    implements $SeedDtoCopyWith<$Res> {
  _$SeedDtoCopyWithImpl(this._self, this._then);

  final SeedDto _self;
  final $Res Function(SeedDto) _then;

/// Create a copy of SeedDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? catalog = null,Object? member = null,Object? challenges = null,}) {
  return _then(SeedDto(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,catalog: null == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as CatalogPayloadDto,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberDto,challenges: null == challenges ? _self.challenges : challenges // ignore: cast_nullable_to_non_nullable
as List<ChallengeDto>,
  ));
}
/// Create a copy of SeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogPayloadDtoCopyWith<$Res> get catalog {
  
  return $CatalogPayloadDtoCopyWith<$Res>(_self.catalog, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}/// Create a copy of SeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberDtoCopyWith<$Res> get member {
  
  return $MemberDtoCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeedDto].
extension SeedDtoPatterns on SeedDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeedDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeedDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeedDto value)  $default,){
final _that = this;
switch (_that) {
case _SeedDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeedDto value)?  $default,){
final _that = this;
switch (_that) {
case _SeedDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  CatalogPayloadDto catalog,  MemberDto member,  List<ChallengeDto> challenges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeedDto() when $default != null:
return $default(_that.version,_that.catalog,_that.member,_that.challenges);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  CatalogPayloadDto catalog,  MemberDto member,  List<ChallengeDto> challenges)  $default,) {final _that = this;
switch (_that) {
case _SeedDto():
return $default(_that.version,_that.catalog,_that.member,_that.challenges);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  CatalogPayloadDto catalog,  MemberDto member,  List<ChallengeDto> challenges)?  $default,) {final _that = this;
switch (_that) {
case _SeedDto() when $default != null:
return $default(_that.version,_that.catalog,_that.member,_that.challenges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeedDto implements SeedDto {
  const _SeedDto({required this.version, required this.catalog, required this.member, required  List<ChallengeDto> challenges}): _challenges = challenges;
  factory _SeedDto.fromJson(Map<String, dynamic> json) => _$SeedDtoFromJson(json);

@override final  int version;
@override final  CatalogPayloadDto catalog;
@override final  MemberDto member;
 final  List<ChallengeDto> _challenges;
@override List<ChallengeDto> get challenges {
  if (_challenges is EqualUnmodifiableListView) return _challenges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_challenges);
}


/// Create a copy of SeedDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeedDtoCopyWith<_SeedDto> get copyWith => __$SeedDtoCopyWithImpl<_SeedDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeedDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeedDto&&(identical(other.version, version) || other.version == version)&&(identical(other.catalog, catalog) || other.catalog == catalog)&&(identical(other.member, member) || other.member == member)&&const DeepCollectionEquality().equals(other.challenges, _challenges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,version,catalog,member,const DeepCollectionEquality().hash(_challenges));
}

@override
String toString() {
    return 'SeedDto(version: $version, catalog: $catalog, member: $member, challenges: $challenges)';
}


}

/// @nodoc
abstract mixin class _$SeedDtoCopyWith<$Res> implements $SeedDtoCopyWith<$Res> {
  factory _$SeedDtoCopyWith(_SeedDto value, $Res Function(_SeedDto) _then) = __$SeedDtoCopyWithImpl;
@override @useResult
$Res call({
 int version, CatalogPayloadDto catalog, MemberDto member, List<ChallengeDto> challenges
});


@override $CatalogPayloadDtoCopyWith<$Res> get catalog;@override $MemberDtoCopyWith<$Res> get member;

}
/// @nodoc
class __$SeedDtoCopyWithImpl<$Res>
    implements _$SeedDtoCopyWith<$Res> {
  __$SeedDtoCopyWithImpl(this._self, this._then);

  final _SeedDto _self;
  final $Res Function(_SeedDto) _then;

/// Create a copy of SeedDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? catalog = null,Object? member = null,Object? challenges = null,}) {
  return _then(_SeedDto(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,catalog: null == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as CatalogPayloadDto,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberDto,challenges: null == challenges ? _self._challenges : challenges // ignore: cast_nullable_to_non_nullable
as List<ChallengeDto>,
  ));
}

/// Create a copy of SeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogPayloadDtoCopyWith<$Res> get catalog {
  
  return $CatalogPayloadDtoCopyWith<$Res>(_self.catalog, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}/// Create a copy of SeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberDtoCopyWith<$Res> get member {
  
  return $MemberDtoCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// @nodoc
mixin _$ApiErrorDto {

 String get code; String get message;
/// Create a copy of ApiErrorDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiErrorDtoCopyWith<ApiErrorDto> get copyWith => _$ApiErrorDtoCopyWithImpl<ApiErrorDto>(this as ApiErrorDto, _$identity);

  /// Serializes this ApiErrorDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ApiErrorDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiErrorDto&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiErrorDto;
  return Object.hash(runtimeType,_this.code,_this.message);
}

@override
String toString() {
  final _this = this as ApiErrorDto;
  return 'ApiErrorDto(code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $ApiErrorDtoCopyWith<$Res>  {
  factory $ApiErrorDtoCopyWith(ApiErrorDto value, $Res Function(ApiErrorDto) _then) = _$ApiErrorDtoCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ApiErrorDtoCopyWithImpl<$Res>
    implements $ApiErrorDtoCopyWith<$Res> {
  _$ApiErrorDtoCopyWithImpl(this._self, this._then);

  final ApiErrorDto _self;
  final $Res Function(ApiErrorDto) _then;

/// Create a copy of ApiErrorDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(ApiErrorDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiErrorDto].
extension ApiErrorDtoPatterns on ApiErrorDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiErrorDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiErrorDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiErrorDto value)  $default,){
final _that = this;
switch (_that) {
case _ApiErrorDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiErrorDto value)?  $default,){
final _that = this;
switch (_that) {
case _ApiErrorDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiErrorDto() when $default != null:
return $default(_that.code,_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message)  $default,) {final _that = this;
switch (_that) {
case _ApiErrorDto():
return $default(_that.code,_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ApiErrorDto() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiErrorDto implements ApiErrorDto {
  const _ApiErrorDto({required this.code, required this.message});
  factory _ApiErrorDto.fromJson(Map<String, dynamic> json) => _$ApiErrorDtoFromJson(json);

@override final  String code;
@override final  String message;

/// Create a copy of ApiErrorDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiErrorDtoCopyWith<_ApiErrorDto> get copyWith => __$ApiErrorDtoCopyWithImpl<_ApiErrorDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiErrorDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiErrorDto&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,message);
}

@override
String toString() {
    return 'ApiErrorDto(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ApiErrorDtoCopyWith<$Res> implements $ApiErrorDtoCopyWith<$Res> {
  factory _$ApiErrorDtoCopyWith(_ApiErrorDto value, $Res Function(_ApiErrorDto) _then) = __$ApiErrorDtoCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$ApiErrorDtoCopyWithImpl<$Res>
    implements _$ApiErrorDtoCopyWith<$Res> {
  __$ApiErrorDtoCopyWithImpl(this._self, this._then);

  final _ApiErrorDto _self;
  final $Res Function(_ApiErrorDto) _then;

/// Create a copy of ApiErrorDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_ApiErrorDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ApiMetaDto {

 int get version; String? get generatedAt;
/// Create a copy of ApiMetaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiMetaDtoCopyWith<ApiMetaDto> get copyWith => _$ApiMetaDtoCopyWithImpl<ApiMetaDto>(this as ApiMetaDto, _$identity);

  /// Serializes this ApiMetaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ApiMetaDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiMetaDto&&(identical(other.version, _this.version) || other.version == _this.version)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiMetaDto;
  return Object.hash(runtimeType,_this.version,_this.generatedAt);
}

@override
String toString() {
  final _this = this as ApiMetaDto;
  return 'ApiMetaDto(version: ${_this.version}, generatedAt: ${_this.generatedAt})';
}


}

/// @nodoc
abstract mixin class $ApiMetaDtoCopyWith<$Res>  {
  factory $ApiMetaDtoCopyWith(ApiMetaDto value, $Res Function(ApiMetaDto) _then) = _$ApiMetaDtoCopyWithImpl;
@useResult
$Res call({
 int version, String? generatedAt
});




}
/// @nodoc
class _$ApiMetaDtoCopyWithImpl<$Res>
    implements $ApiMetaDtoCopyWith<$Res> {
  _$ApiMetaDtoCopyWithImpl(this._self, this._then);

  final ApiMetaDto _self;
  final $Res Function(ApiMetaDto) _then;

/// Create a copy of ApiMetaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? generatedAt = freezed,}) {
  return _then(ApiMetaDto(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiMetaDto].
extension ApiMetaDtoPatterns on ApiMetaDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiMetaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiMetaDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiMetaDto value)  $default,){
final _that = this;
switch (_that) {
case _ApiMetaDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiMetaDto value)?  $default,){
final _that = this;
switch (_that) {
case _ApiMetaDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  String? generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiMetaDto() when $default != null:
return $default(_that.version,_that.generatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  String? generatedAt)  $default,) {final _that = this;
switch (_that) {
case _ApiMetaDto():
return $default(_that.version,_that.generatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  String? generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ApiMetaDto() when $default != null:
return $default(_that.version,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiMetaDto implements ApiMetaDto {
  const _ApiMetaDto({required this.version, this.generatedAt});
  factory _ApiMetaDto.fromJson(Map<String, dynamic> json) => _$ApiMetaDtoFromJson(json);

@override final  int version;
@override final  String? generatedAt;

/// Create a copy of ApiMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiMetaDtoCopyWith<_ApiMetaDto> get copyWith => __$ApiMetaDtoCopyWithImpl<_ApiMetaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiMetaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiMetaDto&&(identical(other.version, version) || other.version == version)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,version,generatedAt);
}

@override
String toString() {
    return 'ApiMetaDto(version: $version, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$ApiMetaDtoCopyWith<$Res> implements $ApiMetaDtoCopyWith<$Res> {
  factory _$ApiMetaDtoCopyWith(_ApiMetaDto value, $Res Function(_ApiMetaDto) _then) = __$ApiMetaDtoCopyWithImpl;
@override @useResult
$Res call({
 int version, String? generatedAt
});




}
/// @nodoc
class __$ApiMetaDtoCopyWithImpl<$Res>
    implements _$ApiMetaDtoCopyWith<$Res> {
  __$ApiMetaDtoCopyWithImpl(this._self, this._then);

  final _ApiMetaDto _self;
  final $Res Function(_ApiMetaDto) _then;

/// Create a copy of ApiMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? generatedAt = freezed,}) {
  return _then(_ApiMetaDto(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ApiEnvelope<T> {

 ApiMetaDto get meta; T? get data; ApiErrorDto? get error;
/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiEnvelopeCopyWith<T, ApiEnvelope<T>> get copyWith => _$ApiEnvelopeCopyWithImpl<T, ApiEnvelope<T>>(this as ApiEnvelope<T>, _$identity);

  /// Serializes this ApiEnvelope to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  final _this = this as ApiEnvelope<T>;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiEnvelope<T>&&(identical(other.meta, _this.meta) || other.meta == _this.meta)&&const DeepCollectionEquality().equals(other.data, _this.data)&&(identical(other.error, _this.error) || other.error == _this.error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiEnvelope<T>;
  return Object.hash(runtimeType,_this.meta,const DeepCollectionEquality().hash(_this.data),_this.error);
}

@override
String toString() {
  final _this = this as ApiEnvelope<T>;
  return 'ApiEnvelope<$T>(meta: ${_this.meta}, data: ${_this.data}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ApiEnvelopeCopyWith<T,$Res>  {
  factory $ApiEnvelopeCopyWith(ApiEnvelope<T> value, $Res Function(ApiEnvelope<T>) _then) = _$ApiEnvelopeCopyWithImpl;
@useResult
$Res call({
 ApiMetaDto meta, T? data, ApiErrorDto? error
});


$ApiMetaDtoCopyWith<$Res> get meta;$ApiErrorDtoCopyWith<$Res>? get error;

}
/// @nodoc
class _$ApiEnvelopeCopyWithImpl<T,$Res>
    implements $ApiEnvelopeCopyWith<T, $Res> {
  _$ApiEnvelopeCopyWithImpl(this._self, this._then);

  final ApiEnvelope<T> _self;
  final $Res Function(ApiEnvelope<T>) _then;

/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meta = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(ApiEnvelope(
meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ApiMetaDto,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorDto?,
  ));
}
/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiMetaDtoCopyWith<$Res> get meta {
  
  return $ApiMetaDtoCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiErrorDtoCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ApiErrorDtoCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApiEnvelope].
extension ApiEnvelopePatterns<T> on ApiEnvelope<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiEnvelope<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiEnvelope() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiEnvelope<T> value)  $default,){
final _that = this;
switch (_that) {
case _ApiEnvelope():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiEnvelope<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ApiEnvelope() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiMetaDto meta,  T? data,  ApiErrorDto? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiEnvelope() when $default != null:
return $default(_that.meta,_that.data,_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiMetaDto meta,  T? data,  ApiErrorDto? error)  $default,) {final _that = this;
switch (_that) {
case _ApiEnvelope():
return $default(_that.meta,_that.data,_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiMetaDto meta,  T? data,  ApiErrorDto? error)?  $default,) {final _that = this;
switch (_that) {
case _ApiEnvelope() when $default != null:
return $default(_that.meta,_that.data,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _ApiEnvelope<T> implements ApiEnvelope<T> {
  const _ApiEnvelope({required this.meta, this.data, this.error});
  factory _ApiEnvelope.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ApiEnvelopeFromJson(json,fromJsonT);

@override final  ApiMetaDto meta;
@override final  T? data;
@override final  ApiErrorDto? error;

/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiEnvelopeCopyWith<T, _ApiEnvelope<T>> get copyWith => __$ApiEnvelopeCopyWithImpl<T, _ApiEnvelope<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ApiEnvelopeToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiEnvelope<T>&&(identical(other.meta, meta) || other.meta == meta)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,meta,const DeepCollectionEquality().hash(data),error);
}

@override
String toString() {
    return 'ApiEnvelope<$T>(meta: $meta, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ApiEnvelopeCopyWith<T,$Res> implements $ApiEnvelopeCopyWith<T, $Res> {
  factory _$ApiEnvelopeCopyWith(_ApiEnvelope<T> value, $Res Function(_ApiEnvelope<T>) _then) = __$ApiEnvelopeCopyWithImpl;
@override @useResult
$Res call({
 ApiMetaDto meta, T? data, ApiErrorDto? error
});


@override $ApiMetaDtoCopyWith<$Res> get meta;@override $ApiErrorDtoCopyWith<$Res>? get error;

}
/// @nodoc
class __$ApiEnvelopeCopyWithImpl<T,$Res>
    implements _$ApiEnvelopeCopyWith<T, $Res> {
  __$ApiEnvelopeCopyWithImpl(this._self, this._then);

  final _ApiEnvelope<T> _self;
  final $Res Function(_ApiEnvelope<T>) _then;

/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meta = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_ApiEnvelope<T>(
meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ApiMetaDto,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorDto?,
  ));
}

/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiMetaDtoCopyWith<$Res> get meta {
  
  return $ApiMetaDtoCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiErrorDtoCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ApiErrorDtoCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
