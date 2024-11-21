// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TextInputField extends StatefulWidget {
  TextInputField({
    super.key,
    this.onChange,
    this.controller,
    this.inputFormatters = const [],
    this.errorText,
    this.hintText,
    this.initialValue,
    this.withBottomPadding = true,
    this.hasError = false,
    this.keyboardType,
    this.suffixIcon,
    this.maxLines = 0,
    this.maxLength,
    // this.topIcon,
    this.top_label_text,
    this.label,
    this.onTap,
  });
  final String? hintText;
  final String? errorText;
  final bool hasError;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final bool withBottomPadding;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter> inputFormatters;
  // final Widget? topIcon;
  final String? top_label_text;
  final String? label;
  final Function()? onTap;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool showText = true;
  String? value;
  _mapSuffixIcon() {
    if (widget.keyboardType == null) {
      return null;
    } else if (widget.keyboardType == TextInputType.visiblePassword) {
      return GestureDetector(
        child: showText
            ? Icon(
                Icons.visibility,
                color:widget.hasError?LightTheme().error: Colors.grey.shade400,
              )
            : Icon(Icons.visibility_off, color:widget.hasError?LightTheme().error: Colors.grey.shade400),
        onTap: () {
          setState(() {
            showText = !showText;
          });
        },
      );
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
    showText = widget.keyboardType != TextInputType.visiblePassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.408,
              height: 1.38,
              ),
          cursorColor: LightTheme().mainColor,
          controller: widget.controller,
          initialValue: widget.controller != null ? null : widget.initialValue,
          onChanged: (val) {
            setState(() {
              if (val.isNotEmpty) {
                value = val;
              } else {
                value = null;
              }
            });
            widget.onChange?.call(val);
          },
          onTap: () {
            setState(() {
              widget.onTap;
            });
          },
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:widget.hasError?LightTheme().error: Colors.grey.shade400, width: 1),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:widget.hasError?LightTheme().error: LightTheme().mainColor, width: 1),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:widget.hasError?LightTheme().error: LightTheme().error, width: 1),
            ),
            suffixIcon: widget.suffixIcon ?? _mapSuffixIcon(),
            suffixIconColor: Colors.grey,
            labelText: widget.label,
            
            labelStyle: TextStyle(
                color:widget.hasError?LightTheme().error: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.w400),
            hoverColor: Colors.black,
            fillColor: Colors.black,
            focusColor: Colors.black,
          ),
          obscureText: !showText,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          inputFormatters: widget.inputFormatters,
        ),
        if (widget.hasError) const SizedBox(height: 6),
        if (widget.hasError)
          Row(
            children: [
              
              Text(widget.errorText ?? "Error",
                  style: const TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.w400,height: 1.38,letterSpacing: 0.408)),
            ],
          ),
        if (widget.withBottomPadding) const SizedBox(height: 16),
      ],
    );
  }
}
