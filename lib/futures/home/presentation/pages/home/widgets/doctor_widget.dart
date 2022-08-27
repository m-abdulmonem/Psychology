import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '/futures/auth/domain/models/client_model.dart';
import '/core/services/custom_widgets.dart';
import 'dart:math' as math;

class DoctorWidget extends StatefulWidget {
  final ClientModel doctor;
  final String uuid;
  const DoctorWidget({Key? key, required this.doctor, required this.uuid})
      : super(key: key);

  @override
  _DoctorWidgetState createState() => _DoctorWidgetState();
}

class _DoctorWidgetState extends State<DoctorWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ListTile(
          onTap: _onTap,
          onLongPress: _makeCall,
          isThreeLine: true,
          dense: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Dr ${widget.doctor.name!}",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          leading: widget.doctor.photo != null
              ? Image.network(widget.doctor.photo!)
              : CircleAvatar(
                  child: CustomText(
                    "Dr. ${widget.doctor.name![0].toUpperCase()}",
                    color: Colors.white,
                  ),
                  backgroundColor:
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                  radius: 25,
                ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RatingBarIndicator(
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 20,
                        rating: 3.5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color(0xffF1C40F),
                            ))
                  ],
                ),
                const VerticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const CustomText("Price"),
                        const VerticalSpace(10),
                        CustomText("${widget.doctor.price} EGP")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText("Location"),
                        const VerticalSpace(10),
                        CustomText("${widget.doctor.city}")
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _makeCall() async {
    if (!await launchUrl(Uri.parse('tel:${widget.doctor.phone}'))) throw 'Could not launch tel:${widget.doctor.phone}';
  }

  void _onTap() async {
    var _init = FirebaseFirestore.instance.collection("chats");

    final group = await _init
        .where("from", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where("to", isEqualTo: widget.doctor.uid)
        .limit(1)
        .get();

    Map<String, dynamic> data = {
      "user": widget.doctor,
    };

    // print(group.docs.first.exists);
    if (group.docs.isNotEmpty) {
      data['groupId'] = group.docs.first.id;
    } else {
      final newChat = await _init.add({
        "from": FirebaseAuth.instance.currentUser?.uid,
        "to": widget.doctor.uid
      });

      data['groupId'] = newChat.id;
    }

    // print(data);
    Get.toNamed("main/chat/conversation", arguments: data);
  }
}
