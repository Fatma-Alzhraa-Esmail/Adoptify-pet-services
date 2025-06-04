import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/address/model/address.dart';
import 'package:peto_care/services/cart/manger/cart/cart_cubit.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';
import 'package:peto_care/services/cart/repo/cart_repo_impl.dart';
import 'package:peto_care/services/shippingFlow/manager/shipping_stepper_cubit/shipping_stepper_cubit.dart';
import 'package:peto_care/services/shippingFlow/models/model.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_state.dart';
import 'package:peto_care/services/shop_product_details/repo/product_details_repo_impl.dart';

import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class ReviewOrder extends StatelessWidget {
  const ReviewOrder({
    super.key,
    required this.selectedAddress,
    required this.selectedPaymentMethod,
    required this.shippingStepperCubit,
  });
  final AddressModel selectedAddress;
  final String selectedPaymentMethod;
  final ShippingStepperCubit shippingStepperCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(CartRepoImpl())..fetchAllCart(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          CartCubit cartCubit = context.read<CartCubit>();
          if (state is FetchAllCartLoadedState) {
            cartCubit.allCartList = state.cartList;
          } else if (state is CalculateTotalPriceLoadedState) {
            cartCubit.price = state.price;
          }
        },
        builder: (context, state) {
          CartCubit cartCubit = context.read<CartCubit>();

          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey.shade300.withOpacity(0.4),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              CartListReadyForShippingWidget(
                                  cartCubit: cartCubit),
                              Row(
                                children: [
                                  Transform.translate(
                                    offset: Offset(-10, 0),
                                    child: Icon(
                                      Icons.circle,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(10, 0),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Shipping Address",
                                      style: AppTextStyles.w600.copyWith(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Column(
                                      spacing: 4,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${selectedAddress.name}",
                                          style: AppTextStyles.w500.copyWith(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "${selectedAddress.location}",
                                          style: AppTextStyles.w400.copyWith(
                                            fontSize: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                          shippingStepperCubit
                                              .changeStepperLevel(index: 0);
                                      },
                                      child: Text(
                                        "Change",
                                        style: AppTextStyles.w500.copyWith(
                                            color: LightTheme().mainColor,
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Transform.translate(
                                    offset: Offset(-10, 0),
                                    child: Icon(
                                      Icons.circle,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(10, 0),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Text(
                                        "Payment Method",
                                        style: AppTextStyles.w600.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Column(
                                        spacing: 4,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                selectedPaymentMethod,
                                                style:
                                                    AppTextStyles.w500.copyWith(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              selectedPaymentMethod ==
                                                      SelectedPaymentMethod
                                                          .card.name
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4, left: 4),
                                                      child: Text(
                                                        "******************",
                                                        style: AppTextStyles
                                                            .w500
                                                            .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          shippingStepperCubit
                                              .changeStepperLevel(index: 1);
                                        },
                                        child: Text(
                                          "Change",
                                          style: AppTextStyles.w500.copyWith(
                                              color: LightTheme().mainColor,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Transform.translate(
                                    offset: Offset(-10, 0),
                                    child: Icon(
                                      Icons.circle,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(10, 0),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              PriceDetailsWidget(cartCubit: cartCubit),
                            ],
                          )))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartListReadyForShippingWidget extends StatelessWidget {
  const CartListReadyForShippingWidget({
    super.key,
    required this.cartCubit,
  });

  final CartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        print("len: ${cartCubit.allCartList.length}");
        CartModel cartItem = cartCubit.allCartList[index];
        return BlocProvider(
          create: (context) => ShopProductDetailsCubit(ProductDetailsRepoImpl())
            ..fetchProductDetails(productRef: cartItem.productRef),
          child:
              BlocConsumer<ShopProductDetailsCubit, ShopProductDetailsStates>(
            listener: (context, state) {
              ShopProductDetailsCubit cubit =
                  context.read<ShopProductDetailsCubit>();
              if (state is ProductDetailsLoaded) {
                cubit.productItem = state.productItem;
              }
            },
            builder: (context, state) {
              ShopProductDetailsCubit cubit =
                  context.read<ShopProductDetailsCubit>();
              return Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 8, right: 15),
                child: Container(
                  // color: Colors.transparent,

                  //  width: 185,
                  height: 100,
                  width: MediaHelper.width,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 75,
                          height: 75,
                          child: CachedNetworkImage(
                            // Fetch the first matching image URL
                            imageUrl: cubit.productItem?.colors
                                    ?.firstWhere(
                                      (element) =>
                                          element.color == cartItem.color,
                                    )
                                    .images
                                    ?.first ??
                                'https://digitalreach.asia/wp-content/uploads/2021/11/placeholder-image.png', // Get the first image or an empty string
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.productItem?.product_name ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18),
                          ),
                          Row(
                            children: [
                              Text(
                                '\$${cubit.productItem?.price}',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 222, 174, 31),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'x${cartItem.count ?? 0}',
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Container(
                            // width: MediaQuery.of(context).size.width - 140,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Color:"),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  radius: 9,
                                  backgroundColor:
                                      Color(int.parse('0xFF${cartItem.color}')),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
      itemCount: cartCubit.allCartList.length,
    );
  }
}

class PriceDetailsWidget extends StatelessWidget {
  const PriceDetailsWidget({
    super.key,
    required this.cartCubit,
  });

  final CartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        spacing: 14,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                cartCubit.price == 0.0 ? "-" : "\$${cartCubit.price}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                cartCubit.delivery != 0.0 ? "${cartCubit.delivery}" : "-",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Summary",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                (cartCubit.delivery + cartCubit.price) != 0.0
                    ? "${(cartCubit.delivery + cartCubit.price)}"
                    : "-",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
