import 'package:get/get.dart';

class Validator {
  String? emailValidate(String? val) {
    if (!GetUtils.isEmail(val!)) return "Email Is not Valid".tr;
    return null;
  }

  String? requiredInput(String? val) => (val == null) ? "Input required" : null;

  String? usernameValidate(String? val) {
    if (val!.length < 4) return "Username less then 4 char".tr;
    return null;
  }

  String? passwordValidate(String? val) {
    if (val!.length < 8) return "Password less than 8 chars".tr;
    if (val.isEmpty) return "Password required".tr;
    return null;
  }

  String? phoneValidate(String? val) {
    if (val == null) return "Phone number required";
    if (!val.isPhoneNumber) return "Phone number incorrect format";
    return null;
  }

  String? repeatPasswordValidate(String? val) {
    // if (!GetUtils.isEmail(val!)) return "Email Is not Valid";
    return null;
  }

  String? nameValidate(String? val) {
    if (val!.length < 5) return "Name incorrect".tr;
    return null;
  }

  String? typeValidate(String? val) {
    if (val == null) return "Account type required";
    return null;
  }
}
