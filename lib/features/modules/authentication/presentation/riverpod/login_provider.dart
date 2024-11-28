import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/AuthenticationParams.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/usecases/login_usecase.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/riverpod/auth_state.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/utils/login_validator.dart';

@Riverpod(keepAlive: false)
class LoginNotifier extends AutoDisposeNotifier<AuthStateForm> {
  final Loginvalidator loginValidator = GetIt.instance<Loginvalidator>();
  final LoginUsecase loginUseCase = GetIt.instance<LoginUsecase>();

  @override
  AuthStateForm build() {
    return const AuthStateForm();
  }

  Future<void> login() async {
    if (state.password != null) {
      state = state.copyWith(isSubmitting: true);
      final res = await loginUseCase(
          params: LoginParams(password: state.password!, email: state.email));
      state = state.copyWith(isSubmitting: false);
      res.fold((error) {
        if (error is NetworkException) {
          state = state.copyWith(networkError: true);
        } else if (error is ServerException) {
          state = state.copyWith(serverError: error.message);
        } else if (error is TimeoutException) {
          state = state.copyWith(timeOutError: true);
        }
      }, (right) {
        state = state.copyWith(isSuccess: true);
      });
    }
  }

  void updateValue(String value, LoginField field) {
    switch (field) {
      case LoginField.EMAIL:
        {
          state = state.copyWith(email: value);
          _validateInputs();
        }

      case LoginField.PASSWORD:
        {
          state = state.copyWith(password: value);
          _validateInputs();
        }
    }
  }

  Future<void> _validateInputs() async {
    final currentState = state;

    final emailCheck = currentState.email != null
        ? (loginValidator.validateUserEmail(currentState.email!))
        : null;

    state = state.copyWith(emailError: emailCheck?.message);
  }
}

final loginProvider =
    NotifierProvider.autoDispose<LoginNotifier, AuthStateForm>(
        LoginNotifier.new);
