import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peto_care/services/servicesFeatures/bloc/service_category_cubit.dart';
import 'package:peto_care/services/servicesFeatures/bloc/state.dart';
import 'package:peto_care/services/servicesFeatures/model/services_list_model.dart';
import 'package:peto_care/utilities/theme/media.dart';

class ServicesPage extends StatefulWidget {
  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  var categories = ServicesFeatureCategoryCubit().categories;
  Category? selectedCategory;
  Color selectColor = Colors.orange;

  @override
  void initState() {
    setState(() {
      selectedCategory = categories.isNotEmpty ? categories.first : null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: selectColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            // color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Services',
          // style: AppTextStyles.w700.copyWith(fontSize: 20),
        ),
       
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: (){},
              child: Icon(Icons.shopping_cart_outlined,
              // size: 26,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          BlocProvider(
            create: (BuildContext context) => ServicesFeatureCategoryCubit(),
            child: BlocBuilder<ServicesFeatureCategoryCubit,
                ServicesFeatureCategoryStates>(
              builder: (context, state) {
                var bloc =
                    BlocProvider.of<ServicesFeatureCategoryCubit>(context);
                categories = bloc.categories;
                print(categories);
                return SizedBox(
                  height: 70,
                  width: MediaHelper.width,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      if (state is Empty) {
                        return Container();
                      } else if (state is Loading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is Error) {
                        return Container();
                      } else {
                        return GestureDetector(
                          child: Container(
                            width: 84,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 1.4,
                                  offset: Offset(1, 2),
                                ),
                              ],
                              border: (selectedCategory == category)
                                  ? Border.all(color: Colors.amber, width: 2)
                                  : Border.all(color: Colors.transparent),
                              // border: Border.all(
                              //     color: selectedCategory == categories[index]
                              //         ? selectColor
                              //         : Colors.transparent,

                              //     width: 2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                      category.imageUrl,
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: 50,
                                    )),
                                    Text(
                                      category.name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        );
                      }
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemCount: categories.length,
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: selectedCategory != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.0),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 18,
                            ),
                            itemCount: selectedCategory!.products.length,
                            itemBuilder: (context, index) {
                              final product = selectedCategory!.products[index];

                              return Container(
                                width: MediaHelper.width - 20,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 180,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Colors.yellow,
                                                    Color.fromARGB(
                                                        255, 232, 228, 196),
                                                    Color.fromARGB(
                                                        255, 222, 203, 64),
                                                  ]),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          product.imageUrl),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              Positioned(
                                                right: 10,
                                                top: 10,
                                                child: CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor: Colors
                                                      .grey.shade100
                                                      .withOpacity(0.6),
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            product.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            '\$${product.price.toStringAsFixed(0)}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              RatingBar.builder(
                                                initialRating: 3,
                                                minRating: 1,
                                                itemSize: 16,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                unratedColor: Colors.grey,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 1.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star_border,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  // iconn = true;

                                                  print(rating);
                                                },
                                              ),
                                              Text(
                                                '(${product.rating} Ratings)',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text('${product.count}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 19)),
                                          Text('/${product.tag}')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        'Select a category',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
