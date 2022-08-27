import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psychology/futures/auth/domain/models/client_model.dart';
import '/core/services/custom_widgets.dart';
import 'widgets/conversation_body.dart';
import 'package:flutter/material.dart';

class ConversationView extends StatefulWidget {
  const ConversationView({Key? key}) : super(key: key);

  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  ClientModel? clientModel;
  String name = "";
  final args = Get.arguments;
  @override
  void initState() {
    name = "${!CustomWidgets.isDoctor ? "Dr. ":""}${args['user'].name}";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => Get.back(),
        ),
        title: CustomText(
          name.toUpperCase().tr,
          color: colorPrimary,
          textStyle: GoogleFonts.lato(),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      body: ConversationBody(groupId:args['groupId']),
    );
  }
}
