import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_state.dart';

class ProductColorsListWidget extends StatelessWidget {
  const ProductColorsListWidget({
    super.key,
    required this.productItemDetails,
  });

  final ProductModel productItemDetails;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopProductDetailsCubit,
        ShopProductDetailsStates>(
      listener: (context, state) {
        ShopProductDetailsCubit shopProductDetailsCubit =
            BlocProvider.of<ShopProductDetailsCubit>(context);
        if (state is ShopChangeColor) {
          shopProductDetailsCubit.selectedColor = state.color;
        }
      },
      builder: (context, state) {
        ShopProductDetailsCubit shopProductDetailsCubit =
            BlocProvider.of<ShopProductDetailsCubit>(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: productItemDetails.colors!
              .asMap()
              .entries
              .map((entry) {
            final int index = entry.key; // Get the index
            final ColorsModel colorModel =
                entry.value; // Get the color model
            final String colorHex = colorModel.color ?? '000000';
    
            return GestureDetector(
              onTap: () {
                // Pass both the index and colorHex to the cubit
                context
                    .read<ShopProductDetailsCubit>()
                    .selectColor(
                       colorHex,
                       index
                    );
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: shopProductDetailsCubit.selectedColor ==
                          colorHex
                      ? HexColor(colorHex)
                      : Colors.transparent,
                ),
                width: shopProductDetailsCubit.selectedColor ==
                        colorHex
                    ? 44
                    : 41,
                height: shopProductDetailsCubit.selectedColor ==
                        colorHex
                    ? 44
                    : 41,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor(colorHex),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: shopProductDetailsCubit
                                    .selectedColor ==
                                colorHex
                            ? Colors.white
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
