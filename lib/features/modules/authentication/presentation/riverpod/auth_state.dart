import 'package:equatable/equatable.dart';

class AuthStateForm extends Equatable {
  final String? email;
  final String? emailError;
  final String? password;
  final String? passwordError;
  final bool isSubmitting;
  final bool isSuccess;
  final String? serverError;
  final bool? networkError;
  final bool? timeOutError;

  const AuthStateForm(
      {this.email,
      this.emailError,
      this.password,
      this.passwordError,
      this.isSubmitting = false,
      this.isSuccess = false,
      this.serverError,
      this.networkError,
      this.timeOutError});

  AuthStateForm copyWith({
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    bool? isSubmitting,
    bool? isSuccess,
    bool? networkError,
    bool? timeOutError,
    String? serverError,
  }) {
    return AuthStateForm(
        email: email ?? this.email,
        emailError: emailError,
        password: password ?? this.password,
        passwordError: passwordError,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        serverError: serverError,
        networkError: networkError,
        timeOutError: timeOutError);
  }

  AuthStateForm copyWithoutErrors({
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    bool? isSubmitting,
    bool? isSuccess,
    bool? networkError,
    bool? timeOutError,
    String? serverError,
  }) {
    return AuthStateForm(
        email: email ?? this.email,
        emailError: emailError,
        password: password ?? this.password,
        passwordError: passwordError,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        serverError: serverError,
        networkError: networkError,
        timeOutError: timeOutError);
  }

  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        passwordError,
        isSubmitting,
        isSuccess,
        serverError,
        networkError,
        timeOutError
      ];

  bool isValid() {
    return emailError == null &&
        passwordError == null &&
        email != null &&
        password != null;
  }

  isValidForLogin() {
    return emailError == null && email != null && password != null;
  }
}

enum LoginField { EMAIL, PASSWORD }
