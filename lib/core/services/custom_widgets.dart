export 'widgets/custom_input.dart';
export 'widgets/custom_text.dart';
export 'widgets/custom_spacing.dart';
export 'widgets/custom_button.dart';
export 'widgets/custom_app_bar.dart';
export '../utils/color.dart';
export '../utils/function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/core/services/db/get_storage_keys.dart';
import 'locale/language_service.dart';

class CustomWidgets {
  static final storage = GetStorage();
  static bool get isRTL => LanguageService().isRTL;

  static bool get isLoggedIn =>
      storage.hasData(GetStorageKeys.isLoggedInKey) &&
      storage.read(GetStorageKeys.isLoggedInKey);

  static String get accountType{
    var key = GetStorageKeys.accountTypeKey;
    return storage.hasData(key) ? storage.read(key) : "client";
  }
  static bool get isDoctor => (accountType == "doctor");

  static bool get isBoarding =>
      storage.hasData(GetStorageKeys.isOnBoardingKey) &&
      storage.read(GetStorageKeys.isOnBoardingKey);

  static void snackBar(content, duration) =>
      ScaffoldMessenger.of(Get.context!).showSnackBar(snack(content, duration));

  static SnackBar snack(content, duration) => SnackBar(
        content: Container(
          height: Get.height * .1,
          alignment: Alignment.center,
          child: content,
        ),
        duration: Duration(seconds: duration),
        backgroundColor: Colors.blueGrey,
      );
}
