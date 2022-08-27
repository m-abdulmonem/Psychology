import 'package:flutter/material.dart';
import '../../utils/color.dart';


class CustomInput extends StatefulWidget {
  final String? hint, label;
  final Color? color,
      hintColor,
      labelColor,
      onFocusColor,
      txtErrorColor,
      prefixIconColor,
      enabledBorderColor;
  final bool? obscureText, autofocus;
  final TextStyle? labelStyle, hintStyle, style;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final void Function(String?)? onSave;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final double? radius;

  const CustomInput(
      {Key? key,
      this.hint,
      this.label,
      this.color,
      this.hintColor,
      this.labelColor,
      this.onFocusColor = colorPrimary,
      this.txtErrorColor = colorError,
      this.prefixIconColor,
      this.enabledBorderColor,
      this.obscureText,
      this.autofocus,
      this.labelStyle,
      this.hintStyle,
      this.style,
      this.controller,
      this.textInputAction,
      this.inputType,
      this.onSave,
      this.validator,
      this.prefixIcon,
      this.radius = 12})
      : super(key: key);

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  FocusNode? _focusNode;
  @override
  Widget build(BuildContext context) {
    return Focus(
        onFocusChange: (hasFocus) =>
            setState(() => hasFocus ? widget.onFocusColor : widget.color),
        child: TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          textInputAction: widget.textInputAction ?? TextInputAction.none,
          keyboardType: widget.inputType ?? TextInputType.text,
          style: widget.style ?? const TextStyle(
            color: colorLightGrey,
            letterSpacing: 1.1
          ),
          obscureText: widget.obscureText ?? false,
          onSaved: widget.onSave,
          validator: widget.validator,
          autofocus: widget.autofocus ?? false,
          decoration: InputDecoration(
              prefixIcon: Icon(
                widget.prefixIcon,
                color: _focusNode!.hasFocus
                    ? widget.onFocusColor
                    : widget.prefixIconColor,
              ),
              focusColor: widget.onFocusColor,
              focusedBorder: inputBorder,
              enabledBorder: inputBorderEnabled,
              focusedErrorBorder: errorInputBorder,
              errorBorder: errorInputBorder,
              errorStyle: TextStyle(
                  color: widget.txtErrorColor ?? colorError, fontSize: 15),
              labelText: widget.label,
              labelStyle: widget.labelStyle ??
                  TextStyle(
                    letterSpacing: 1.1,
                    color: _focusNode!.hasFocus
                        ? widget.onFocusColor
                        : widget.labelColor,
                  ),
              hintText: widget.hint,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                      letterSpacing: 1.1,
                      color: _focusNode!.hasFocus
                          ? widget.onFocusColor
                          : widget.hintColor)),
        ));
  }


  late OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.radius ?? 0),
    borderSide: BorderSide(
      color: widget.onFocusColor ?? colorLightGrey,
    ),
  );

  late OutlineInputBorder inputBorderEnabled = OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.radius ?? 0),
    borderSide: BorderSide(
      color: widget.enabledBorderColor ?? colorLightGrey,
    ),
  );

  late OutlineInputBorder errorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.radius ?? 0),
    borderSide: const BorderSide(
      color: colorError,
      width: 2.0,
    ),
  );

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }
}