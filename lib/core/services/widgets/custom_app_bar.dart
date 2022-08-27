import 'package:google_fonts/google_fonts.dart';
import 'package:psychology/futures/auth/data/provider/auth_provider.dart';
import '/core/services/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double height;
  final bool? isBack;
  const CustomAppBar(
      {Key? key,
      this.height = kToolbarHeight,
      this.title = "",
      this.isBack = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: title != "Profile" && CustomWidgets.isDoctor
          ? GestureDetector(
              child: const Icon(Icons.person_pin),
              onTap: () => Get.toNamed("main/profile"),
            )
          : title == "Profile"
              ? GestureDetector(
                  child: const Icon(Icons.arrow_back),
                  onTap: () => Get.back(),
                )
              : Container(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 14.5),
          child: GestureDetector(
            child: const Icon(Icons.logout),
            onTap: () {
              AuthProvider().signOut();
              Get.offAllNamed("/auth");
            },
          ),
        )
      ],
      title: CustomText(
        title!.toUpperCase().tr,
        color: colorPrimary,
        textStyle: GoogleFonts.lato(),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
