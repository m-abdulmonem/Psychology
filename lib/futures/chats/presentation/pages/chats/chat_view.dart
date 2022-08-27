import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/services/custom_widgets.dart';

import 'widgets/chat_body.dart';

class ChatView extends StatefulWidget {
  final String? type;

  const ChatView({Key? key, this.type}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: !CustomWidgets.isDoctor
            ? GestureDetector(
                child: const Icon(Icons.arrow_back),
                onTap: () => Get.back(),
              )
            : Container(),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 14.5),
        //     child: GestureDetector(
        //       child: const Icon(Icons.logout),
        //       onTap: () {
        //         AuthProvider().signOut();
        //         Get.offAllNamed("/auth");
        //       },
        //     ),
        //   )
        // ],
        title: CustomText(
          "Chats".toUpperCase().tr,
          color: colorPrimary,
          textStyle: GoogleFonts.lato(),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      body: const ChatBody(),
    );
  }
}
