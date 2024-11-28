import 'package:equatable/equatable.dart';

final class SignUpMainState extends Equatable {
  final String? name;
  final String? emailAddress;
  final String? password;
  final String? confirmpassword;
  final bool submitting;
  final bool? submitted;
  final String? serverError;
  final bool? timeOutError;
  final bool? networkError;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmpasswordError;

  @override
  List<Object?> get props => [
        name,
        emailAddress,
        password,
        confirmpassword,
        submitting,
        submitted,
        serverError,
        timeOutError,
        networkError,
        nameError,
        emailError,
        passwordError,
        confirmpasswordError,
      ];

//<editor-fold desc="Data Methods">

  const SignUpMainState(
      {this.name,
      this.emailAddress,
      this.password,
      this.confirmpassword,
      this.submitting = false,
      this.serverError,
      this.nameError,
      this.emailError,
      this.networkError,
      this.passwordError,
      this.confirmpasswordError,
      this.timeOutError,
      this.submitted});

  bool isValid() {
    return nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmpasswordError == null &&
        name != null &&
        emailAddress != null &&
        password != null &&
        confirmpassword != null;
  }

  SignUpMainState copyWith(
      {String? emailAddress,
      String? password,
      String? confirmpassword,
      bool? submitting,
      bool? submitted,
      String? serverError,
      String? nameError,
      String? name,
      String? emailError,
      String? passwordError,
      bool? networkError,
      bool? timeOutError,
      String? confirmpasswordError}) {
    return SignUpMainState(
      name: name ?? this.name,
      nameError: nameError,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      confirmpassword: confirmpassword ?? this.confirmpassword,
      submitting: submitting ?? this.submitting,
      serverError: serverError,
      emailError: emailError,
      passwordError: passwordError,
      confirmpasswordError: confirmpasswordError,
      networkError: networkError,
      timeOutError: timeOutError,
      submitted: submitted,
    );
  }
}
