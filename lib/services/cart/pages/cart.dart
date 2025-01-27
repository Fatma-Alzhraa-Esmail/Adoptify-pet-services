import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/cart/manger/cart/cart_cubit.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';
import 'package:peto_care/services/cart/pages/cart_edit.dart';
import 'package:peto_care/services/cart/repo/cart_repo_impl.dart';
import 'package:peto_care/services/cart/widget/cart_product.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => CustomNavigator.pop(),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
              title: Text(
                "Cart",
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 14,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CartEditScreen();
                        },
                      )).then(
                        (value) {
                          if (true) {
                            cartCubit.fetchAllCart();
                          }
                        },
                      );
                    },
                    child: Text(
                      "Edit",
                      style: AppTextStyles.w500.copyWith(
                        fontSize: 18,
                        color: LightTheme().mainColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          print("len: ${cartCubit.allCartList.length}");
                          CartModel cartItem = cartCubit.allCartList[index];
                          return CartProductWidget(cartItem: cartItem);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: cartCubit.allCartList.length,
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody:
                          false, // Disable scroll within this section
                      child: Column(
                        children: [
                          Expanded(
                            child:
                                Container(), // This takes up the remaining space
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              spacing: 14,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Divider(
                                  color: Colors.grey.shade400,
                                  height: 2,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      cartCubit.price == 0.0
                                          ? "-"
                                          : "\$${cartCubit.price}",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Delivery",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      cartCubit.delivery != 0.0
                                          ? "${cartCubit.delivery}"
                                          : "-",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Summary",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      (cartCubit.delivery + cartCubit.price) !=
                                              0.0
                                          ? "${(cartCubit.delivery + cartCubit.price)}"
                                          : "-",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                CustomBtn(
                                  buttonColor: LightTheme().mainColor,
                                  height: 55,
                                  text: Text(
                                    "Pay",
                                    style: AppTextStyles.w700.copyWith(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onTap: () {
                                    CustomNavigator.push(Routes.shipping);
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
