import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  ChatMessages(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      "form": idFrom,
      "to": idTo,
      "timestamp": timestamp,
      "content": content,
      "type": type,
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get("form");
    String idTo = documentSnapshot.get("to");
    String timestamp = documentSnapshot.get("timestamp");
    String content = documentSnapshot.get("content");
    int type = documentSnapshot.get("type");

    return ChatMessages(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}
