import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/auth/domain/entities/entities.dart';

part 'auth_flow_state.freezed.dart';

/// Everything typed during registration, kept so Back restores each step.
@freezed
abstract class AuthFlowState with _$AuthFlowState {
  const factory AuthFlowState({
    @Default(AuthIntent.register) AuthIntent intent,
    @Default('') String phoneInput,
    PhoneNumber? phone,
    @Default('') String firstName,
    @Default('') String lastName,
    int? birthMonth,
    int? birthDay,
    int? birthYear,
    @Default(false) bool isSubmitting,
    Failure? error,
  }) = _AuthFlowState;

  const AuthFlowState._();

  bool get isLogin => intent == AuthIntent.logIn;
}
