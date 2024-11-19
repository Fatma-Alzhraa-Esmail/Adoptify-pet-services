// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';

// Widget defaultButton({
//   double width = 280,
//   double height = 50,
//   Color backgroundcolor = Colors.white,
//   required String text,
//   VoidCallback? onTap,
//   double border_width = 1,
//   required Color bordercolor,
//   required TextStyle stylee,
// }) =>
//     ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(backgroundcolor),
//         fixedSize: MaterialStateProperty.all<Size>(
//           Size(width, height),
//           // Size.fromHeight(43),
//           // Size.fromWidth(width)
//         ),
//         // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               side: BorderSide(color: bordercolor, width: border_width)),
//         ),
//       ),
//       // style: ElevatedButton.styleFrom(
//       //   fixedSize:
//       //       Size(100, 43), // change the button size

//       //   primary:
//       //       Colors.red, // change the background color
//       //   onPrimary: Colors.white, // change the text color
//       // ),
//       onPressed: onTap,
//       child: Text(
//         text,
//         style: stylee,
//       ),
//     );
