import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_state.dart';
import 'package:peto_care/services/shop_product_details/repo/product_details_repo_impl.dart';

class CartProductWidget extends StatelessWidget {
 const CartProductWidget({super.key, required this.cartItem});
  final CartModel cartItem;
  
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
          return Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 8, right: 15),
            child: Container(
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
                                  (element) => element.color == cartItem.color,
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
                            'x${cartItem.count??0}',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Color:"),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 9,
                              backgroundColor: Color(int.parse('0xFF${cartItem.color}')),
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
  }
}
