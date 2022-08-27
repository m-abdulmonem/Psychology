import '/core/services/custom_widgets.dart';
import '../../../manger/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginBody extends GetWidget<AuthController> {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Form(
        key: controller.authForm,
        child: Column(
          children: [
            VerticalSpace(Get.height * .15),
            SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Sign In",
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                  VerticalSpace(Get.height * .02),
                  const CustomText(
                    "Welcome Back",
                    fontSize: 14,
                    color: colorLightGrey,
                  ),
                ],
              ),
            ),
            VerticalSpace(Get.height * .07),
            CustomInput(
              label: "username",
              prefixIcon: CupertinoIcons.person,
              onSave: (val) => controller.auth = val!,
              validator: controller.requiredInput,
            ),
            VerticalSpace(Get.height * .02),
            CustomInput(
              label: "password",
              prefixIcon: CupertinoIcons.lock,
              onSave: (val) => controller.password = val!,
              validator: controller.requiredInput,
            ),
            VerticalSpace(Get.height * .03),
            CustomText(
              "Forget Password ?",
              onTap: () => Get.toNamed("auth/password/forget"),
              textAlign: TextAlign.right,
              width: Get.width,
            ),
            VerticalSpace(Get.height * .03),
            CustomButton(
              text: "Sign In",
              onTap: controller.signIn,
            ),
            VerticalSpace(Get.height * .1),
          ],
        ),
      ),
    );
  }
}
