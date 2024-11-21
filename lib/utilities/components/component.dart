import 'package:flutter/material.dart';

Widget defaultTextForm({
  double width = 293,
  required String hint,
  Icon? prefix,
  bool obscure = true,
  Widget? suffix,
  var controller,
}) =>
    Container(
      height: 46,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.white,
          filled: true,
          hoverColor: Colors.amber,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.only(top: 0, left: 25),
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
        onFieldSubmitted: (value) {
          print(value);
        },
        onChanged: (value) {
          print(value);
        },
        obscureText: obscure,
      ),
    );

Widget socail(String img) => Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Image(image: AssetImage(img)),
    );

Widget TitleHeadLine(String txt1, String txt2) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          txt1,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            txt2,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.amber[600],
              fontSize: 16,
            ),
          ),
        )
      ],
    ),
  );
}
