import 'package:flutter/material.dart';
import '/core/services/custom_widgets.dart';
import 'widgets/splash_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: colorPrimary,
      body:  SplashBody(),
    );
  }
}
