import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/services/custom_widgets.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key, this.sender, this.text, this.timestamp, this.isMe})
      : super(key: key);
  final String? sender;
  final String? text;
  final Timestamp? timestamp;
  final bool? isMe;
  final double radius = 50;

  @override
  Widget build(BuildContext context) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp!.seconds * 1000);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            giveUsername(sender!),
            style: const TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe!
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    topLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
            elevation: 0,
            color: isMe! ? colorPrimary : colorPrimary.withOpacity(.3),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    text!,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: isMe! ? Colors.white : Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      DateFormat('h:mm a').format(dateTime),
                      style: TextStyle(
                        fontSize: 9.0,
                        color: isMe!
                            ? Colors.white.withOpacity(0.5)
                            : const Color(0xff332B3A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String giveUsername(String email) {
    return email.replaceAll(RegExp(r'@g(oogle)?mail\.com$'), '');
  }
}
