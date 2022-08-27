import 'package:flutter/material.dart';
import 'message_stream_widget.dart';
import 'message_input.dart';

class ConversationBody extends StatefulWidget {
  final String groupId;
  const ConversationBody({Key? key,required this.groupId}) : super(key: key);

  @override
  State<ConversationBody> createState() => _ConversationBodyState();
}

class _ConversationBodyState extends State<ConversationBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      children:  [
        MessageStream(groupId: widget.groupId),
        InputMessageWidget(groupId: widget.groupId)
      ],
    ));
  }
}
