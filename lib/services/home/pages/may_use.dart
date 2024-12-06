import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peto_care/services/home/cubit/main_faeture_categories/main_feature_categories_cubit.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';

class MainFeatureCategories extends StatelessWidget {
  const MainFeatureCategories(
    this.id,
    this.selectedCategoryId, {
    super.key,
  });
  final String id;
  final String selectedCategoryId;
  @override
  Widget build(BuildContext context) {
    print("hereeeee223 id: $id   hereeeee223 id: $selectedCategoryId");
    return Scaffold(
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
            child: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          BlocProvider(
            create: (context) => MainFeatureCategoriesCubit()
              ..fetchMainFeaturesProductsBasedCategory(
                  mainFeature: id, mainFeatureCategory: selectedCategoryId),
            child: BlocConsumer<MainFeatureCategoriesCubit,
                MainFeatureCategoriesState>(
              listener: (context, state) {
                var mainFeatureCategoriesCubit =
                    context.read<MainFeatureCategoriesCubit>();
                if (state is MainFeaturesCategoriesSpecificProductsLoaded) {
                  mainFeatureCategoriesCubit.products = state.products;
                  print("From here 1: ${mainFeatureCategoriesCubit.products}");
                } else if (state
                    is MainFeaturesCategoriesSpecificProductsLoading) {
                } else if (state is MainFeaturesChangeSelectedCategory) {}
                if (state is MainFeaturesCategoriesLoaded) {
                } else if (state is MainFeaturesCategoriesLoading) {
                } else if (state is MainFeaturesCategoriesLoaded) {
                } else if (state is MainFeaturesCategoriesLoading) {
                } else if (state
                    is MainFeaturesCategoriesSpecificProductsLoaded) {
                  mainFeatureCategoriesCubit.products = state.products;
                } else if (state
                    is MainFeaturesCategoriesSpecificProductsLoading) {}
              },
              builder: (context, state) {
                return SliverFillRemaining(
                  child: Container(
                    height: MediaHelper.height,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: BlocProvider(
                            create: (BuildContext context) =>
                                MainFeatureCategoriesCubit()
                                  ..fetchMainFeatures(id: id),
                            child: BlocConsumer<MainFeatureCategoriesCubit,
                                MainFeatureCategoriesState>(
                              listener: (context, state) {
                                var mainFeatureCategoriesCubit =
                                    context.read<MainFeatureCategoriesCubit>();

                                if (state is MainFeaturesCategoriesLoaded) {
                                  mainFeatureCategoriesCubit
                                          .mainFeaturesCategoriesList =
                                      state.features;
                                  mainFeatureCategoriesCubit.selectedCategory =
                                      selectedCategoryId;
                                } else if (state
                                    is MainFeaturesCategoriesLoading) {
                                  mainFeatureCategoriesCubit
                                      .changeCurrentCategory(
                                          id: selectedCategoryId);
                                  mainFeatureCategoriesCubit.selectedCategory =
                                      selectedCategoryId;
                                } else if (state
                                    is MainFeaturesChangeSelectedCategory) {
                                  mainFeatureCategoriesCubit.selectedCategory =
                                      state.id;
                                } else if (state
                                    is MainFeaturesCategoriesSpecificProductsLoading) {
                                } else if (state
                                    is MainFeaturesCategoriesSpecificProductsLoaded) {
                                  mainFeatureCategoriesCubit.products =
                                      state.products;
                                } else if (state
                                    is MainFeaturesChangeSelectedCategory) {
                                  mainFeatureCategoriesCubit.selectedCategory =
                                      state.id;
                                }
                              },
                              builder: (context, state) {
                                var mainFeatureCategoriesCubit =
                                    context.read<MainFeatureCategoriesCubit>();

                                return BlocConsumer<MainFeatureCategoriesCubit,
                                    MainFeatureCategoriesState>(
                                  listener: (context, state) {
                                    if (state
                                        is MainFeaturesChangeSelectedCategory) {
                                      mainFeatureCategoriesCubit
                                          .selectedCategory = state.id;
                                    }
                                  },
                                  builder: (context, state) {
                                    return AspectRatio(
                                      aspectRatio: 1.7 / 0.30244,
                                      child: SizedBox(
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final category =
                                                mainFeatureCategoriesCubit
                                                        .mainFeaturesCategoriesList[
                                                    index];

                                            return GestureDetector(
                                              child: AspectRatio(
                                                aspectRatio: 2.7 / 2.4,
                                                child: Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withAlpha(16),
                                                        spreadRadius: 2,
                                                        blurRadius: 1,
                                                        offset: Offset(0.4, 2),
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                        width: category.id ==
                                                                mainFeatureCategoriesCubit
                                                                    .selectedCategory
                                                            ? 2.5
                                                            : 0,
                                                        color: category.id ==
                                                                mainFeatureCategoriesCubit
                                                                    .selectedCategory
                                                            ? LightTheme()
                                                                .mainColor
                                                            : Colors
                                                                .transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Expanded(
                                                            child: SvgPicture
                                                                .network(
                                                          '${category.image}',
                                                          fit: BoxFit.contain,
                                                        )),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          category
                                                              .category_name!,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () async {
                                                await mainFeatureCategoriesCubit
                                                    .changeCurrentCategory(
                                                        id: category.id);
                                                await mainFeatureCategoriesCubit
                                                    .AllOperation(
                                                        id: id,
                                                        categoryId:
                                                            category.id);

                                                // mainFeatureCategoriesCubit
                                                //     .selectedCategory = category.id;
                                              },
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(width: 16),
                                          itemCount: mainFeatureCategoriesCubit
                                              .mainFeaturesCategoriesList
                                              .length,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: BlocConsumer<MainFeatureCategoriesCubit,
                              MainFeatureCategoriesState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              var mainFeatureCategoriesCubit =
                                  context.read<MainFeatureCategoriesCubit>();

                              print(
                                  "Frommmmmmmm Here ${mainFeatureCategoriesCubit.products.isEmpty}");
                              if (state
                                      is MainFeaturesCategoriesAllProductsLoaded ||
                                  state
                                      is MainFeaturesCategoriesSpecificProductsLoaded) {
                                print(
                                    "important:  ${mainFeatureCategoriesCubit.products}");
                                if (mainFeatureCategoriesCubit
                                    .products.isEmpty) {
                                  return Container();
                                } else {
                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 2 / 2.3,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 2.0,
                                            mainAxisSpacing: 15.0),
                                    itemCount: mainFeatureCategoriesCubit
                                        .products.length,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 10),
                                    itemBuilder: (context, index) {
                                      ProductModel product =
                                          mainFeatureCategoriesCubit
                                              .products[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 7.5, right: 7.5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                        child: Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.black,
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              // Container(
                                              //   width: 75,
                                              //   height: 75,
                                              //   child: Image.network(
                                              //     product.colors![0].images![0],
                                              //     fit: BoxFit.cover,
                                              //   ),
                                              // ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                product.product_name!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 18),
                                              ),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                itemSize: 17,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                unratedColor: Colors.grey,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 1.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star_sharp,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              Text(
                                                '40',
                                                // '\$${product.price.ceil()}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                Container();
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
