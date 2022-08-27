import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/services/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(const Index());
}

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Psychology',
      debugShowCheckedModeBanner: false,
      theme:  Themes.light,
      initialBinding: Binding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      translations: Translation(),
      locale: Locale(LanguageService().locale),
      fallbackLocale: Get.deviceLocale,
    );
  }
}
