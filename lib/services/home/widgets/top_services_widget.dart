import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/cart/widget/add_remove_from_Favourite_widget.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/home/manager/top_services/top_services_cubit.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/components/rating_widget.dart';
import 'package:peto_care/utilities/components/shimmer/shimmer.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
class TopServiceWidget extends StatelessWidget {
  const TopServiceWidget({
    required this.productItem,
    required this.allProductsCubit,
    super.key,
  });
  final ProductModel productItem;
  final ProductCubit allProductsCubit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => CustomNavigator.push(Routes.serviceDetails,arguments: productItem),
      child: ShimmerLoading(
        isLoading: allProductsCubit.topServiceproductsLoading,
        child: AspectRatio(
          aspectRatio: 1.61 / 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                  backgroundBlendMode: BlendMode.dstATop,
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.black,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    
                    image: CachedNetworkImageProvider(productItem.colors![0].images![0]),
                    fit: BoxFit.cover,
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withAlpha(160),
                        child: Center(child: AddRemoveFromFavouriteWidget(productItem: productItem,padding: EdgeInsets.all(0),iconSize: 26,featureType: FeatureType.Service,)),
                      ),
                    ),
                   Column(
                    children: [
                       Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${productItem.product_name}',
                            style: AppTextStyles.w600BoxShadow.copyWith(
                                fontSize: 19, fontWeight: FontWeight.w800)),
                        Text('\$${productItem.price!.ceil()}',
                            style: AppTextStyles.w600BoxShadow.copyWith(
                                fontSize: 19, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            RatingsWidget(
                              rate: productItem.rating!.rate!,
                               onDateSelected: (rate) async{
                  return rate;
                },
                            ),
                            Text(
                              '(${productItem.rating!.rate_count} Ratings)',
                              style: AppTextStyles.w600BoxShadow.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          '/${productItem.service_name}',
                          style: AppTextStyles.w600BoxShadow.copyWith(
                              fontSize: 19, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    )
                    ],
                   )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
