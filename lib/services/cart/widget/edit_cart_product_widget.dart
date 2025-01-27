import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peto_care/services/cart/manger/cart/cart_cubit.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';
import 'package:peto_care/services/cart/widget/color_palate_choose.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_state.dart';
import 'package:peto_care/services/shop_product_details/repo/product_details_repo_impl.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class EditCartProductWidget extends StatelessWidget {
  const EditCartProductWidget(
      {super.key,
      required this.cartItem,
      required this.allCartItems,
      required this.cartCubit});
  final CartModel cartItem;
  final List<CartModel> allCartItems;
  final CartCubit cartCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopProductDetailsCubit(ProductDetailsRepoImpl())
        ..fetchProductDetails(productRef: cartItem.productRef),
      child: BlocConsumer<ShopProductDetailsCubit, ShopProductDetailsStates>(
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
          return Slidable(

            endActionPane: ActionPane(

                motion: const BehindMotion(),
                extentRatio: .15,
                openThreshold: 0.3,

                
                children: [
                  SlidableAction(

                    // spacing: 20,
                    flex: 1,
                    onPressed: (context) {
                      cartCubit.removeFromCart(cartItemDocRef: cartItem.docRef!);
                    },
                    icon: Icons.delete_outline,
                    padding: EdgeInsets.only(right: 10),

                    
                   
                    foregroundColor: Colors.red,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 8, right: 15),
              child: Container(
                width: MediaHelper.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ]),
                //  width: 185,
                height: 100,
                child: Row(
                  spacing: 25,
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
                              "https://digitalreach.asia/wp-content/uploads/2021/11/placeholder-image.png", // Get the first image or an empty string
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    cubit.fetchProductDetails(
                                        productRef: cartItem.productRef);
                                    List<String>? colors = await cubit
                                        .productItem?.colors!
                                        .map((entry) => entry.color.toString())
                                        .toList();

                                    await showAlignedDialog(
                                      context: context,
                                      isGlobal: false,
                                      avoidOverflow: true,
                                      targetAnchor: AlignmentDirectional(1, 1)
                                          .resolve(Directionality.of(context)),
                                      followerAnchor: AlignmentDirectional(0, 0)
                                          .resolve(Directionality.of(context)),
                                      barrierColor: Colors.transparent,
                                      builder: (dialogContext) {
                                        return Material(
                                          color: Colors.transparent,
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: ColorPalateChoose(
                                                colors: colors ?? [],
                                                cartItem: cartItem,
                                                cartCubit: cartCubit,
                                                dialogContext: dialogContext),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      child: Row(
                                        spacing: 6,
                                        children: [
                                          Text(
                                            "Color: ",
                                            style: AppTextStyles.w500.copyWith(
                                                color: LightTheme().greyTitle1,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            spacing: 0,
                                            children: [
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundColor: Color(int.parse(
                                                    '0xFF${cartItem.color}')),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                size: 28,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cartCubit
                                              .incrementAndDecremnetItemCount(
                                                  cartItem: cartItem,
                                                  isIncreament: false,
                                                  itemInStock: cubit
                                                          .productItem?.colors
                                                          ?.firstWhere(
                                                            (element) =>
                                                                element.color ==
                                                                cartItem.color,
                                                          )
                                                          .amount ??
                                                      0);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade500,
                                                      width: 1.2),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Icon(
                                                Icons.remove,
                                                size: 18,
                                              )),
                                        ),
                                      ),
                                      Text(
                                        "${cartItem.count}",
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cartCubit
                                              .incrementAndDecremnetItemCount(
                                                  cartItem: cartItem,
                                                  isIncreament: true,
                                                  itemInStock: cubit
                                                          .productItem?.colors
                                                          ?.firstWhere(
                                                            (element) =>
                                                                element.color ==
                                                                cartItem.color,
                                                          )
                                                          .amount ??
                                                      0);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade500,
                                                      width: 1.2),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Icon(
                                                Icons.add,
                                                size: 18,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
