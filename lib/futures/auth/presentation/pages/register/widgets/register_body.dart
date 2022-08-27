import '/core/services/custom_widgets.dart';
import '../../../manger/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterBody extends GetWidget<AuthController> {
  final double width = Get.width - 29;
  RegisterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14.5),
      child: Form(
        key: controller.authForm,
        child: Column(
          children: [
            VerticalSpace(Get.height * .05),
            SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Sign Up",
                    color: colorPrimary,
                    fontSize: 25,
                  ),
                  VerticalSpace(Get.height * .02),
                  const CustomText(
                    "Create New Account",
                    color: colorLightGrey,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            VerticalSpace(Get.height * .03),
            CustomInput(
              prefixIcon: CupertinoIcons.mail,
              label: "email",
              textInputAction: TextInputAction.next,
              inputType: TextInputType.emailAddress,
              onSave: (val) => controller.email = val!,
              validator: controller.emailValidate,
            ),
            VerticalSpace(Get.height * .02),
            CustomInput(
              prefixIcon: CupertinoIcons.person,
              label: "username",
              textInputAction: TextInputAction.next,
              onSave: (val) => controller.username = val!,
              validator: controller.usernameValidate,
            ),
            VerticalSpace(Get.height * .02),
            CustomInput(
              prefixIcon: CupertinoIcons.phone,
              label: "Phone *",
              textInputAction: TextInputAction.next,
              inputType: TextInputType.phone,
              onSave: (val) => controller.phone = val!,
              validator: controller.phoneValidate,
            ),
            VerticalSpace(Get.height * .02),
            CustomInput(
              label: "name",
              prefixIcon: CupertinoIcons.person,
              textInputAction: TextInputAction.next,
              onSave: (val) => controller.name = val!,
              validator: controller.nameValidate,
            ),
            VerticalSpace(Get.height * .02),
            CustomInput(
              label: "password *",
              prefixIcon: CupertinoIcons.lock,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSave: (val) => controller.password = val!,
              validator: controller.passwordValidate,
            ),
            VerticalSpace(Get.height * .05),
            GetBuilder<AuthController>(
                builder: (con) => Column(
                      children: [
                        CustomText(
                          "Select Account Type",
                          textAlign: TextAlign.left,
                          width: Get.width,
                          color: colorPrimaryBlack,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: RadioListTile(
                                value: "patient",
                                groupValue: controller.type,
                                onChanged: controller.selectType,
                                title: CustomText(
                                  "Patient".tr,
                                  color: colorPrimaryBlack,
                                ),
                                activeColor: colorPrimary,
                                contentPadding: EdgeInsets.zero,
                              ),
                              width: width / 2,
                            ),
                            SizedBox(
                              child: RadioListTile(
                                value: "doctor",
                                groupValue: controller.type,
                                onChanged: controller.selectType,
                                title: CustomText(
                                  "Doctor".tr,
                                  color: colorPrimaryBlack,
                                ),
                                activeColor: colorPrimary,
                                contentPadding: EdgeInsets.zero,
                                selectedTileColor: Colors.transparent,
                              ),
                              width: width / 2,
                            )
                          ],
                        )
                      ],
                    )),
            VerticalSpace(Get.height * .025),
            CustomButton(
              text: "Sing Up",
              onTap: controller.signUp,
            ),
            VerticalSpace(Get.height * .01),
          ],
        ),
      ),
    );
  }
}
