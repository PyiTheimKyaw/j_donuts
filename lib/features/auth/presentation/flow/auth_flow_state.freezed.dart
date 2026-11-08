// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_flow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFlowState {

 AuthIntent get intent; String get phoneInput; PhoneNumber? get phone; String get firstName; String get lastName; int? get birthMonth; int? get birthDay; int? get birthYear; bool get isSubmitting; Failure? get error;
/// Create a copy of AuthFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFlowStateCopyWith<AuthFlowState> get copyWith => _$AuthFlowStateCopyWithImpl<AuthFlowState>(this as AuthFlowState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AuthFlowState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFlowState&&(identical(other.intent, _this.intent) || other.intent == _this.intent)&&(identical(other.phoneInput, _this.phoneInput) || other.phoneInput == _this.phoneInput)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.birthMonth, _this.birthMonth) || other.birthMonth == _this.birthMonth)&&(identical(other.birthDay, _this.birthDay) || other.birthDay == _this.birthDay)&&(identical(other.birthYear, _this.birthYear) || other.birthYear == _this.birthYear)&&(identical(other.isSubmitting, _this.isSubmitting) || other.isSubmitting == _this.isSubmitting)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as AuthFlowState;
  return Object.hash(runtimeType,_this.intent,_this.phoneInput,_this.phone,_this.firstName,_this.lastName,_this.birthMonth,_this.birthDay,_this.birthYear,_this.isSubmitting,_this.error);
}

