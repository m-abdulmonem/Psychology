import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psychology/core/services/custom_widgets.dart';

class InputMessageWidget extends StatefulWidget {
  final String groupId;
  const InputMessageWidget({Key? key, required this.groupId}) : super(key: key);

  @override
  State<InputMessageWidget> createState() => _InputMessageWidgetState();
}

class _InputMessageWidgetState extends State<InputMessageWidget> {
  final focusNode = FocusNode();
  final _firestore = FirebaseFirestore.instance;
  final controller = TextEditingController();
  late String messageText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
            color: colorLightGrey.withOpacity(0.19),
            width: 1,
          )),
          color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  textInputAction: TextInputAction.send,
                  keyboardType: TextInputType.multiline,
                  focusNode: focusNode,
                  onSubmitted: (value) => _sendMessage(),
                  maxLines: null,
                  controller: controller,
                  onChanged: (value) {
                    messageText = value;
                  },
                  style: const TextStyle(color: colorLightGrey, fontSize: 15.0),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Type Something...',
                    hintStyle: TextStyle(color: colorLightGrey),
                  ),
                )),
          ),
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
                color: colorPrimary,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    controller.clear();
    await _firestore.collection('messages').add({
      'sender': email,
      'groupId' : widget.groupId,
      'text': messageText,
      'timestamp': Timestamp.now(),
    });
    await _firestore
        .collection('chats')
        .doc(widget.groupId)
        .update({"lastMsg": messageText});
  }

  String? get email => FirebaseAuth.instance.currentUser!.email;
}
