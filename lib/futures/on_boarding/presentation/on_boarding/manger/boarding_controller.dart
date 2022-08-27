import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/core/services/db/get_storage_keys.dart';
import '../widgets/on_boarding_item.dart';

class BoardingController extends GetxController {
  PageController? pageController;
  bool? isFinished = false;
  final int duration = 600;
  int? count = 0;

  final items = [
    const OnBoardingItem(
      image: "assets/images/onboarding1.png",
      title: 'Identities of Mental illness',
      subTitle:
          'Doing What Matters in Times of Stress: An Illustrated Guide is a stress management guide for coping with adversity.',
    ),
    const OnBoardingItem(
      image: "assets/images/onboarding2.png",
      title: 'Defining mental illness from your sound',
      subTitle: 'Psychologists have long known that certain mental health issues can be detected by listening not only to what a person says but how they say it, said Maria Espinola'
    ),
  ];


  @override
  void onInit() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        update();
      });
    super.onInit();
  }

  void next(){
    pageController?.nextPage(
        duration: Duration(milliseconds: duration), curve: Curves.easeIn);
  }

  void save() {
    GetStorage().write(GetStorageKeys.isOnBoardingKey, true);
    Get.offNamed("auth");
  }
}
