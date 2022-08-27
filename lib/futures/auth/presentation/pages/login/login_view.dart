import '/core/services/custom_widgets.dart';
import '../../manger/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/login_body.dart';
class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  CustomAppBar(),
      body: LoginBody(),
    );
  }
}
