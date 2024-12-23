import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/cart/manger/cart/cart_cubit.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';
import 'package:peto_care/services/cart/repo/cart_repo_impl.dart';
import 'package:peto_care/services/cart/widget/add_remove_from_Favourite_widget.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/shop_product_details/manger/reivew_cubit/reviews_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_state.dart';
import 'package:peto_care/services/shop_product_details/repo/product_details_repo_impl.dart';
import 'package:peto_care/services/shop_product_details/repo/review_repo_impl.dart';
import 'package:peto_care/services/shop_product_details/widgets/product_colorsList_widget.dart';
import 'package:peto_care/services/shop_product_details/widgets/product_details_header_widget.dart';
import 'package:peto_care/services/shop_product_details/widgets/product_info_widget.dart';
import 'package:peto_care/services/shop_product_details/widgets/shop_product_images_widget.dart';
import 'package:peto_care/services/shop_product_details/widgets/top_reviews_body.dart';
import 'package:peto_care/services/shop_product_details/widgets/write_review_widget.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
class ShopProductDetails extends StatelessWidget {
  const ShopProductDetails({super.key, required this.productItemDetails});
  final ProductModel productItemDetails;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopProductDetailsCubit(ProductDetailsRepoImpl())
        ..selectedColor = productItemDetails.colors![0].color!,
      child: BlocConsumer<ShopProductDetailsCubit, ShopProductDetailsStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
            final ShopProductDetailsCubit shopProductDetailsCubitInstance=BlocProvider.of<ShopProductDetailsCubit>(context);

          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                AddRemoveFromFavouriteWidget(
                  productItem: productItemDetails,featureType: FeatureType.Shop,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.share_outlined,
                  ),
                ),
              ],
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      shopProductImagesBody(
                          productItemDetails: productItemDetails),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            productDetailsHeaderWidget(
                                productItemDetails: productItemDetails),
                            SizedBox(
                              height: 20,
                            ),
                            ProductColorsListWidget(
                                productItemDetails: productItemDetails),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              productItemDetails.description!,
                              style: AppTextStyles.w500
                                  .copyWith(color: LightTheme().greyTitle),
                            ),
                            ProductInfoWidget(
                                productItemDetails: productItemDetails),
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: WriteReviewWidget(
                            productDetails: productItemDetails,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                          child: TopReviewsBody(
                            productItem: productItemDetails,
                          ),
                        ),
                      ],
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
                          child: BlocProvider(
                            create: (context) =>
                                CartCubit(CartRepoImpl())..fetchAllCart(),
                            child: BlocConsumer<CartCubit, CartState>(
                              listener: (context, state) {
                                CartCubit cartCubit = context.read<CartCubit>();
                                if (state is AddCartFailureState) {
                                  print(state.errMessage);
                                } else if (state is AddCartSuccessState) {
                                } else if (state is FetchAllCartLoadingtate) {
                                } else if (state is FetchAllCartLoadedState) {
                                  cartCubit.allCartList = state.cartList;
                                } else if (state is FetchAllCartErrorState) {
                                } else if (state is RemoveCartFailureState) {
                                } else if (state is RemoveCartSuccessState) {}
                              },
                              builder: (context, state) {
                                CartCubit cartCubit = context.read<CartCubit>();

                                bool isCart = cartCubit.allCartList.any(
                                  (isCart) =>
                                      isCart.productRef ==
                                      productItemDetails.docRef,
                                );
                                return CustomBtn(
                                  onTap: () {
                                    if (!isCart) {
                                      cartCubit.addToCart(
                                          cartItem: CartModel(
                                              productRef:
                                                  productItemDetails.docRef,
                                              color:
                                                  shopProductDetailsCubitInstance
                                                      .selectedColor));
                                    } else {
                                      CartModel cartItemDetails =
                                          cartCubit.allCartList.firstWhere(
                                        (isCart) =>
                                            isCart.productRef ==
                                            productItemDetails.docRef,
                                      );

                                      cartCubit.removeFromCart(
                                          cartItemDocRef:
                                              cartItemDetails.docRef!);
                                    }
                                  },
                                  text: !cartCubit.addRemoveIsLoading
                                      ? Text(
                                          !isCart
                                              ? "ADD TO CART"
                                              : "REMOVE FROM CART",
                                          style: AppTextStyles.w700.copyWith(
                                              fontSize: 15,
                                              color: LightTheme().mainColor),
                                        )
                                      : CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ),
                                  radius: 10,
                                  height: 50,
                                  borderColor: LightTheme().mainColor,
                                  buttonColor: LightTheme().background,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomBtn(
                            text: Text(
                              "BUY NOW",
                              style: AppTextStyles.w700.copyWith(
                                  fontSize: 15, color: LightTheme().background),
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
