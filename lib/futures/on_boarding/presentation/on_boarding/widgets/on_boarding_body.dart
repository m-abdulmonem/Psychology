import '/core/services/custom_widgets.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../manger/boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({Key? key}) : super(key: key);

  @override
  _OnBoardingBodyState createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  final BoardingController controller = Get.put(BoardingController());
  late bool isFinished = false;
  late double pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: PageView(
            onPageChanged: (page) => setState(() {
              isFinished = page == controller.items.length - 1;
              pageIndex = double.parse(page.toString());
            }),
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller.pageController,
            children: controller.items,
          ),
        ),
        SizedBox(
          width: Get.width,
          child: CustomText(
            isFinished ? "" : "Skip".toUpperCase(),
            textAlign: TextAlign.right,
            fontSize: 15,
            padding: EdgeInsets.only(top: Get.height * .08, right: 20),
            onTap: controller.save,
          )
        ),
        Positioned(
            bottom: 0,
            child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: colorOnBoardingPageIndex))),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DotsIndicator(
                      dotsCount: controller.items.length,
                      position: pageIndex,
                      decorator: const DotsDecorator(
                          color: colorOnBoardingPageIndex,
                          activeColor: colorPrimary),
                    ),
                    isFinished
                        ? CustomText(
                            "Finished".toUpperCase(),
                            onTap: controller.save,
                          )
                        : CustomText(
                            "NEXT",
                            onTap: controller.next,
                            color: colorPrimary,
                          )
                  ],
                )))
      ],
    );
  }
}
