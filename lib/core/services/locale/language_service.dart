import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageService{
  final _storage = GetStorage();
  final _key = 'locale';

  bool get isRTL => _loadLocale() == "ar";
  /// Get isDarkMode info from local storage and return ThemeMode
  String get locale => _loadLocale();

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  String _loadLocale() => _storage.read(_key) ?? Get.deviceLocale.toString().split("_")[0];

  /// Save isDarkMode to local storage
  _saveLocale(String locale) =>
    _storage.write(_key, locale);

  /// Switch theme and save to local storage
  void switchLocale(String locale) {
    Get.updateLocale(Locale(locale));
    _saveLocale(locale);
  }
}