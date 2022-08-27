import 'package:flutter/material.dart';
import 'widgets/on_boarding_body.dart';

class BoardingView extends StatelessWidget{
  const BoardingView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnBoardingBody(),
    );
  }
}
