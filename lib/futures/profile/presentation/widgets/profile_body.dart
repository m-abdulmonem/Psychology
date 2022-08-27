import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/services/custom_widgets.dart';
import '../../../../core/services/db/get_storage_keys.dart';
import '../../../auth/domain/models/client_model.dart';
import '../../../auth/domain/models/user_model.dart';
import '../manager/profile_controller.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController name = TextEditingController(),
      username = TextEditingController(),
      phone = TextEditingController(),
      price = TextEditingController();
  ClientModel? moreData;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfile();
    });
    super.initState();

  }



  getProfile() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value){
          moreData = ClientModel.fromJson(value.data() as Map<dynamic, dynamic>);

          name.value = TextEditingValue(text: profile!.displayName!);

          username.value = TextEditingValue(text: moreData!.username!);
          phone.value = TextEditingValue(text: moreData!.phone!);
          price.value = TextEditingValue(text: moreData!.price.toString().replaceAll("null", ""));
    });
  }

  UserModel? get profile {
    GetStorage storage = GetStorage();
    var key = GetStorageKeys.profileKey;
    return storage.hasData(key)
        ? UserModel.fromJson(storage.read(key) as Map, "", false)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14.5),
      child: Form(
        key: controller.authForm,
        child: Column(
          children: [
            VerticalSpace(Get.height * .05),
            VerticalSpace(Get.height * .02),
            CustomInput(
              prefixIcon: CupertinoIcons.person,
              label: "username",
              controller: username,
              textInputAction: TextInputAction.next,
              onSave: (val) => controller.username = val!,
              validator: controller.usernameValidate,
            ),
            VerticalSpace(Get.height * .02),
            CustomInput(
              prefixIcon: CupertinoIcons.phone,
              label: "Phone *",
              controller: phone,
              textInputAction: TextInputAction.next,
              inputType: TextInputType.phone,
              onSave: (val) => controller.phone = val!,
              validator: controller.phoneValidate,
            ),
            VerticalSpace(Get.height * .02),
            CustomInput(
              label: "name",
              controller: name,
              prefixIcon: CupertinoIcons.person,
              textInputAction: TextInputAction.next,
              onSave: (val) => controller.name = val!,
              validator: controller.nameValidate,
            ),
            VerticalSpace(Get.height * .02),
            CustomWidgets.isDoctor
                ? CustomInput(
                    label: "price",
                    controller: price,
                    prefixIcon: CupertinoIcons.money_dollar,
                    textInputAction: TextInputAction.next,
                    onSave: (val) => controller.price = val!,
                    // validator: controller.nameValidate,
                  )
                : Container(),
            VerticalSpace(Get.height * .025),
            CustomButton(
              text: "Save",
              onTap: controller.save,
            ),
            VerticalSpace(Get.height * .01),
          ],
        ),
      ),
    );
  }
}
