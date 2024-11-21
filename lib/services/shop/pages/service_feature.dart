// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pet_services_app/services/shop/bloc/shop_cubit.dart';
// import 'package:pet_services_app/services/shop/bloc/shop_state.dart';

// // class ShopFeature extends StatefulWidget {
// //   const ShopFeature({super.key});

// //   @override
// //   State<ShopFeature> createState() => _ShopFeatureState();
// // }

// // class _ShopFeatureState extends State<ShopFeature> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //        appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         leading: InkWell(
// //             onTap: () {
// //               CustomNavigator.pop();
// //             },
// //             child: Icon(Icons.arrow_back_ios)),
// //         title: Text(
// //           'Account Info',
// //           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
// //         ),
// //         centerTitle: true,
// //         elevation: 0.0,
// //       ),
// //     );
// //   }
// // }

// class ShopFeature extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var isSelected = true;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Shop"),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           BlocProvider(
//             create: (BuildContext context) => ShopCubit(),
//             child: BlocBuilder<ShopCubit, ShopStates>(
//               //  bloc:ShopCubit()..getProductsByCategory(),
//               builder: (context, ShopStates state) {
//                 final shopCubit = BlocProvider.of<ShopCubit>(context);
//                 var selectedCategory = shopCubit.selectedCat;
//                 final products = selectedCategory != null
//                     ? shopCubit.getProductsByCategory(
//                         categoryId: selectedCategory.id)
//                     : shopCubit.getProductsByCategory();
//                 if (state is Loading) {
//                   return CircularProgressIndicator();
//                 } else if (state is Error) {
//                   return Text("data");
//                 }
//                 else{
                  
//                   return Column(
//                     children: [
//                       // Display categories
//                       Row(
//                         children: shopCubit.getMainCategories().map((category) {
//                           isSelected = selectedCategory?.id == category.id;
//                           print(selectedCategory?.id);
//                           print(category.id);
//                           return GestureDetector(
//                             onTap: () => shopCubit.selectCategory(category),
//                             child: Container(
//                               width: 100,
//                               height: 150,
//                               decoration: BoxDecoration(
//                                 // color: Colors.amber,
//                                 border: isSelected
//                                     ? Border(
//                                         bottom: BorderSide(
//                                           width: 2.0,
//                                           color: Colors.blue,
//                                         ),
//                                       )
//                                     : null,
//                               ),
//                               padding: EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Text(category.title),
//                                   Image.asset('${category.imageUrl}')
//                                 ],
//                               ),
//                             ),
//                           );
                       
//                         }).toList(),
                        
//                       ),
                      

//                       // Display related products
//                       Column(
//                         children: products.map((product) {
//                           return ListTile(
//                             leading: Image.asset("${product.imageUrl}"),
//                             title: Text(product.name),
//                             subtitle: Text(product.description ?? ''),
//                             trailing:
//                                 Text('\$${product.price.toStringAsFixed(2)}'),
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   );


                
//                 }

// // }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class ServicesPage extends StatefulWidget {
// //   @override
// //   State<ServicesPage> createState() => _ServicesPageState();
// // }

// // class _ServicesPageState extends State<ServicesPage> {
// //   var categories = ServicesFeatureCategoryCubit().categories;
// //   Category? selectedCategory;
// //   Color selectColor = Colors.orange;

// //   @override
// //   void initState() {
// //     setState(() {
// //       selectedCategory = categories.isNotEmpty ? categories.first : null;
// //     });
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // backgroundColor: selectColor,
// //       appBar: AppBar(
// //         leading: IconButton(
// //           icon: const Icon(
// //             Icons.arrow_back_ios,
// //             color: Colors.black,
// //           ),
// //           onPressed: () => Navigator.of(context).pop(),
// //         ),
// //         title: Text(
// //           'Services',
// //           style: AppTextStyles.w700.copyWith(fontSize: 20),
// //         ),
// //         centerTitle: true,
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //       ),
// //       body: Column(
// //         children: [
// //           BlocProvider(
// //             create: (BuildContext context) => ServicesFeatureCategoryCubit(),
// //             child: BlocBuilder<ServicesFeatureCategoryCubit,
// //                 ServicesFeatureCategoryStates>(
// //               builder: (context, state) {
// //                 var bloc =
// //                     BlocProvider.of<ServicesFeatureCategoryCubit>(context);
// //                 categories = bloc.categories;
// //                 return SizedBox(
// //                   height: 70,
// //                   width: MediaHelper.width,
// //                   child: ListView.separated(
// //                     scrollDirection: Axis.horizontal,
// //                     padding: const EdgeInsets.only(left: 16),
// //                     physics: const BouncingScrollPhysics(),
// //                     itemBuilder: (context, index) {
// //                       final category = categories[index];
// //                       if (state is Empty) {
// //                         return Container();
// //                       } else if (state is Loading) {
// //                         return Center(child: CircularProgressIndicator());
// //                       } else if (state is Error) {
// //                         return Container();
// //                       } else {
// //                         return GestureDetector(
// //                           child: Container(
// //                             width: 84,
// //                             decoration: BoxDecoration(
// //                               color: Colors.white,
// //                               boxShadow: [
// //                                 BoxShadow(
// //                                   color: Colors.grey.withOpacity(0.4),
// //                                   spreadRadius: 1,
// //                                   blurRadius: 1.4,
// //                                   offset: Offset(1, 2),
// //                                 ),
// //                               ],
// //                               border: (selectedCategory == category)
// //                                   ? Border.all(color: Colors.amber,width: 2)
// //                                   : Border.all(color: Colors.transparent),
// //                               // border: Border.all(
// //                               //     color: selectedCategory == categories[index]
// //                               //         ? selectColor
// //                               //         : Colors.transparent,

