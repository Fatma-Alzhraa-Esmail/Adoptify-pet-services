import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_state.dart';

class shopProductImagesBody extends StatelessWidget {
  const shopProductImagesBody({
    super.key,
    required this.productItemDetails,
  });

  final ProductModel productItemDetails;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopProductDetailsCubit, ShopProductDetailsStates>(
      listener: (context, state) {
        ShopProductDetailsCubit shopProductDetailsCubit =
            BlocProvider.of<ShopProductDetailsCubit>(context);
        if (state is ShopChangeImageIndexState) {
          shopProductDetailsCubit.currentIndex = state.index;
        }
      },
      builder: (context, state) {
        ShopProductDetailsCubit shopProductDetailsCubit =
            BlocProvider.of<ShopProductDetailsCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              CarouselSlider(
                items: productItemDetails
                    .colors![shopProductDetailsCubit.currentImageListIndex]
                    .images
                    ?.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    shopProductDetailsCubit.changeColor(index);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: productItemDetails
                    .colors![shopProductDetailsCubit.currentImageListIndex]
                    .images!
                    .asMap()
                    .entries
                    .map((entry) {
                  return GestureDetector(
                    onTap: () {
                      shopProductDetailsCubit.changeColor(entry.key);
                    },
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: shopProductDetailsCubit.currentIndex == entry.key
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }
}
