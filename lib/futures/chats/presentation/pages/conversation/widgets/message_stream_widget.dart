import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble_widget.dart';

class MessageStream extends StatefulWidget {
  final String groupId;
  const MessageStream({Key? key,required this.groupId}) : super(key: key);

  @override
  State<MessageStream> createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("messages")
          .where("groupId",isEqualTo:  widget.groupId)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Widget> messageWidgets = snapshot.data!.docs.map<Widget>((m) {
          final data = m.data() as Map<dynamic, dynamic>;
          return MessageBubble(
            sender: data['sender'],
            text: data['text'],
            timestamp: data['timestamp'],
            isMe: email == data['sender'],
          );
        }).toList();

        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }

  String? get email => FirebaseAuth.instance.currentUser!.email;
}
