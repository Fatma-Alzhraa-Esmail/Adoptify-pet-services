import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/servicesFeatures/widget/service_details_body_widget.dart';
import 'package:peto_care/services/servicesFeatures/widget/service_details_header_widget.dart';
import 'package:peto_care/services/shop_product_details/manger/reivew_cubit/reviews_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_state.dart';
import 'package:peto_care/services/shop_product_details/repo/product_details_repo_impl.dart';
import 'package:peto_care/services/shop_product_details/repo/review_repo_impl.dart';
import 'package:peto_care/services/shop_product_details/widgets/product_details_header_widget.dart';
import 'package:peto_care/services/shop_product_details/widgets/top_reviews_body.dart';
import 'package:peto_care/services/shop_product_details/widgets/write_review_widget.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({super.key, required this.productItemDetails});
  final ProductModel productItemDetails;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopProductDetailsCubit(ProductDetailsRepoImpl()),
      child: BlocConsumer<ShopProductDetailsCubit, ShopProductDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ServiceDetailsHeaderWidget(productItemDetails: productItemDetails),
                    
                    
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            productDetailsHeaderWidget(
                                productItemDetails: productItemDetails),
                          
                            Divider(
                              height: 50,
                            ),
                           
                            Text(
                              "Description",
                              style: AppTextStyles.w700.copyWith(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              productItemDetails.description!,
                              style: AppTextStyles.w500
                                  .copyWith(color: LightTheme().greyTitle),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Contact us",
                              style: AppTextStyles.w700.copyWith(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: LightTheme().greyTitle,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  productItemDetails.contactUs!.phone_number!,
                                  style: AppTextStyles.w400.copyWith(
                                      color: LightTheme().greyTitle,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      letterSpacing: 1),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.link_rounded,
                                  color: LightTheme().greyTitle,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                
                                Expanded(
                                    child: Text(
                                  productItemDetails.contactUs!.site_url!,
                                  style: AppTextStyles.w400.copyWith(
                                      color: LightTheme().greyTitle,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      letterSpacing: 1),
                                ))
                              ],
                            ),
                           serviceDetailsBodyWidget(productItemDetails: productItemDetails),
                              Text(
                                "Customer reviews",
                                style: AppTextStyles.w700.copyWith(fontSize: 20),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                BlocProvider(
                  create: (context) => ReviewsCubit(ReviewRepoImpl())
                    ..fetchReviews(
                        productRef: productItemDetails.docRef,
                        productItem: productItemDetails),
                  child: SliverToBoxAdapter(
                    child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      
                        children: [
                        
                         WriteReviewWidget(
                           productDetails: productItemDetails,
                         ),
                        TopReviewsBody(
                          productItem: productItemDetails,
                        ),
                         
                        ],
                      ),
                    ),
                  ),
                ),
              
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Row(
                      children: [
                      
                        Expanded(
                          child: CustomBtn(
                            text: Text(
                              "BOOK NOW",
                              style: AppTextStyles.w700.copyWith(
                                  fontSize: 16, color: LightTheme().background),
                            ),
                            height: 50,
                            radius: 10,
                            borderColor: LightTheme().mainColor,
                            buttonColor: LightTheme().mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            
            
              ],
            ),
          );
        },
      ),
    );
  }
}


