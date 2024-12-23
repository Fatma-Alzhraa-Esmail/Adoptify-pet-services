import 'package:flutter/material.dart';
import 'package:peto_care/services/home/manager/main_faeture_categories/main_feature_categories_cubit.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/components/shimmer/shimmer.dart';
import 'product_widget.dart';

class ProductsListWidget extends StatelessWidget {
  const ProductsListWidget({
    super.key,
    required this.mainFeatureCategoriesCubit,
  });

  final MainFeatureCategoriesCubit mainFeatureCategoriesCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShimmerLoading(
        isLoading: mainFeatureCategoriesCubit.productsLoading,
        child: GridView.builder(
          shrinkWrap: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 2.3,
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 15.0),
          itemCount: mainFeatureCategoriesCubit.products.length,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          itemBuilder: (context, index) {
            ProductModel product = mainFeatureCategoriesCubit.products[index];
            return productWiget(product: product, mainFeatureCategoriesCubit: mainFeatureCategoriesCubit);
          },
        ),
      ),
    );
  }
}

