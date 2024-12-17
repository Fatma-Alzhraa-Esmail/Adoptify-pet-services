import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/manager/hot_shop/hot_shop_cubit.dart';
import 'package:peto_care/services/home/repo/home_repo_impl.dart';
import 'package:peto_care/services/home/widgets/hot_shop.dart';
import 'package:peto_care/utilities/components/component.dart';
class HotShopBody extends StatelessWidget {
  const HotShopBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HotShopCubit(HomeRepoImpl())
        ..fetchHotShopProducts(mainFeatureId: '1jhVopnJFqrORsXv5f0A'),
      child: BlocConsumer<HotShopCubit, HotShopState>(
        listener: (BuildContext context, HotShopState state) {
          HotShopCubit allProductsCubit = context.read<HotShopCubit>();

          if (state is HotShopStateLoading) {
            // Handle loading state
          } else if (state is HotShopStateLoaded) {
            allProductsCubit.hotShopList = state.products;
          } else if (state is HotShopStateError) {
            // Handle error state
          }
        },
        builder: (BuildContext context, HotShopState state) {
          HotShopCubit allProductsCubit = context.read<HotShopCubit>();

          return Column(
            children: [
              TitleHeadLine('Hot Shop', 'View All'),
              Padding(
                 padding: EdgeInsets.symmetric( horizontal: 14),
                child: GridView.builder(
                  padding: EdgeInsets.all(4),
                  shrinkWrap:
                      true, // This makes the GridView take only the required space
                  primary: false, // Disables the primary scroll for the GridView
                  physics:
                      NeverScrollableScrollPhysics(), // Avoids scrolling conflicts
                  itemCount: allProductsCubit.hotShopList.length > 6
                      ? 6 // Show a maximum of 6 items
                      : allProductsCubit.hotShopList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 2.2,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return HotShopWidget(
                      productItem: allProductsCubit.hotShopList[index],
                    );
                  },
                ),
              ),
          
            ],
          );
        },
      ),
    );
  }
}
