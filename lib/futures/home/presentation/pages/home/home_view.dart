import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'manger/home_controller.dart';
import '/core/services/custom_widgets.dart';
import 'widgets/home_body.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return const Scaffold(
      appBar: CustomAppBar(
        title: "Home",
      ),
      body:  HomeBody(),
    );
  }
}
