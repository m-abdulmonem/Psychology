import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/services/custom_widgets.dart';
import '/core/services/db/fire_store_db.dart';
import '/futures/home/presentation/pages/home/widgets/doctor_widget.dart';
import '/futures/auth/domain/models/client_model.dart';
import '../manger/home_controller.dart';

class HomeBody extends GetWidget<HomeController> {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _getDoctorsList(),
    );
  }

  Widget _getDoctorsList() {
    return SizedBox(
      height: Get.height,
      child: _list(),
    );
  }

  Widget _list() {
    var _init = FirebaseFirestore.instance.collection(FireStoreDb.users);
    Stream<QuerySnapshot<Map<String, dynamic>>> query;
    if (controller.city.isNotEmpty) {
      query = _init
          .where("type", isEqualTo: "doctor")
          .where("city", isEqualTo: controller.city)
          .snapshots();
    } else {
      query = _init.where("type", isEqualTo: "doctor").snapshots();
    }
    return StreamBuilder(
        stream: query,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (streamSnapshot.hasData) {
            return ListView(
                children:
                    streamSnapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              final ClientModel doctor = ClientModel.fromJson(
                data,
              );
              return DoctorWidget(
                doctor: doctor,
                uuid: document.id,
              );
            }).toList());
          }
          return const NotFound();
        });
  }
}

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: const Center(
        child: CustomText("Not found doctors"),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: const Center(
        child: CircularProgressIndicator(
          color: colorPrimary,
        ),
      ),
    );
  }
}
