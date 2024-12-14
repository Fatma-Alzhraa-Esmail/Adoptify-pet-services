import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/manager/top_services/top_services_cubit.dart';
import 'package:peto_care/services/home/repo/home_repo_impl.dart';
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
        create: (BuildContext context) => ProductCubit(HomeRepoImpl())
          ..fetchAllProducts(mainFeatureId: 'EPhSOJcdIs1ZbaLNQJez'),
        child: BlocConsumer<ProductCubit,
                TopServicesState>(
            listener:
                (BuildContext context, TopServicesState state) {
          ProductCubit allProductsCubit =
              context.read<ProductCubit>();
        
          if (state is TopServicesStatesLoading) {
          } else if (state
              is TopServicesStatesLoaded) {
            allProductsCubit.topServicesProductsList = state.products;
          } else if (state
              is TopServicesStatesError) {}
        }, builder:
                (BuildContext context, TopServicesState state) {
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
                        ),),
              ),
            ],
          ):Container();
        }));
  }
}
