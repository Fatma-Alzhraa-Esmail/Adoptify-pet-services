import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

import '../../../utilities/components/rating_widget.dart';

class productDetailsHeaderWidget extends StatelessWidget {
  const productDetailsHeaderWidget({
    super.key,
    required this.productItemDetails,
  });

  final ProductModel productItemDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productItemDetails.product_name!,
              style: AppTextStyles.w800.copyWith(fontSize: 26),
            ),
            Text(
              "\$${productItemDetails.price!}",
              style: AppTextStyles.w800
                  .copyWith(fontSize: 26, color: LightTheme().mainColor),
            )
          ],
        ),
        Row(
          children: [
            RatingsWidget(
              rate: productItemDetails.rating!.rate!,
              iconSize: 14,
              unratedColor: LightTheme().greyTitle,
              paddingBetweenIcons: 0.5,
              onDateSelected: (rate) async{
                return rate;
              },
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: " ${productItemDetails.rating!.rate} ",
                  style: AppTextStyles.w500),
              TextSpan(
                  text:
                      "(${NumberFormat.decimalPattern().format(productItemDetails.rating!.rate_count)} Ratings)",
                  style: AppTextStyles.w500.copyWith(
                      color: const Color.fromARGB(255, 160, 159, 159),
                      fontSize: 14)),
            ]))
          ],
        )
      ],
    );
  }
}
