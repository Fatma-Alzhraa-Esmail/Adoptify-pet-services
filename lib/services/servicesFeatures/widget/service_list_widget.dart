import 'package:flutter/material.dart';
import 'package:peto_care/services/home/manager/main_faeture_categories/main_feature_categories_cubit.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/servicesFeatures/widget/service_widget.dart';
import 'package:peto_care/utilities/components/shimmer/shimmer.dart';

class ServiceListWidget extends StatelessWidget {
  const ServiceListWidget({
    super.key,
    required this.mainFeatureCategoriesCubit,
  });

  final MainFeatureCategoriesCubit mainFeatureCategoriesCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShimmerLoading(
         isLoading: mainFeatureCategoriesCubit.productsLoading,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 18,
          ),
          itemCount:
              mainFeatureCategoriesCubit.products.length,
          itemBuilder: (context, index) {
            ProductModel product =
                mainFeatureCategoriesCubit.products[index];
            
            return ServicesWidget(item: product,);
          },
        ),
      ),
    );
  }
}
