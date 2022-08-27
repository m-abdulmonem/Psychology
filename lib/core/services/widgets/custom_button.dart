import '../custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor, borderColor;
  final double? width, height, fontSize;
  final VoidCallback? onTap, onLongTap;
  const CustomButton(
      {Key? key,
      required this.text,
      this.onTap,
      this.onLongTap,
      this.width,
      this.height = 50,
      this.fontSize = 20,
      this.backgroundColor = colorPrimary,
      this.borderColor = colorPrimary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor!),
          borderRadius: BorderRadius.circular(50),
        ),
        child: CustomText(
          text,
          fontSize: fontSize,
          width: width ?? Get.width,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          color: backgroundColor == Colors.transparent
              ? borderColor
              : Colors.white,
        ),
      ),
    );
  }
}
