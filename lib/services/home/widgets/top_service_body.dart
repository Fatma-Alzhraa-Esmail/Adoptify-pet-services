import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/cubit/product_cubit/product_cubit.dart';
import 'package:peto_care/services/home/widgets/top_services_widget.dart';
import 'package:peto_care/utilities/components/component.dart';
import 'package:peto_care/utilities/theme/media.dart';


class TopServiceBody extends StatelessWidget {
  const TopServiceBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ProductCubit()
          ..fetchAllProducts(mainFeatureId: 'EPhSOJcdIs1ZbaLNQJez'),
        child: BlocConsumer<ProductCubit,
                ProductState>(
            listener:
                (BuildContext context, ProductState state) {
          ProductCubit allProductsCubit =
              context.read<ProductCubit>();
        
          if (state is ProductsLoading) {
          } else if (state
              is ProductsLoaded) {
            allProductsCubit.topServicesProductsList = state.products;
          } else if (state
              is ProductsError) {}
        }, builder:
                (BuildContext context, ProductState state) {
          ProductCubit allProductsCubit =
              context.read<ProductCubit>();
          return allProductsCubit.topServicesProductsList.isNotEmpty ? Column(
            children: [
              TitleHeadLine('Top Service', 'View All'),

              Container(
                height: MediaHelper.height*1/4,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allProductsCubit.topServicesProductsList.length <= 20?allProductsCubit.topServicesProductsList.length:20,
                    itemBuilder: (context, index) => TopServiceWidget(
                          productItem:
                              allProductsCubit.topServicesProductsList[index],
                      allProductsCubit: allProductsCubit   ,    
                        )),
              ),
            ],
          ):Container();
        }));
  }
}
