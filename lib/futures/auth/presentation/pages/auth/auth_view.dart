import '../../manger/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/auth_body.dart';
class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBody(),
    );
  }
}
