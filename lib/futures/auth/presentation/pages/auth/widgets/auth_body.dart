import '/core/services/custom_widgets.dart';
import '../../../manger/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthBody extends GetWidget<AuthController> {
  const AuthBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          VerticalSpace(Get.height * .08),
          CustomText(
            "Skip".toUpperCase(),
            textAlign: TextAlign.right,
            width: Get.width,
            color: colorPrimaryBlack,
            fontWeight: FontWeight.bold,
            onTap: controller.signInAnon,
          ),
          VerticalSpace(Get.height * .1),
          Column(
            children: [
              Image.asset("assets/images/logo.png"),
              VerticalSpace(Get.height * .04),
              const CustomText(
                "Psychology",
                color: colorPrimaryBlack,
                fontSize: 25,
              ),
              VerticalSpace(Get.height * .01),
              const CustomText(
                "Welcome back",
                color: colorLightGrey,
                fontSize: 17,
              )
            ],
          ),
          VerticalSpace(Get.height * .1),
          CustomButton(
            text: "Login",
            onTap: () => Get.toNamed("auth/login"),
          ),
          const VerticalSpace(20),
          CustomButton(
            text: "Register",
            backgroundColor: Colors.transparent,
            borderColor: colorPrimaryBlack,
            onTap: () => Get.toNamed("auth/register"),
          ),
          VerticalSpace(Get.height * .1),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: controller.signInWithFacebook,
                    icon: Image.asset("assets/images/face.png")),
                HorizontalSpace(Get.width * .05),
                IconButton(
                    onPressed: controller.signInWithGoogle,
                    icon: Image.asset("assets/images/google.png"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
