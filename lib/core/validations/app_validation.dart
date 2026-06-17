import 'package:easy_localization/easy_localization.dart';

class AppValidator {
  static noValidation() {
    return null;
  }

  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter_your_email'.tr();
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'enter_valid_email'.tr();
    }
    return null;
  }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter_your_password'.tr();
    }
    if (value.length < 6) {
      return 'password_at_least6'.tr();
    }
    return null;
  }

  static String? phoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter_phone_number'.tr();
    }
    if (!RegExp(r'^\(\d{3}\) \d{3}-\d{4}$').hasMatch(value)) {
      return "enter_valid_number".tr();
    }
    return null;
  }

  static String? nameValidation(String? name) {
    if (name == null || name.isEmpty) {
      return 'name_required'.tr();
    }
    return null;
  }

  static String? addressValidation(String? address) {
    if (address == null || address.isEmpty) {
      return 'LocaleKeys.addressRequired.tr()';
    }
    return null;
  }

  static String? zipCodeValidation(String? zipCode) {
    if (zipCode == null || zipCode.isEmpty) {
      return 'LocaleKeys.zipCodeRequired.tr()';
    }
    if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(zipCode)) {
      return 'LocaleKeys.enterValidZipCode.tr()';
    }
    return null;
  }
}
