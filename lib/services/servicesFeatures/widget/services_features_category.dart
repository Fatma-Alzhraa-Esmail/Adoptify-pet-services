// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:pet_services_app/services/servicesFeatures/bloc/cubit.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:pet_services_app/services/servicesFeatures/model/service_model.dart';

// class ServicesCategoryWidget extends StatefulWidget {
//   String category;
//   // String categoryImage;
//   int index = 0;
//   ServicesCategoryWidget(BuildContext context, this.category
//   // ,this.categoryImage,
//    );
//   @override
//   State<ServicesCategoryWidget> createState() => _ServicesCategoryWidgetState();
// }

// class _ServicesCategoryWidgetState extends State<ServicesCategoryWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // setState(() {
//         //   widget.category.isSelected = !widget.category.isSelected;
//         // });
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(left: 16, top: 4, bottom: 8),
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               // border: Border.all(
//               //     color: widget.category.isSelected
//               //         ? Colors.amber
//               //         : Colors.transparent,
//               //     width: widget.category.isSelected?2:0),
//               color: Colors.white,
             
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.4),
//                   spreadRadius: 1,
//                   blurRadius: 1.4,
//                   offset: Offset(0, 2),
//                 ),
//               ]),
//           height: 86,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // Container(
//                 //   width: 50,
//                 //   height: 38,
//                 //   child: Image.asset(
//                 //     '${widget.categoryImage}',
//                 //     fit: BoxFit.cover,
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: 3,
//                 ),
//                 Text(
//                   widget.category,
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),



                
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   buildItem(ServicesModel productsBasedCategories, context) {
//     return InkWell(
//       onTap: () {
//         // navigateToWithReturn(context, ProductDetails(productsBasedCategories));
//       },
//       child: StreamBuilder<String?>(
//           // stream: ,
//           builder: (context, snapshot) {
//             return Column(
//               children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(right: 5, left: 5, bottom: 10),
//                   child: Container(
//                     height: 250,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       // color: HexColor('e4dddd'),
//                       color: HexColor('2f2f2f'),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15)
//                               ),
//                               height: 150,
//                               width: 150,
//                               // width: MediaQuery.of(context).size.width,
//                               child: Image.network(
//                                 productsBasedCategories.image.toString(),
//                                 // fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                   width: 300,
//                                   child: Text(
//                                     productsBasedCategories.title.toString(),
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   )),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Container(
//                               child: Text(
//                             productsBasedCategories.description.toString(),
//                             style: TextStyle(
//                                 overflow: TextOverflow.ellipsis,
//                                 color: Colors.white),
//                           )),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     productsBasedCategories.rating!.rate.toString(),
//                                     style: TextStyle(
//                                         color:HexColor('ff9900'),
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   RatingBar.builder(
//                                     initialRating: productsBasedCategories.rating!.rate,
//                                     minRating: 1,
//                                     direction: Axis.horizontal,
//                                     allowHalfRating: true,
//                                     itemCount: 5,
//                                     itemSize: 18,
//                                     itemPadding:
//                                         EdgeInsets.symmetric(horizontal: 4.0),
//                                     itemBuilder: (context, _) => Icon(
//                                       Icons.star,
//                                       color:HexColor('ff9900'),
//                                     ),
//                                     onRatingUpdate: (rating1) {
//                                       print(rating1);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 productsBasedCategories.rating!.count.toString(),
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),         
//               ],
//             );
//           }),
//     );
//   }

// }
