import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:psychology/futures/auth/presentation/manger/validator.dart';

class ProfileController extends GetxController with Validator{
  final GlobalKey<FormState> authForm = GlobalKey<FormState>();
  String name = "",
      username = "",
      phone = "",
      price = "";


  get form => authForm.currentState;

  void save() async{
    if (form!.validate()) {
      form.save();
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "name" : name,
        "username" : username,
        "phone" : phone,
        "price" : price
      }).then((value) => _showSnackBar());
    }


  }

  void _showSnackBar() {
    Get.snackbar('Success', 'Data saved successfully',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING);
  }
}