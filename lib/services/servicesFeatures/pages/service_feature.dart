// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:pet_services_app/routers/navigator.dart';
// import 'package:pet_services_app/services/servicesFeatures/bloc/cubit.dart';
// import 'package:pet_services_app/services/servicesFeatures/bloc/state.dart';
// import 'package:pet_services_app/services/servicesFeatures/model/service_model.dart';
// import 'package:pet_services_app/services/servicesFeatures/widget/services_features_category.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

// class ServicesFeature extends StatefulWidget {
//   const ServicesFeature({super.key});

//   @override
//   State<ServicesFeature> createState() => _ServicesFeatureState();
// }

// class _ServicesFeatureState extends State<ServicesFeature> {
//   List _category = ServicesFeatureCategoryCubit().getCategories()[0];
//   List _categoryImage = ServicesFeatureCategoryCubit().getCategories()[1];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: InkWell(
//             onTap: () {
//               CustomNavigator.pop();
//             },
//             child: Icon(Icons.arrow_back_ios)),
//         title: Text(
//           'Service',
//           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: GestureDetector(
//               child: Icon(
//                 Icons.shopping_cart_outlined,
//                 size: 28,
//               ),
//               onTap: () {},
//             ),
//           )
//         ],
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body: SafeArea(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//               child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 8,
//                 ),
//                 BlocProvider(
//                   create: (BuildContext context) =>
//                       ServicesFeatureCategoryCubit(),
//                   child: BlocBuilder<ServicesFeatureCategoryCubit,
//                           ServicesFeatureCategoryStates>(
//                       builder: (BuildContext context,
//                           ServicesFeatureCategoryStates state) {
//                     if (state is Empty) {
//                       return Container();
//                     } else if (state is Loading) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (state is Error) {
//                       return Container();
//                     } else {
//                       return Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 90,
//                         // height:  MediaQuery.of(context).size.height,
//                         child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: _category.length,
//                             itemBuilder: (context, index) =>
//                                 ServicesCategoryWidget(
//                                   context,
//                                   _category[index],
//                                   _categoryImage[index],
//                                 )),
//                       );
//                     }
//                   }),
//                 ),


                
//               //  Container(
//               //   height: 200,
//               //   width: 200,
//               //    child: FutureBuilder(
//               //         future: ServicesFeatureCategoryCubit().getProducts(
//               //             widget.category
//               //                 ),
//               //         builder: (ctx, snap) {
//               //           if (snap.hasData) {
//               //             List<ServicesModel> products =
//               //                 snap.data as List<ServicesModel>;
//               //             return ConditionalBuilder(
//               //               condition: products.isNotEmpty,
//               //               builder: (context) {
//               //                 ServicesFeatureCategoryCubit()
//               //                     .getProducts(
//               //                         widget.category);
//               //                 return Expanded(
//               //                   child: ListView.separated(
//               //                       itemBuilder: (context, index) =>
//               //                           buildItem(products[index], context),
//               //                       separatorBuilder: (context, index) =>
//               //                           const SizedBox(
//               //                             height: 20,
//               //                           ),
//               //                       itemCount: products.length),
//               //                 );
//               //               },
//               //               fallback: (context) =>
//               //                   const Center(child: CircularProgressIndicator()),
//               //             );
//               //           }
//               //           return const CircularProgressIndicator();
//               //         }),
//               //  ),
              
//               ],
//             ),
//           ))
//         ],
//       )),
//     );
//   }
// }


////////////////////////


// class ServicesListPage extends StatelessWidget {
//   const ServicesListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           'Services',
//           style: AppTextStyles.w700.copyWith(fontSize: 20),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           // Categories panel
//           BlocProvider(create: (BuildContext context) =>ServicesFeatureCategoryCubit(),
//           child: BlocBuilder<ServicesFeatureCategoryCubit, ServicesFeatureCategoryStates>(
//             builder: (context, state) {
//               var bloc = BlocProvider.of<ServicesFeatureCategoryCubit>(context);
//               return SizedBox(
//                 height: 74,
//                 width: MediaHelper.width,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
//                   physics: const BouncingScrollPhysics(),
//                   itemBuilder: (context, index) => GestureDetector(
//                     // onTap: () => bloc.getSercicesByCategory(index),
//                     onTap: () => bloc.getSercicesByCategory(index),
//                     child: CategoryCard(
//                       isSelected: bloc.selectedCategoryId == index,
//                     ),
//                   ),
//                   separatorBuilder: (context, index) => const SizedBox(width: 16),
//                   itemCount: 5,
//                 ),
//               );
//             },
//           ),
//           ),
//           //============================
//           //============================
//           //============================
//           //============================
//           // Data List

//           Expanded(
//             child: BlocProvider(create: (context) => ServicesFeatureCategoryCubit(),
//             child: BlocBuilder<ServicesFeatureCategoryCubit, ServicesFeatureCategoryStates>(
//               builder: (context, state) {
//                 if (state is Loading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is Error) {
//                   return const Center(child: Text('Error'));
//                 } else if (state is Empty) {
//                   return const Center(child: Text('Empty'));
//                 } else {
//                   var bloc = BlocProvider.of<ServicesFeatureCategoryCubit>(context);
//                   return ListView.separated(
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//                     itemBuilder: (context, index) => PetCard(model: bloc.pets[index]),
//                     separatorBuilder: (context, index) => const SizedBox(height: 16),
//                     itemCount: bloc.pets.length,
//                   );
//                 }
//               },
//             ),

//             )
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ServicesPage extends StatelessWidget {
//   // final List<ServicesModel> services = ServicesModel.CreateServicesFeatureCategoryCard();

//   // final List<ServicesModel> services =
//   //     ServicesModel.CreateServicesFeatureCategoryCard();
//   ServicesPage({this.category, this.categories});
//   var category = ServicesFeatureCategoryCubit().displayCategories();
//   var categories;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Services'),
//       ),
//       body: Column(
//         children: [
//           BlocProvider(
//             create: (BuildContext context) => ServicesFeatureCategoryCubit(),
//             child: BlocBuilder<ServicesFeatureCategoryCubit,
//                 ServicesFeatureCategoryStates>(
//               builder: (context, state) {
//                 var bloc =
//                     BlocProvider.of<ServicesFeatureCategoryCubit>(context);
//                 categories = bloc.displayCategories();
//                 print("categories${categories}");
//                 return SizedBox(
//                   height: 74,
//                   width: MediaHelper.width,
//                   child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
//                     physics: const BouncingScrollPhysics(),
//                     itemBuilder: (context, index) => GestureDetector(
//                       child: Container(
//                         width: 100,
//                         height: 100,
//                         color: Colors.amber,
//                         child: CategoryCard(
//                           categori: categories[index],
//                           isSelected: bloc.selectedCategoryId == index,
//                         ),
//                         // child: Text(categories[index],style: TextStyle(color: Colors.black),),
//                       ),
//                         onTap: () => bloc.getSercicesByCategory(index),
//                     // child: CategoryCard(
//                     //   isSelected: bloc.selectedCategoryId == index,
//                     // ),

//                       // onTap: () => bloc.getSercicesByCategory(index),
//                       // onTap: () => bloc.getSercicesByCategory(index),
//                       // child: CategoryPage(category: category!, products: products)
//                     ),
//                     separatorBuilder: (context, index) =>
//                         const SizedBox(width: 16),
//                     itemCount: categories.length,
//                   ),
//                 );
//               },
//             ),
//           ),

//            Expanded(
//             child: BlocProvider(create: (context) => ServicesFeatureCategoryCubit(),
//             child: BlocBuilder<ServicesFeatureCategoryCubit, ServicesFeatureCategoryStates>(
//               builder: (context, state) {
//                 if (state is Loading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is Error) {
//                   return const Center(child: Text('Error'));
//                 } else if (state is Empty) {
//                   return const Center(child: Text('Empty'));
//                 } else {
//                   var bloc = BlocProvider.of<ServicesFeatureCategoryCubit>(context);
//                   return ListView.separated(
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//                     itemBuilder: (context, index) => PetCard(model: bloc.pets[index]),
//                     separatorBuilder: (context, index) => const SizedBox(height: 16),
//                     itemCount: bloc.pets.length,
//                   );
//                 }
//               },
//             ),

//             )
//           ),
//           // ListView.builder(
//           //   itemCount: services.length,
//           //   itemBuilder: (context, index) {
//           //     final category = services[index].category?.category;
//           //     final products = services.where((service) => service.category?.category == category).toList();

//           //     return GestureDetector(
//           //       onTap: () {
//           //         Navigator.push(
//           //           context,
//           //           MaterialPageRoute(
//           //             builder: (context) => CategoryPage(category: category!, products: products),
//           //           ),
//           //         );
//           //       },
//           //       child: Container(
//           //         padding: EdgeInsets.all(16.0),
//           //         child: Text(category ?? ''),
//           //       ),
//           //     );
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class CategoryPage extends StatelessWidget {
//   final String category;
//   final List<ServicesModel> products;

//   CategoryPage({required this.category, required this.products});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(category),
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];

//           return ListTile(
//             leading: Image.asset(product.image ?? ''),
//             title: Text(product.title ?? ''),
//             subtitle: Text(product.description ?? ''),
//             trailing: Text('\$${product.price ?? ''}'),
//           );
//         },
//       ),
//     );
//   }
// }

// class ServicesPage extends StatefulWidget {
//   @override
//   _ServicesPageState createState() => _ServicesPageState();
// }

// class _ServicesPageState extends State<ServicesPage> {
//   List<ServicesModel> allServices = ServicesModel.CreateServicesFeatureCategoryCard();
//   List<String> categories = [];
//   List<ServicesModel> selectedProducts = [];
//   String selectedCategory = '';

//   @override
//   void initState() {
//     super.initState();
//     categories = extractCategories(allServices);
//   }

//   List<String> extractCategories(List<ServicesModel> services) {
//     List<String> extractedCategories = [];
//     for (var service in services) {
//       if (service.category?.category != null &&
//           !extractedCategories.contains(service.category?.category)) {
//         extractedCategories.add(service.category!.category!);
//       }
//     }
//     return extractedCategories;
//   }

//   List<ServicesModel> extractProductsByCategory(
//       List<ServicesModel> services, String category) {
//     List<ServicesModel> extractedProducts = [];
//     for (var service in services) {
//       if (service.category?.category == category) {
//         extractedProducts.add(service);
//       }
//     }
//     return extractedProducts;
//   }

//   void selectCategory(String category) {
//     setState(() {
//       selectedCategory = category;
//       selectedProducts = extractProductsByCategory(allServices, category);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Page'),
//       ),
//       body: Column(
//         children: [
//           // Display Categories
//           Container(
//             padding: EdgeInsets.all(10.0),
//             child: Row(
//               children: categories
//                   .map(
//                     (category) => Expanded(
//                       child: GestureDetector(
//                         onTap: () => selectCategory(category),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: category == selectedCategory ? Colors.blue : Colors.transparent,
//                             ),
//                           ),
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(category),
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//           // Display Products
//           Expanded(
//             child: ListView.builder(
//               itemCount: selectedProducts.length,
//               itemBuilder: (context, index) {
//                 ServicesModel product = selectedProducts[index];
//                 return ListTile(
//                   title: Text(product.title ?? ''),
//                   subtitle: Text(product.description ?? ''),
//                   // Add more widgets to display other product details
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Category {
//   final String name;
//   final List<ServicesModel> products;

//   Category({required this.name, required this.products});
// }

// List<Category> extractCategories(List<ServicesModel> services) {
//   List<Category> extractedCategories = [];

//   for (var service in services) {
//     if (service.category?.category != null) {
//       // Check if the category already exists
//       var existingCategory = extractedCategories.firstWhereOrNull(
//         (category) => category.name == service.category!.category,
//       );

//       if (existingCategory != null) {
//         // Add the product to the existing category
//         existingCategory.products.add(service);
//       } else {
//         // Create a new category and add the product
//         var newCategory = Category(
//           name: service.category!.category!,
//           products: [service],
//         );
//         extractedCategories.add(newCategory);
//       }
//     }
//   }

//   return extractedCategories;
// }

// class ServicesPage extends StatelessWidget {

//   @override
//    List<Category> categories=extractCategories();

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Categories'),
//       ),
//       body: ListView.builder(
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           var category = categories[index];
//           return ListTile(
//             title: Text(category.name),
//             onTap: () {
//               // Navigate to a new page to show related products
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductsPage(products: category.products),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class ProductsPage extends StatelessWidget {
//   final List<ServicesModel> products;

//   ProductsPage({required this.products});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products'),
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           var product = products[index];
//           return ListTile(
//             title: Text(product.title!),
//             // Display other details of the product as needed
//           );
//         },
//       ),
//     );
//   }
// }

// class ServicesPage extends StatelessWidget {
//   final Category category;

//   ServicesPage({required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(category.name),
//       ),
//       body: Column(
//         children: [
//           Image.network(category.imageUrl),
//           SizedBox(height: 16),
//           Text(
//             'Products',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: category.products.length,
//               itemBuilder: (context, index) {
//                 final product = category.products[index];
//                 return ListTile(
//                   leading: Image.network(product.imageUrl),
//                   title: Text(product.name),
//                   subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


//// another solution
// class CategoriesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CategoryBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Categories'),
//         ),
//         body: Row(
//           children: [
//             Expanded(
//               child: CategoryList(),
//             ),
//             Expanded(
//               flex: 2,
//               child: ProductList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CategoryList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CategoryBloc, CategoryState>(
//       builder: (context, state) {
//         if (state is CategorySelected) {
//           return ListView.builder(
//             itemCount: categories.length,
//             itemBuilder: (context, index) {
//               final category = categories[index];
//               final isSelected = category == state.category;
//               final isFirstCategory = index == 0;

//               return GestureDetector(
//                 onTap: () {
//                   context.read<CategoryBloc>().add(SelectCategoryEvent(category));
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(8.0),
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: isSelected || (isFirstCategory && state.category == null) ? Colors.blue : Colors.grey),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.network(category.imageUrl),
//                       SizedBox(height: 8.0),
//                       Text(
//                         category.name,
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//           return Center(
//             child: Text(
//               'Select a category',
//               style: TextStyle(fontSize: 20),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// class ProductList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CategoryBloc, CategoryState>(
//       builder: (context, state) {
//         if (state is CategorySelected) {
//           return Container(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   state.category.name,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 16.0),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: state.category.products.length,
//                     itemBuilder: (context, index) {
//                       final product = state.category.products[index];
//                      Here is the modified full code with the first category container selected and given a border color by default:

// ```dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
