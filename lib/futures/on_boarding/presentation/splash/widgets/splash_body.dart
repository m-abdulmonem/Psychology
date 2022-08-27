import '/core/services/custom_widgets.dart';
import '../manger/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void initState() {
    super.initState();
    _animation();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _animation() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    fadingAnimation =
        Tween<double>(begin: 0.1, end: 1).animate(animationController!)
          ..addListener(() {
            setState(() {
              if (animationController!.isCompleted) {
                animationController?.repeat(reverse: true);
              }
            });
          });
    animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        child: FadeTransition(
            opacity: fadingAnimation!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  "Psychology",
                  fontSize: 50,
                  color: Colors.white,
                ),
                GetBuilder<SplashController>(builder: (controller) {
                  return const CustomText("");
                }),
              ],
            )));
  }
}
