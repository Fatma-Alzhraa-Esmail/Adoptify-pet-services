// import 'package:csshadow/csshadow.dart';
// import 'package:custom_rounded_rectangle_border/custom_rounded_rectangle_border.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:pet_services_app/routers/navigator.dart';
// import 'package:pet_services_app/services/cart/widget/cart_product.dart';
// import 'package:pet_services_app/services/cart/widget/final_cart_product.dart';
// import 'package:pet_services_app/utilities/components/custom_btn.dart';
// import 'package:pet_services_app/utilities/theme/media.dart';

// class CompletedCartInfo extends StatefulWidget {
//   const CompletedCartInfo({super.key});

//   @override
//   State<CompletedCartInfo> createState() => _CompletedCartInfoState();
// }

// class _CompletedCartInfoState extends State<CompletedCartInfo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Cart",
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         leading: InkWell(
//             onTap: () {
//               CustomNavigator.pop();
//             },
//             child: Icon(Icons.arrow_back_ios)),
//       ),
//       body: SafeArea(
//           child: Container(
//             width: MediaHelper.width,
//             margin: EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               children: [
//                 Expanded(
//                   flex: 10,
//                   child: CustomPaint(
//                     willChange: true,
//                     painter: _TicketPainter(
//                       color: Colors.grey.shade300,
//                     ),
//                     child: Container(
//                       width: MediaHelper.width,
//                       height: MediaHelper.height,
//                       child: Stack(
//                         children: [
//                             Column(
//                           children: [
//                             Container(
//                               height: MediaHelper.height/2 -105,
//                               width: MediaHelper.width/2,
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     FinalCartProductWidget(),
//                                     FinalCartProductWidget(),
//                                     FinalCartProductWidget(),
//                                     FinalCartProductWidget(),
//                                   ],
//                                 ),
//                               ),
//                             ),
                           
                                        
                                        
                            
//                           ],
//                         ),
                      
//                         ],
//                       ),
//                     ),
//                     size: Size.infinite,
//                   ),
//                 ),
//                 Spacer(flex: 1),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                   child: CustomBtn(
//                     buttonColor: Colors.amber,
//                     text: "PAY NOW",
//                     height: 56,
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

// class _TicketPainter extends CustomPainter {
//   final Color color;

//   _TicketPainter({required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color // Use the provided color here
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0
//       ..strokeCap = StrokeCap.butt;

//     final path = Path()
//       ..lineTo(0, size.height / 2 - 20)
//       ..quadraticBezierTo(
//           size.width * 0.06, size.height / 2 , 0, size.height / 2 + 20)
//       ..lineTo(0, size.height / 2 + 130)
//       ..relativeQuadraticBezierTo(size.width * 0.06, 20, 0, 40)
//       ..lineTo(0, size.height)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width, size.height / 2 + 160)
//       ..quadraticBezierTo(size.width * 0.94, size.height / 2 + 140, size.width,
//           size.height / 2 + 120)
//       ..lineTo(size.width, size.height / 2 + 20)
//       ..quadraticBezierTo(
//           size.width * 0.94, size.height / 2, size.width, size.height / 2 - 20)
//       ..lineTo(size.width, 0)
//       ..lineTo(0, 0);
//     // ..lineTo(0, size.height)
//     // ..lineTo(size.width, size.height)
//     // ..lineTo(size.width, size.height / 2 + 20)
//     // ..quadraticBezierTo(
//     //     size.width * 0.90, size.height / 2, size.width, size.height / 2 - 20)
//     // ..lineTo(size.width, 0)
//     // ..lineTo(0, 0);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
// //
// // class CustomTicketShape extends CustomClipper<Path> {
// //   final Color color;

// //   CustomTicketShape({required this.color});
// //   @override
// //   Path getClip(Size size) {
// //     final paint = Paint()
// //       ..color = color // Use the provided color here
// //       ..style = PaintingStyle.stroke;

// //     final path = Path()
// //       ..lineTo(0, size.height / 2 - 20)
// //       ..quadraticBezierTo(
// //           size.width * 0.10, size.height / 2, 0, size.height / 2 + 20)
// //       ..lineTo(0, size.height)
// //       ..lineTo(size.width, size.height)
// //       ..lineTo(size.width, size.height / 2 + 20)
// //       ..quadraticBezierTo(
// //           size.width * 0.90, size.height / 2, size.width, size.height / 2 - 20)
// //       ..lineTo(size.width, 0);

// //     return (path);
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) {
// //     return true;
// //   }
// // }

// //
// class MySeparator extends StatelessWidget {
//   const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
//       : super(key: key);
//   final double height;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         final boxWidth = constraints.constrainWidth();
//         const dashWidth = 10.0;
//         final dashHeight = height;
//         final dashCount = (boxWidth / (2 * dashWidth)).floor();
//         return Flex(
//           children: List.generate(dashCount, (_) {
//             return SizedBox(
//               width: dashWidth,
//               height: dashHeight,
//               child: DecoratedBox(
//                 decoration: BoxDecoration(color: color),
//               ),
//             );
//           }),
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           direction: Axis.horizontal,
//         );
//       },
//     );
//   }
// }

// // class _TicketPainter extends CustomPainter {
// //   final Color color;

// //   _TicketPainter({required this.color});

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()
// //       ..color = color // Use the provided color here
// //       ..style = PaintingStyle.fill;

// //     // Custom ticket shape path
// //     final path = Path();
// //     path.moveTo(0, 20);
// //     path.lineTo(20, 0);
// //     path.lineTo(size.width - 20, 0);
// //     path.lineTo(size.width, 20);
// //     path.lineTo(size.width, size.height - 20);
// //     path.lineTo(size.width - 20, size.height);
// //     path.lineTo(20, size.height);
// //     path.lineTo(0, size.height - 20);
// //     path.close();

// //     canvas.drawPath(path, paint);
// //   }

// //   @override
// //   bool shouldRepaint(CustomPainter oldDelegate) {
// //     return false;
// //   }
// // }

// // Container(
// //                                   width: 200,
// //                                   height: 100,

// //                                   child: CustomPaint(
// //                                     painter: _TicketPainter(
// //                                       color: Colors
// //                                           .grey, // Set your desired color here
// //                                     ),
// //                                   ),

// //                                    decoration: BoxDecoration(
// //                                 // color: Color.fromARGB(255, 253, 253, 253),
// //                                 boxShadow: [
// //                                   BoxShadow(
// //                                     color: Colors.grey.withOpacity(0.4),
// //                                     spreadRadius: 1.7,
// //                                     blurRadius: 1.4,
// //                                     offset: Offset(0, 2),
// //                                   ),
// //                                 ],
// //                                 borderRadius: BorderRadius.circular(20.0)),
// //                                 )

// class _ClipShadowShadowPainter extends CustomPainter {
//   final BoxShadow shadow;
//   final CustomClipper<Path> clipper;

//   _ClipShadowShadowPainter({required this.shadow, required this.clipper});

//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = shadow.toPaint()
//       ..maskFilter = MaskFilter.blur(
//         BlurStyle.normal,
//         shadow.spreadRadius,
//       );
//     var clipPath = clipper.getClip(size).shift(shadow.offset);
//     canvas.drawPath(clipPath, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
