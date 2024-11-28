import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/AuthenticationParams.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/usecases/register_usecase.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/riverpod/register/registration_state.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/utils/signup_validator.dart';

@Riverpod(keepAlive: false)
class RegisterNotifier extends AutoDisposeNotifier<SignUpMainState> {
  final Signupvalidator validator = GetIt.instance<Signupvalidator>();
  final RegisterUsecase registerUsecase = GetIt.instance<RegisterUsecase>();

  @override
  SignUpMainState build() {
    return const SignUpMainState();
  }

  Future<void> register() async {
    if (state.isValid()) {
      final currentState = state;
      if (currentState.isValid()) {
        dismissKeybaord();
        state = currentState.copyWith(
            submitting: true,
            networkError: false,
            serverError: null,
            timeOutError: null);
        final result = await registerUsecase(
            params: RegisterUserParams(
          email: currentState.emailAddress!,
          password: currentState.password!,
          name: currentState.name!,
        ));
        result.fold((error) {
          debugPrint(error.toString());
          if (error is NetworkException) {
            state =
                (currentState.copyWith(networkError: true, submitting: false));
          } else if (error is ServerException) {
            debugPrint(error.message);
            state = (currentState.copyWith(
                serverError: error.message, submitting: false));
          } else if (error is TimeoutException) {
            state =
                (currentState.copyWith(timeOutError: true, submitting: false));
          }
        }, (user) {
          state = (currentState.copyWith(submitted: true, submitting: false));
        });
      }
    }
  }

  Future<void> handleUpdateValue(SignUpFieldTypes type, String value) async {
    final currentStaate = state;
    switch (type) {
      case SignUpFieldTypes.EMAIL:
        {
          state = (currentStaate.copyWith(emailAddress: value));
        }
      case SignUpFieldTypes.PASSWORD:
        {
          state = (currentStaate.copyWith(password: value));
        }
      case SignUpFieldTypes.CONFIRM_PASSWORD:
        {
          state = (currentStaate.copyWith(confirmpassword: value));
        }
      case SignUpFieldTypes.NAME:
        {
          state = (currentStaate.copyWith(name: value));
        }
    }
    await _validateFields();
  }

  Future<void> _validateFields() async {
    final currentState = state;
    final isNameValid = currentState.name == null
        ? null
        : validator.validateName(currentState.name!);
    final isEmailValid = currentState.emailAddress == null
        ? null
        : validator.validateUserEmail(currentState.emailAddress!);
    final isPasswordValid = currentState.password == null
        ? null
        : validator.validatePassword(currentState.password!);
    final isConfirmPasswordValid = currentState.confirmpassword == null
        ? null
        : validator.validateConfirmPassword(
            currentState.password!, currentState.confirmpassword!);
    state = (currentState.copyWith(
      nameError: isNameValid?.message,
      emailError: isEmailValid?.message,
      passwordError: isPasswordValid?.message,
      confirmpasswordError: isConfirmPasswordValid?.message,
    ));
  }
}

final registerProvider =
    NotifierProvider.autoDispose<RegisterNotifier, SignUpMainState>(
        RegisterNotifier.new);

enum SignUpFieldTypes {
  EMAIL,
  PASSWORD,
  CONFIRM_PASSWORD,
  NAME,
}
