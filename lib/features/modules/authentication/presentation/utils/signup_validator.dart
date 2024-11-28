import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';

class Signupvalidator {
  final AppLocalizations app_localizations;

  const Signupvalidator({required this.app_localizations});

  InputException? validateUserEmail(String email) {
    if (email.isEmpty) {
      return InputException(
          message: app_localizations.email_address_is_required);
    }

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return InputException(
          message: app_localizations.enter_a_valid_email_address);
    }

    return null;
  }

  InputException? validatePassword(String password) {
    if (password.isEmpty) {
      return InputException(message: app_localizations.password_cant_be_empty);
    }

    if (password.length < 6) {
      return InputException(
          message:
              app_localizations.password_must_be_at_least_six_characters_long);
    }

    final RegExp hasUpperCase = RegExp(r'[A-Z]');
    final RegExp hasLowerCase = RegExp(r'[a-z]');
    final RegExp hasDigit = RegExp(r'\d');
    final RegExp hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!hasUpperCase.hasMatch(password)) {
      return InputException(
          message:
              app_localizations.password_must_contain_at_least_one_uppercase);
    }

    if (!hasLowerCase.hasMatch(password)) {
      return InputException(
          message:
              app_localizations.password_must_contain_at_least_one_lowercase);
    }

    if (!hasDigit.hasMatch(password)) {
      return InputException(
          message: app_localizations.password_must_contain_at_least_one_number);
    }

    // if (!hasSpecialCharacter.hasMatch(password)) {
    //   return InputException(
    //       message: app_localizations
    //           .password_must_contain_at_least_one_special_character);
    // }

    return null; // Password is valid
  }

  InputException? validateConfirmPassword(
      String password, String confirmPassword) {
    if (password.isEmpty) {
      return InputException(message: app_localizations.password_cant_be_empty);
    }

    if (password.length < 6) {
      return InputException(
          message:
              app_localizations.password_must_be_at_least_six_characters_long);
    }

    final RegExp hasUpperCase = RegExp(r'[A-Z]');
    final RegExp hasLowerCase = RegExp(r'[a-z]');
    final RegExp hasDigit = RegExp(r'\d');
    final RegExp hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!hasUpperCase.hasMatch(password)) {
      return InputException(
          message:
              app_localizations.password_must_contain_at_least_one_uppercase);
    }

    if (!hasLowerCase.hasMatch(password)) {
      return InputException(
          message:
              app_localizations.password_must_contain_at_least_one_lowercase);
    }

    if (!hasDigit.hasMatch(password)) {
      return InputException(
          message: app_localizations.password_must_contain_at_least_one_number);
    }

    // if (!hasSpecialCharacter.hasMatch(password)) {
    //   return InputException(
    //       message: app_localizations
    //           .password_must_contain_at_least_one_special_character);
    // }
    if (password != confirmPassword) {
      return InputException(message: app_localizations.passwords_doesnt_match);
    }

    return null; // Password is valid
  }

  InputException? validateName(String name) {
    if (name.isEmpty) {
      return InputException(message: app_localizations.name_must_not_empty);
    }
    if (name.length < 3) {
      return InputException(
          message: app_localizations.name_at_least_3_characters_long);
    }
    return null; // Name is valid
  }

  InputException? validateDate(String date) {
    if (date.isEmpty) {
      return InputException(message: app_localizations.select_a_date);
    }
    final myDate = DateFormat('yyyy-MM-dd').parse(date).year;
    debugPrint((DateTime.now().year - myDate).toString());

    return null; // Name is valid
  }
}
