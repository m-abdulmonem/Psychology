import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/services/custom_widgets.dart';
import '/futures/auth/domain/models/client_model.dart';
import '/futures/chats/domain/models/group_model.dart';

class ChatItemWidget extends StatefulWidget {
  final Map<dynamic, dynamic> json;
  final String groupId;

  const ChatItemWidget({Key? key, required this.json, required this.groupId})
      : super(key: key);

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  late GroupModel group;

  @override
  void initState() {
    _loadModel();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChatItemWidget oldWidget) {
    _loadModel();
    super.didUpdateWidget(oldWidget);
  }

  void _loadModel() => setState(() => group = GroupModel.fromJson(widget.json));

  @override
  Widget build(BuildContext context) {
    if (widget.json.isNotEmpty) {
      return _buildChatItem();
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildChatItem() {
    var collection = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: collection.doc(CustomWidgets.isDoctor ? group.from : group.to).get().asStream(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return CustomText('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          ClientModel client = ClientModel.fromJson(data!);
          return ListTile(
            leading: client.photo != null
                ? _buildPicture(client)
                : const Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
            onTap: () => _onItemTaped(client),
            title: Text(
              "${!CustomWidgets.isDoctor ? "Dr.":""} ${client.name}",
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: CustomText(group.lastMsg ?? ""),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPicture(userChat) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        userChat.photo!,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
        loadingBuilder:
            (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                  color: Colors.grey,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null),
            );
          }
        },
        errorBuilder: (context, object, stackTrace) {
          return const Icon(Icons.account_circle, size: 70);
        },
      ),
    );
  }

  void _onItemTaped(userChat) => Get.toNamed("main/chat/conversation",
      arguments: {"user": userChat, "groupId": widget.groupId});
}
