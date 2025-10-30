import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../values/values.dart';

class Validators {
  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.localization.validatorsEmailRequired;
    }
    if (!Values.emailRegex.hasMatch(value)) {
      return context.localization.validatorsInvalidEmail;
    }
    return null; // valid
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.length < 6) {
      return context.localization.validatorLongPassword;
    }
    return null;
  }

  static String? validateConfirmPassword(
    BuildContext context, {
    required String? confirmedPasssword,
    required String password,
  }) {
    if (confirmedPasssword != password) {
      return context.localization.validatorPasswordsNotMatch;
    }
    return null;
  }

  static String? validatePasswordForLogin(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.localization.validatorsPasswordRequired;
    }
    return null;
  }

  static String? validateFullName(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.localization.validatorsNameRequired;
    }
    if (value.length < 4) {
      return context.localization.validatorLongName;
    }
    return null;
  }

  static String? validatePhone(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.localization.validatorsPhoneRequired;
    }
    return null;
  }

  static String? validateNotEmpty(
    BuildContext context,
    String? value,
    String message,
  ) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}
