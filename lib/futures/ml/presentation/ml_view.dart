import 'package:flutter/material.dart';
import '../../../core/services/custom_widgets.dart';
import 'widgets/prediction_body.dart';

class MlView extends StatefulWidget {
  const MlView({
    Key? key
  }) : super(key: key);

  @override
  MlViewState createState() => MlViewState();
}

class MlViewState extends State<MlView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Recorder",),
      body: PredictionBody(),
    );
  }
}
