import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/services/favourites/manger/favourite/favourite_cubit.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/favourites/repo/favourite_repo_impl.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/home/widgets/hot_shop.dart';
import 'package:peto_care/services/servicesFeatures/widget/service_widget.dart';
import 'package:peto_care/services/tips/widget/popular_tips_widget.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourite',
          style: AppTextStyles.w700.copyWith(fontSize: 21),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            size: 22,
          ),
          onTap: () => CustomNavigator.pop(),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            FavouriteCubit(FavouriteRepoImpl())..fetchFavorites(),
        child: BlocConsumer<FavouriteCubit, FavouriteState>(
          listener: (context, state) {
            FavouriteCubit favouriteCubit = context.read<FavouriteCubit>();
            if (state is FetchAllFavouriteLoadedState) {
              favouriteCubit.allFavouritesList = state.favouritesList;
            } else if (state is FavoritesLoaded) {
              favouriteCubit.groupedFavorites = state.groupedFavorites;
              favouriteCubit.selectedFeatureType = state.selectedFeatureType;
            }
          },
          builder: (context, state) {
            FavouriteCubit favouriteCubit = context.read<FavouriteCubit>();

            return Container(
              height: MediaHelper.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FeatureType buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: favouriteCubit.groupedFavorites.keys
                            .map((featureType) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: CustomBtn(
                              width: MediaHelper.width * 2 / 7,
                              text: Text(featureType,
                                  style: AppTextStyles.w600.copyWith(
                                      fontSize: 16,
                                      color: featureType ==
                                              favouriteCubit.selectedFeatureType
                                          ? LightTheme().background
                                          : LightTheme().mainColor)),
                              buttonColor: featureType ==
                                      favouriteCubit.selectedFeatureType
                                  ? LightTheme().mainColor
                                  : LightTheme().background,
                              height: 40,
                              radius: 8,
                              borderWidth: 1.7,
                              onTap: () {
                                context
                                    .read<FavouriteCubit>()
                                    .selectFeatureType(featureType);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Display filtered favorites

                  favouriteCubit.selectedFeatureType == FeatureType.Shop.name
                      ? Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: GridView.builder(
                              padding: EdgeInsets.all(4),
                              shrinkWrap:
                                  true, // This makes the GridView take only the required space
                              primary:
                                  false, // Disables the primary scroll for the GridView
                              physics:
                                  NeverScrollableScrollPhysics(), // Avoids scrolling conflicts
                              itemCount: favouriteCubit
                                      .groupedFavorites[
                                          favouriteCubit.selectedFeatureType]
                                      ?.length ??
                                  0,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2 / 2.2,
                                crossAxisCount: 2,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                var item = favouriteCubit.groupedFavorites[
                                    favouriteCubit.selectedFeatureType]![index];
                                return BlocProvider(
                                  create: (context) => FavouriteCubit(
                                      FavouriteRepoImpl())
                                    ..fetchProductDetails(docRef: item.docRef),
                                  child: BlocBuilder<FavouriteCubit,
                                      FavouriteState>(
                                    builder: (context, state) {
                                      if (state
                                          is FetchProductDetailsLoadedState) {
                                        return HotShopWidget(
                                          productItem: state.productItem,
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : favouriteCubit.selectedFeatureType ==
                              FeatureType.Service.name
                          ? Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 18,
                                ),
                                itemCount: favouriteCubit
                                        .groupedFavorites[
                                            favouriteCubit.selectedFeatureType]
                                        ?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  var item = favouriteCubit.groupedFavorites[
                                      favouriteCubit
                                          .selectedFeatureType]![index];

                                  return BlocProvider(
                                    create: (context) =>
                                        FavouriteCubit(FavouriteRepoImpl())
                                          ..fetchProductDetails(
                                              docRef: item.docRef),
                                    child: BlocBuilder<FavouriteCubit,
                                        FavouriteState>(
                                      builder: (context, state) {
                                        if (state
                                            is FetchProductDetailsLoadedState) {
                                          ProductModel item = state.productItem;
                                          return ServicesWidget(item: item);
                                        }
                                        return Container();
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : favouriteCubit.selectedFeatureType ==
                                  FeatureType.Tips.name
                              ? GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 14),
                                  itemCount: favouriteCubit
                                          .groupedFavorites[favouriteCubit
                                              .selectedFeatureType]
                                          ?.length ??
                                      0,
                                  shrinkWrap: true,
                                  primary: false,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 2 / 1.9,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 15.0,
                                          mainAxisSpacing: 15.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var item = favouriteCubit.groupedFavorites[
                                        favouriteCubit
                                            .selectedFeatureType]![index];
                                    return BlocProvider(
                                      create: (context) =>
                                          FavouriteCubit(FavouriteRepoImpl())
                                            ..fetchTipsDetails(
                                                docRef: item.docRef),
                                      child: BlocBuilder<FavouriteCubit,
                                          FavouriteState>(
                                        builder: (context, state) {
                                          if (state
                                              is FetchTipsDetailsLoadedState) {
                                             return PopularTipsWidget(
                                            tipsItem: state.tipItem);
                                          }
                                          return Container();
                                        },
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
