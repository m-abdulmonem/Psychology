import 'package:flutter/material.dart';
import '/core/services/custom_widgets.dart';
import 'widgets/register_body.dart';
class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Register Screen",),
      body: RegisterBody(),
    );
  }
}
