import 'package:flutter/material.dart';
import '/core/services/custom_widgets.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      // radioTheme: RadioThemeData(
      //   overlayColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      //   fillColor: MaterialStateColor.resolveWith((states) => colorPrimary),
      //
      // ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: colorLightGrey,
          ),
          actionsIconTheme: IconThemeData(
            color: colorLightGrey,
          ),
          titleTextStyle: TextStyle(
              color: colorPrimary, fontWeight: FontWeight.bold, fontSize: 19)));

  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    primaryColor: Colors.black45,
    textTheme: const TextTheme().copyWith(),
    primaryTextTheme: const TextTheme().copyWith(),
  );
}
