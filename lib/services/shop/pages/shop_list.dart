import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peto_care/services/shop/bloc/shop_cubit.dart';
import 'package:peto_care/services/shop/bloc/shop_state.dart';
import 'package:peto_care/services/shop/model/shop_model.dart';
import 'package:peto_care/utilities/theme/media.dart';
class ShopFeature extends StatefulWidget {
  @override
  State<ShopFeature> createState() => _ShopFeatureState();
}

class _ShopFeatureState extends State<ShopFeature> {
  var categories = ShopCubit().Categories;
  ShopCategory? selectedCategory;
  Color selectColor = Colors.orange;
  bool iconn = false;
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
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Shop',
        ),
   
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Icon(Icons.filter_alt_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.shopping_cart_outlined,),
          ),
          
        ],
      ),
      body: Column(
        children: [
          BlocProvider(
            create: (BuildContext context) => ShopCubit(),
            child: BlocBuilder<ShopCubit, ShopStates>(
              builder: (context, state) {
                var bloc = BlocProvider.of<ShopCubit>(context);
                categories = bloc.Categories;
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
                                      category.title,
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
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2 / 2.3,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2.0,
                                    mainAxisSpacing: 15.0),
                            itemCount: selectedCategory!.products.length,
                            itemBuilder: (context, index) {
                              final product = selectedCategory!.products[index];

                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 7.5, right: 7.5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1.6,
                                          blurRadius: 1.4,
                                          offset: Offset(0, 2),
                                        ),
                                      ]),
                                  // width: 185,
                                  height: 250,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  iconn = true;
                                                },
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: iconn == true
                                                      ? Colors.red
                                                      : Colors.black,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 75,
                                        height: 75,
                                        child: Image.asset(
                                          product.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18),
                                      ),
                                      RatingBar.builder(
                                        initialRating: product.rating!,
                                        minRating: 1,
                                        itemSize: 17,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        unratedColor: Colors.grey,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star_sharp,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      Text(
                                        '\$${product.price.ceil()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,fontSize: 17),
                                      )
                                    ],
                                  ),
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
