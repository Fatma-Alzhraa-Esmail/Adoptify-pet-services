import 'package:flutter/material.dart';
import 'package:peto_care/services/home/cubit/product_cubit/product_cubit.dart';
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
    return ShimmerLoading(
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
                  
                  image: NetworkImage(productItem.colors![0].images![0]),
                  fit: BoxFit.cover,
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
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
                            productItem: productItem,
                          ),
                          Text(
                            '(${productItem.rating!.rate} Ratings)',
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
