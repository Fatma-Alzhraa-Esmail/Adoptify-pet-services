import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peto_care/handlers/icon_handler.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/cart/widget/add_remove_from_Favourite_widget.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/home/manager/main_faeture_categories/main_feature_categories_cubit.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/components/shimmer/shimmer.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';

class ProductsWidgets extends StatelessWidget {
  const ProductsWidgets({
    super.key,
    required this.mainFeatureCategoriesCubit,
  });

  final MainFeatureCategoriesCubit mainFeatureCategoriesCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShimmerLoading(
        isLoading: mainFeatureCategoriesCubit.productsLoading,
        child: GridView.builder(
          shrinkWrap: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 2.3,
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 15.0),
          itemCount: mainFeatureCategoriesCubit.products.length,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          itemBuilder: (context, index) {
            ProductModel product = mainFeatureCategoriesCubit.products[index];
            return GestureDetector(
              onTap: () => CustomNavigator.push(Routes.shopProductDetails,
                  arguments: product),
              child: Padding(
                padding: const EdgeInsets.only(left: 7.5, right: 7.5),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                           AddRemoveFromFavouriteWidget(productItem: product,featureType: FeatureType.Shop)
                        
                        
                          ],
                        ),
                      ),
                      ShimmerLoading(
                        isLoading: mainFeatureCategoriesCubit.productsLoading,
                        child: Container(
                          width: 75,
                          height: 75,
                          child: Image.network(
                            product.colors![index].images![0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        product.product_name!,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      ShimmerLoading(
                        isLoading: mainFeatureCategoriesCubit.productsLoading,
                        child: RatingBar.builder(
                          initialRating: product.rating!.rate as double,
                          minRating: 0,
                          itemSize: 17,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          unratedColor: LightTheme().mainColor,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.5),
                          itemBuilder: (context, index) {
                            return index < product.rating!.rate!
                                ? drawSvgIcon('star',
                                    iconColor: LightTheme().mainColor)
                                : drawSvgIcon('star_outline',
                                    iconColor: LightTheme().mainColor);
                          },
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      Text(
                        '\$${product.price!.ceil()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
