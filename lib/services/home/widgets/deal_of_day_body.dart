import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/cubit/discount/discount_cubit.dart';
import 'package:peto_care/services/home/widgets/deal_of_the_day.dart';
import 'package:peto_care/utilities/components/component.dart';
import 'package:peto_care/utilities/theme/media.dart';

class DealOFDayBody extends StatelessWidget {
  const DealOFDayBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => DiscountCubit()..fetchAllDiscountedProducts(),
        child: BlocConsumer<DiscountCubit, DiscountState>(
            listener: (BuildContext context, DiscountState state) {
          DiscountCubit discountCubit = context.read<DiscountCubit>();

          if (state is DiscountProductsLoading) {
          } else if (state is DiscountProductsLoaded) {
            discountCubit.discountList = state.products;
          } else if (state is DiscountProductsError) {}
        }, builder: (BuildContext context, DiscountState state) {
          DiscountCubit discountCubit = context.read<DiscountCubit>();
          return Column(
            children: [
              TitleHeadLine('Deal of the Day', 'Views All'),
              ListView.builder(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap:
                    true, // This makes the GridView take only the required space
                primary: false, // Disables the primary scroll for the GridView
              
                itemCount: discountCubit.discountList.length > 3
                    ? 6 // Show a maximum of 6 items
                    : discountCubit.discountList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => DealOFTheDayWidget(
                    productItem: discountCubit.discountList[index]),
              ),
            ],
          );
        }));
  }
}