@override
String toString() {
  final _this = this as AuthFlowState;
  return 'AuthFlowState(intent: ${_this.intent}, phoneInput: ${_this.phoneInput}, phone: ${_this.phone}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, birthMonth: ${_this.birthMonth}, birthDay: ${_this.birthDay}, birthYear: ${_this.birthYear}, isSubmitting: ${_this.isSubmitting}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $AuthFlowStateCopyWith<$Res>  {
  factory $AuthFlowStateCopyWith(AuthFlowState value, $Res Function(AuthFlowState) _then) = _$AuthFlowStateCopyWithImpl;
@useResult
$Res call({
 AuthIntent intent, String phoneInput, PhoneNumber? phone, String firstName, String lastName, int? birthMonth, int? birthDay, int? birthYear, bool isSubmitting, Failure? error
});




}
/// @nodoc
class _$AuthFlowStateCopyWithImpl<$Res>
    implements $AuthFlowStateCopyWith<$Res> {
  _$AuthFlowStateCopyWithImpl(this._self, this._then);

  final AuthFlowState _self;
  final $Res Function(AuthFlowState) _then;

/// Create a copy of AuthFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intent = null,Object? phoneInput = null,Object? phone = freezed,Object? firstName = null,Object? lastName = null,Object? birthMonth = freezed,Object? birthDay = freezed,Object? birthYear = freezed,Object? isSubmitting = null,Object? error = freezed,}) {
  return _then(AuthFlowState(
intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as AuthIntent,phoneInput: null == phoneInput ? _self.phoneInput : phoneInput // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as PhoneNumber?,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,birthMonth: freezed == birthMonth ? _self.birthMonth : birthMonth // ignore: cast_nullable_to_non_nullable
as int?,birthDay: freezed == birthDay ? _self.birthDay : birthDay // ignore: cast_nullable_to_non_nullable
as int?,birthYear: freezed == birthYear ? _self.birthYear : birthYear // ignore: cast_nullable_to_non_nullable
as int?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthFlowState].
extension AuthFlowStatePatterns on AuthFlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthFlowState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthFlowState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthFlowState value)  $default,){
final _that = this;
switch (_that) {
case _AuthFlowState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthFlowState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthFlowState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthIntent intent,  String phoneInput,  PhoneNumber? phone,  String firstName,  String lastName,  int? birthMonth,  int? birthDay,  int? birthYear,  bool isSubmitting,  Failure? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthFlowState() when $default != null:
return $default(_that.intent,_that.phoneInput,_that.phone,_that.firstName,_that.lastName,_that.birthMonth,_that.birthDay,_that.birthYear,_that.isSubmitting,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthIntent intent,  String phoneInput,  PhoneNumber? phone,  String firstName,  String lastName,  int? birthMonth,  int? birthDay,  int? birthYear,  bool isSubmitting,  Failure? error)  $default,) {final _that = this;
switch (_that) {
case _AuthFlowState():
return $default(_that.intent,_that.phoneInput,_that.phone,_that.firstName,_that.lastName,_that.birthMonth,_that.birthDay,_that.birthYear,_that.isSubmitting,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthIntent intent,  String phoneInput,  PhoneNumber? phone,  String firstName,  String lastName,  int? birthMonth,  int? birthDay,  int? birthYear,  bool isSubmitting,  Failure? error)?  $default,) {final _that = this;
switch (_that) {
case _AuthFlowState() when $default != null:
return $default(_that.intent,_that.phoneInput,_that.phone,_that.firstName,_that.lastName,_that.birthMonth,_that.birthDay,_that.birthYear,_that.isSubmitting,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _AuthFlowState extends AuthFlowState {
  const _AuthFlowState({this.intent = AuthIntent.register, this.phoneInput = '', this.phone, this.firstName = '', this.lastName = '', this.birthMonth, this.birthDay, this.birthYear, this.isSubmitting = false, this.error}): super._();
  

@override@JsonKey() final  AuthIntent intent;
@override@JsonKey() final  String phoneInput;
@override final  PhoneNumber? phone;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override final  int? birthMonth;
@override final  int? birthDay;
@override final  int? birthYear;
@override@JsonKey() final  bool isSubmitting;
@override final  Failure? error;

/// Create a copy of AuthFlowState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthFlowStateCopyWith<_AuthFlowState> get copyWith => __$AuthFlowStateCopyWithImpl<_AuthFlowState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthFlowState&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.phoneInput, phoneInput) || other.phoneInput == phoneInput)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.birthMonth, birthMonth) || other.birthMonth == birthMonth)&&(identical(other.birthDay, birthDay) || other.birthDay == birthDay)&&(identical(other.birthYear, birthYear) || other.birthYear == birthYear)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,intent,phoneInput,phone,firstName,lastName,birthMonth,birthDay,birthYear,isSubmitting,error);
}

@override
String toString() {
    return 'AuthFlowState(intent: $intent, phoneInput: $phoneInput, phone: $phone, firstName: $firstName, lastName: $lastName, birthMonth: $birthMonth, birthDay: $birthDay, birthYear: $birthYear, isSubmitting: $isSubmitting, error: $error)';
}


}

/// @nodoc
abstract mixin class _$AuthFlowStateCopyWith<$Res> implements $AuthFlowStateCopyWith<$Res> {
  factory _$AuthFlowStateCopyWith(_AuthFlowState value, $Res Function(_AuthFlowState) _then) = __$AuthFlowStateCopyWithImpl;
@override @useResult
$Res call({
 AuthIntent intent, String phoneInput, PhoneNumber? phone, String firstName, String lastName, int? birthMonth, int? birthDay, int? birthYear, bool isSubmitting, Failure? error
});




}
/// @nodoc
class __$AuthFlowStateCopyWithImpl<$Res>
    implements _$AuthFlowStateCopyWith<$Res> {
  __$AuthFlowStateCopyWithImpl(this._self, this._then);

  final _AuthFlowState _self;
  final $Res Function(_AuthFlowState) _then;

/// Create a copy of AuthFlowState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intent = null,Object? phoneInput = null,Object? phone = freezed,Object? firstName = null,Object? lastName = null,Object? birthMonth = freezed,Object? birthDay = freezed,Object? birthYear = freezed,Object? isSubmitting = null,Object? error = freezed,}) {
  return _then(_AuthFlowState(
intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as AuthIntent,phoneInput: null == phoneInput ? _self.phoneInput : phoneInput // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as PhoneNumber?,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,birthMonth: freezed == birthMonth ? _self.birthMonth : birthMonth // ignore: cast_nullable_to_non_nullable
as int?,birthDay: freezed == birthDay ? _self.birthDay : birthDay // ignore: cast_nullable_to_non_nullable
as int?,birthYear: freezed == birthYear ? _self.birthYear : birthYear // ignore: cast_nullable_to_non_nullable
as int?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
