import 'package:flutter/material.dart';
import 'package:psychology/core/services/custom_widgets.dart';
import 'widgets/profile_body.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Profile"),
      body: ProfileBody(),
    );
  }
}
