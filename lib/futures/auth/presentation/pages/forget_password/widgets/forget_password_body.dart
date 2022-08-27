import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/services/custom_widgets.dart';
import '../../../manger/auth_controller.dart';

class ForgetPasswordBody extends GetWidget<AuthController> {
  const ForgetPasswordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.authForm,
        child: Column(
          children: [
            CustomInput(
              label: "auth",
              onSave: (val) => controller.auth = val!,
              validator: controller.emailValidate,
            ),
            CustomButton(
              text: "Send Reset Link",
              onTap: controller.forgetPassword,
            )
          ],
        ),
      ),
    );
  }
}