// //                               //     width: 2),
// //                               borderRadius: BorderRadius.circular(8.0),
// //                             ),
// //                             child: Center(
// //                               child: Padding(
// //                                 padding: const EdgeInsets.symmetric(
// //                                     vertical: 5, horizontal: 2),
// //                                 child: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.center,
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceAround,
// //                                   children: [
// //                                     Expanded(
// //                                         child: Image.asset(
// //                                       category.imageUrl,
// //                                       fit: BoxFit.cover,
// //                                       height: 50,
// //                                       width: 50,
// //                                     )),
// //                                     Text(
// //                                       category.name,
// //                                       style: TextStyle(
// //                                           fontSize: 14,
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                           onTap: () {
// //                             setState(() {
// //                               selectedCategory = category;
// //                             });
// //                           },
// //                         );
// //                       }
// //                     },
// //                     separatorBuilder: (context, index) =>
// //                         const SizedBox(width: 16),
// //                     itemCount: categories.length,
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //           Expanded(
// //             flex: 2,
// //             child: Container(
// //               padding: EdgeInsets.all(16.0),
// //               child: selectedCategory != null
// //                   ? Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         SizedBox(height: 16.0),
// //                         Expanded(
// //                           child: ListView.separated(
// //                             separatorBuilder: (context, index) => SizedBox(
// //                               height: 18,
// //                             ),
// //                             itemCount: selectedCategory!.products.length,
// //                             itemBuilder: (context, index) {
// //                               final product = selectedCategory!.products[index];

// //                               return Container(
// //                                 width: MediaHelper.width - 20,
// //                                 child: Column(
// //                                   children: [
// //                                     Row(
// //                                       children: [
// //                                         Expanded(
// //                                           child: Stack(
// //                                             children: [
// //                                               Container(
// //                                                 height: 180,
// //                                                 decoration: BoxDecoration(
// //                                                   borderRadius:
// //                                                       BorderRadius.circular(10),
// //                                                   gradient:
// //                                                       LinearGradient(colors: [
// //                                                     Colors.yellow,
// //                                                     Color.fromARGB(
// //                                                         255, 232, 228, 196),
// //                                                     Color.fromARGB(
// //                                                         255, 222, 203, 64),
// //                                                   ]),
// //                                                   image: DecorationImage(
// //                                                       image: AssetImage(
// //                                                           '${product.imageUrl}'),
// //                                                       fit: BoxFit.cover),
// //                                                 ),

// //                                               ),
// //                                               Positioned(
// //                                                 right: 10,
// //                                                 top: 10,
// //                                                 child: CircleAvatar(
// //                                                   radius: 18,
// //                                                   backgroundColor: Colors
// //                                                       .grey.shade100
// //                                                       .withOpacity(0.6),
// //                                                   child: Icon(
// //                                                     Icons.favorite_border,
// //                                                     color: Colors.black,
// //                                                   ),
// //                                                 ),
// //                                               )
// //                                             ],
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                     Container(
// //                                       margin: EdgeInsets.symmetric(
// //                                           vertical: 6, horizontal: 2),
// //                                       child: Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           Text(
// //                                             '${product.name}',
// //                                             style: TextStyle(
// //                                                 fontWeight: FontWeight.w800,
// //                                                 fontSize: 20),
// //                                           ),
// //                                           Text(
// //                                             '\$${product.price.toStringAsFixed(0)}',
// //                                             style: TextStyle(
// //                                                 fontWeight: FontWeight.w800,
// //                                                 fontSize: 20),
// //                                           )
// //                                         ],
// //                                       ),
// //                                     ),
// //                                     Container(
// //                                       margin:
// //                                           EdgeInsets.symmetric(horizontal: 2),
// //                                       child: Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           Row(
// //                                             children: [
// //                                               RatingBar.builder(
// //                                                 initialRating: 3,
// //                                                 minRating: 1,
// //                                                 itemSize: 16,
// //                                                 direction: Axis.horizontal,
// //                                                 allowHalfRating: true,
// //                                                 itemCount: 5,
// //                                                 unratedColor: Colors.grey,
// //                                                 itemPadding:
// //                                                     EdgeInsets.symmetric(
// //                                                         horizontal: 1.0),
// //                                                 itemBuilder: (context, _) =>
// //                                                     Icon(
// //                                                   Icons.star_border,
// //                                                   color: Colors.amber,
// //                                                 ),
// //                                                 onRatingUpdate: (rating) {
// //                                                   // iconn = true;

// //                                                   print(rating);
// //                                                 },
// //                                               ),
// //                                               Text(
// //                                                 '(${product.rating} Ratings)',
// //                                                 style: TextStyle(
// //                                                   color: Colors.black,
// //                                                   fontSize: 15,
// //                                                   overflow: TextOverflow.clip,
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           ),

// //                                           Text('${product.count}',
// //                                               style: TextStyle(
// //                                                   color: Colors.white,
// //                                                   fontWeight: FontWeight.w800,
// //                                                   fontSize: 19)),

// //                                           Text('/${product.tag}')
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //                       ],
// //                     )
// //                   : Center(
// //                       child: Text(
// //                         'Select a category',
// //                         style: TextStyle(fontSize: 20),
// //                       ),
// //                     ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
