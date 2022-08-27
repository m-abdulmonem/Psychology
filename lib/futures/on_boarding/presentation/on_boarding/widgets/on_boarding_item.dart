import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/services/custom_widgets.dart';
class OnBoardingItem<T> extends StatelessWidget {
  final String? image,title,subTitle;
  const OnBoardingItem({Key? key,@required this.image,@required this.title,@required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.width * 0.5,
              child: Image.asset(image!)),
          VerticalSpace(Get.width *0.13),
          CustomText(title!,color: colorPrimary,),
          VerticalSpace(Get.width *0.04),
          CustomText(subTitle!,textAlign: TextAlign.center,color: colorLightGrey,)
        ],
      ),
    );
  }
}
