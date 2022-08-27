import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/core/services/custom_widgets.dart';
import 'chat_item_widget.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _init = FirebaseFirestore.instance.collection("chats");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: !CustomWidgets.isDoctor
          ? _init.where("from", isEqualTo: uid).snapshots()
          : _init.where("to", isEqualTo: uid).snapshots(),
      builder: (context, snapshot) =>
          snapshot.hasData ? _buildWidget(snapshot) : _buildNotFound(),
    );
  }

  Widget _buildNotFound() {
    return const Center(
      child: CustomText(
        "No chats yet",
        fontSize: 25,
      ),
    );
  }

  Widget _buildWidget(snapshot) {
    List<Widget> messageWidgets = snapshot.data!.docs.map<Widget>((m) {
      final data = m.data() as Map<dynamic, dynamic>;
      return ChatItemWidget(json: data, groupId: m.id);
    }).toList();

    return SingleChildScrollView(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: messageWidgets,
      ),
    );
  }
}
