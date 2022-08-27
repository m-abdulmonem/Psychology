
import '/futures/ml/presentation/ml_view.dart';
import '../../home/home_view.dart';
import '/futures/chats/presentation/pages/chats/chat_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController{

  int selectedView = 0;

  List<Widget> views = <Widget>[
    const HomeView(),
    const MlView(),
    const ChatView(),
  ];

  void onItemTapped(int index) {
    selectedView = index;
    update();
  }

}