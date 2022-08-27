import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_widgets.dart';

class CustomText extends StatelessWidget {
  final String data;
  final Color? color;
  final bool? upperCase;
  final double? fontSize,width;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  const CustomText(this.data,
      {Key? key,
      this.color = colorPrimaryBlack,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w100,
      this.textAlign, this.width, this.onTap, this.padding, this.upperCase = false, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Container(
        padding: padding,
        width: width,
        child: Text(
          upperCase! ? data.toUpperCase() : data,
          style: textStyle ?? TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: fontSize,
            color: Get.isDarkMode ? Colors.white : color,
            fontWeight: FontWeight.normal,
            letterSpacing: 1.1,
          ),
          textDirection: TextDirection.rtl,
          textAlign: textAlign ?? (CustomWidgets.isRTL ? TextAlign.right : TextAlign.left),
        ),
      ),
    );
  }
}
